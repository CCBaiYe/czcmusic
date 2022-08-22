#include "audioplay.h"

AudioPlay::AudioPlay(QObject *parent ):QObject{parent}
{

    _audio=new Audio;
    setVolume(100);

    connect(this,&AudioPlay::sourceChanged,this,[&](){
        QByteArray temp = m_source.toString().toLocal8Bit();
        const char *str = temp.constData();
        _audio->open(str);
        m_state=AudioPlay::PlayingState;
//        play();
    });

    connect(_audio,&Audio::positionChanged,this,[&](qint64 temp){
        m_position=temp;
//        qDebug()<<m_position<<"\n";
        if(!_audio->isSeek){

            emit positionChanged(m_position);
        }

    });

    connect(_audio,&Audio::durationChanged,this,&AudioPlay::setDuration);
    connect(_audio,&Audio::playing,this,[&](){
        m_state=AudioPlay::PlayingState;
        emit playbackStateChanged(m_state);
    });
    connect(_audio,&Audio::paused,this,[&](){
        m_state=AudioPlay::PausedState;
        emit playbackStateChanged(m_state);
    });
    connect(_audio,&Audio::stoped,this,[&](){
        m_state=AudioPlay::StoppedState;
        emit playbackStateChanged(m_state);
    });

}
void AudioPlay::play()
{
    _audio->play();

}


void AudioPlay::pause()
{
    _audio->pause();


}
void AudioPlay::stop()
{
    _audio->stop();

}
