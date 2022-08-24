#ifndef AUDIO_H
#define AUDIO_H

#include <QObject>
extern "C" {
    #include <libavutil/samplefmt.h>
    #include <libavformat/avformat.h>
    #include <libavcodec/avcodec.h>
    #include <libavdevice/avdevice.h>
    #include <libswresample/swresample.h>
    #include <SDL2/SDL.h>
    #include <SDL2/SDL_thread.h>
}

class Audio : public QObject
{
    Q_OBJECT
public:
    explicit Audio(QObject *parent = nullptr);
    ~Audio();
    void init();
    void clear();
    void open(const char* filePath);
    void stop();
    void play();
    void pause();

    int volume(){
        return m_volume;
    }

    //sdl音频播放回调
    static void audioCallBack(void *udata,unsigned char *stream,int len);


    static int decode_audio_thread(void *opa);

signals:

    void volumeChanged(int volume);
    void positionChanged(qint64 position);
    void durationChanged(qint64 duration);

    void playing();
    void paused();
    void stoped();

public slots:

    void seek(qint64 T);
    void setVolume(const int volume){
        if(volume!=m_volume){
            m_volume=volume;
        }
    };

public:
    AVFormatContext *pFormatCtx;
    AVCodecContext *pCodecCtx;
    AVPacket *packet;
    AVCodec *pCodec;
    SwrContext *swrCtx;
    SDL_AudioSpec wanted_spec;

    uint8_t *outBuffer;
    AVSampleFormat m_sampleFmt;
    int m_channels;
    int m_sampleRate;
    int m_samples;
    int m_audioIndex=-1;

    bool isPlay=false;
    bool isSeek=false;
    bool isUpdate=false;
    int cou=0;

    SDL_Thread *pDecodeThread;

    qint64 duration;
    qint64 position;
    int m_volume;


};

#endif // AUDIO_H
