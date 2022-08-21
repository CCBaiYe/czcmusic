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
//    connect(_audio,&Audio::playing,this,[&](){
//        m_state=AudioPlay::PlayingState;
//    });
//    connect(_audio,&Audio::paused,this,[&](){
//        m_state=AudioPlay::PausedState;
//    });
//    connect(_audio,&Audio::stoped,this,[&](){
//        m_state=AudioPlay::StoppedState;
//    });

}
void AudioPlay::play()
{
    _audio->play();
    m_state=AudioPlay::PlayingState;
}


void AudioPlay::pause()
{
    _audio->pause();
    m_state=AudioPlay::PausedState;

}
void AudioPlay::stop()
{
    _audio->stop();
    m_state=AudioPlay::StoppedState;
}
