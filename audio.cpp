#include "audio.h"
#include <QtDebug>

Audio::Audio(QObject *parent)
    : QObject{parent}
{

}

Audio::~Audio()
{

    SDL_WaitThread(pDecodeThread,NULL);
    SDL_Quit();
    clear();
}
//缓冲区

static Uint8 *audio_chunk;
static Uint32 audio_len;
static Uint8 *audio_pos;

int Audio::decode_audio_thread(void *opa)
{

    while(1)
    {

        Audio *a=(Audio *)opa;
        if(a->isUpdate){
            continue;
        }
        AVFrame *pframe;
        //一帧一帧读取压缩的音频数据
        while(av_read_frame(a->pFormatCtx,a->packet)>=0){
            pframe=av_frame_alloc();

            if(a->packet->stream_index==a->m_audioIndex){
                //向解码器发送要解码的数据
                if(avcodec_send_packet(a->pCodecCtx,a->packet)!=0){
                    printf("error avcodec_send_packet \n");
                    exit(0);
                }


                a->position = av_q2d(a->pFormatCtx->streams[a->m_audioIndex]->time_base) * a->packet->pts * 1000;
                emit a->positionChanged(a->position);


                //获取解码后的帧数据
                if(avcodec_receive_frame(a->pCodecCtx,pframe)==0){


                    int len=swr_convert(a->swrCtx, &a->outBuffer,  2*44100, (const uint8_t**) pframe->data, pframe->nb_samples);

                    //获取sample的size
                    int outBufferSize = len * a->m_channels * av_get_bytes_per_sample(a->m_sampleFmt);

                    //设置音频缓冲区
                    audio_chunk = (Uint8*)a->outBuffer;

                    //音频缓冲区长度
                    audio_len = outBufferSize;
                    audio_pos = audio_chunk;


                    //延时等待播放
                    while (audio_len > 0)
                        SDL_Delay(1);


                }


                if(!a->isPlay){
                    SDL_PauseAudio(1);
                    emit a->paused();
                }else{
                    emit a->playing();
                }

            }
            if(a->isSeek){
                //            avcodec_flush_buffers(a->pCodecCtx);
                //            av_packet_unref(a->packet);
                av_frame_free(&pframe);
                //            continue;
                SDL_Delay(100);
            }

            av_packet_unref(a->packet);

        }

        av_frame_free(&pframe);
    }


    return 0;
}


void Audio::init()
{
    //分配解复用器上下文内存
     pFormatCtx=avformat_alloc_context();
     if(!pFormatCtx){
         printf("error can't create allocate context \n");
         return;
     }

     //分配解码器上下文内存
     pCodecCtx=avcodec_alloc_context3(NULL);
     if(!pCodecCtx){
         printf("error avcodec_alloc_context3: \n");
         return ;
     }
     //分配重采样上下文
     swrCtx = swr_alloc();


     //分配数据包内存
     packet=av_packet_alloc();

     //初始化SDL
     if(SDL_Init(SDL_INIT_AUDIO | SDL_INIT_TIMER)) {
         printf( "Could not initialize SDL - %s\n", SDL_GetError());
         return ;
     }

     outBuffer=(uint8_t *)av_malloc(2*44100);

}

void Audio::clear()
{
    if(wanted_spec.channels)
    SDL_CloseAudio();//关闭音频设备
    if(outBuffer)
    av_free(outBuffer);
    if(swrCtx)
    swr_free(&swrCtx);
    if(pCodecCtx)
    avcodec_close(pCodecCtx);
    if(pFormatCtx)
    avformat_close_input(&pFormatCtx);

}

void Audio::open(const char *filePath)
{

    cou++;
    if(cou>1){
       clear();
    }
    init();

    int ret;
    //根据url打开码流，并分析选择匹配的解复用器
    ret=avformat_open_input(&pFormatCtx,filePath,NULL,NULL);
    if(ret!=0){
        qDebug()<<"error avformat_open_input: ";
        return ;
    }

    //读取文件的数据获取流信息
    ret=avformat_find_stream_info(pFormatCtx,NULL);
    if(ret<0){
        qDebug()<<"error avformat_find_stream_info: \n";
        return ;
    }

    //获取音频流编号
    m_audioIndex=av_find_best_stream(pFormatCtx,AVMEDIA_TYPE_AUDIO,-1,-1,NULL,0);
    if(m_audioIndex==-1){
        qDebug()<<"error don't find a audio stream\n";
        return ;
    }

    duration = pFormatCtx->duration / 1000;
    emit durationChanged(duration);

    //将流中解码器需要的信息AVcodecparameters拷贝到解码器上下文
    ret=avcodec_parameters_to_context(pCodecCtx,pFormatCtx->streams[m_audioIndex]->codecpar);
    if(ret<0){
        qDebug()<<"error avcodec_parameters_to_context: \n";
        return ;
    }

    //通过解码器id找到解码器
    pCodec=const_cast<AVCodec *>(avcodec_find_decoder(pCodecCtx->codec_id));
    if(pCodec==NULL){
       qDebug()<<"error audio codec not found \n";
       return ;
    }

    //初始化打开解码器
    avcodec_open2(pCodecCtx,pCodec,NULL);

    //文件信息
    qDebug()<<"--------------- File Information ----------------\n";
    av_dump_format(pFormatCtx, 0, filePath, 0);
    qDebug()<<"-------------------------------------------------\n";

    pCodecCtx->pkt_timebase=pFormatCtx->streams[m_audioIndex]->time_base;

    //转为16bit 44100 PCM统一音频采样格式与采样率
    //重采样设置选项
    //输入的采样格式
    AVSampleFormat inSampleFmt = pCodecCtx->sample_fmt;
    //输出的采样格式
    m_sampleFmt = AV_SAMPLE_FMT_S16;
    //输入的采样率
    int inSampleRate = pCodecCtx->sample_rate;
    //输出的采样率
    m_sampleRate = 44100;
    //输出的采样位
    m_samples=pCodecCtx->frame_size;
    if(m_samples==0){
        m_samples=1024;
    }
    //输入的声道布局
    //部分解码器AVCodecContext中的channel_layout没有进行初始化。会导致SwrContext初始化失败。改为通过channels（一定会初始化）计算channel_layout而不是直接取channel_layout的值
    uint64_t inChannelLayout = av_get_default_channel_layout(pCodecCtx->channels);
    //输出的声道布局
    uint64_t outChannelLayout = AV_CH_LAYOUT_STEREO;

//    qDebug()<<"inSampleFmt = "<<inSampleFmt<<", inSampleRate = "<<inSampleRate<<", inChannelLayout ="<< (int) inChannelLayout<<"， codecName = "<<pCodec->name<<"\n";


    swr_alloc_set_opts(swrCtx, outChannelLayout, m_sampleFmt, m_sampleRate,
                       inChannelLayout, inSampleFmt, inSampleRate, 0, NULL);



    swr_init(swrCtx);
    //重采样设置选项

    //获取输出的声道个数
    m_channels = av_get_channel_layout_nb_channels(outChannelLayout);
//    qDebug()<<"outChannelNb = "<<m_channels<<"\n";



     wanted_spec.channels=m_channels;
     wanted_spec.freq=m_sampleRate;
     wanted_spec.format=AUDIO_S16SYS;
     wanted_spec.silence = 0;
     wanted_spec.samples =m_samples;
     wanted_spec.callback=audioCallBack;
     wanted_spec.userdata=this;

     //打开音频设备
     if (SDL_OpenAudio(&wanted_spec, NULL) < 0){
         qDebug()<<"could not open audio.\n" ;
         return ;
     }



     //音频相关信息
//     qDebug()<<"Bitrate:\t "<<pFormatCtx->bit_rate;
//     qDebug()<<"Decoder Name:\t "<< pCodecCtx->codec->long_name;
//     qDebug()<<"Channels:\t "<<pCodecCtx->channels;
//     qDebug()<<"Sample per Second\t "<< pCodecCtx->sample_rate;

     //开始播放
     SDL_PauseAudio(0);

     isPlay=true;

    if(cou==1){
        pDecodeThread=SDL_CreateThread(decode_audio_thread,"decode_audio_thread",this);

    }

    isUpdate=false;
}

void Audio::stop()
{
//    clear();
    //do something...
    emit stoped();
}




void Audio::play()
{
    if(!isPlay){
        isPlay=true;
        SDL_PauseAudio(0);
    }


}

//回调函数
//回调函数的作用是填充音频缓冲区，当音频设备需要更多数据的时候会调用该回调函数
void Audio::audioCallBack(void *udata, unsigned char *stream, int len)
{
    Audio *a=(Audio *)udata;

    SDL_memset(stream, 0, len);

    if (audio_len == 0)        /*  数据未读完才执行  */
        return;
    int temp = (len>audio_len ? audio_len : len);

    SDL_MixAudioFormat(stream,audio_pos,AUDIO_S16SYS,temp,a->m_volume);

    audio_pos += temp;
    audio_len -= temp;
    stream+=temp;
    len-=temp;
}


void Audio::pause()
{
    if(isPlay){
        isPlay=false;
    }

}

qint64 Audio::seek(qint64 T)
{
    isSeek=true;
    isPlay=false;
    qDebug()<<"1";
    SDL_PauseAudio(1);
    SDL_Delay(200);
    av_seek_frame(pFormatCtx,m_audioIndex,(T/1000)/av_q2d(pCodecCtx->time_base),AVSEEK_FLAG_BACKWARD);
    isPlay=true;
    SDL_PauseAudio(0);
    isSeek=false;
    return T;
}
