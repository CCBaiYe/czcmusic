#ifndef AUDIOPLAY_H
#define AUDIOPLAY_H

#include <QObject>
#include <QUrl>
#include "audio.h"

class AudioPlay: public QObject
{
    Q_OBJECT
    Q_PROPERTY(QUrl source READ source WRITE setSource NOTIFY sourceChanged)
    Q_PROPERTY(qint64 duration READ duration WRITE setDuration NOTIFY durationChanged)
    Q_PROPERTY(qint64 position READ position WRITE setPosition NOTIFY positionChanged)
    Q_PROPERTY(int loops READ loops WRITE setLoops NOTIFY loopsChanged)
    Q_PROPERTY(PlaybackState playbackState READ playbackState NOTIFY playbackStateChanged)
    Q_PROPERTY(bool muted READ muted WRITE setMuted NOTIFY mutedChanged)
    Q_PROPERTY(int volume READ volume WRITE setVolume NOTIFY volumeChanged)
    Q_PROPERTY(bool seekable READ isSeekable NOTIFY seekableChanged)

public:
    explicit AudioPlay(QObject *parent = nullptr);
    enum PlaybackState
      {
          StoppedState,
          PlayingState,
          PausedState
      };
      Q_ENUM(PlaybackState)

    enum Loops
        {
            Infinite = -1,
            Once = 1
        };
        Q_ENUM(Loops)

signals:
    void sourceChanged(QUrl source);
    void durationChanged(qint64 duration);
    void positionChanged(qint64 position);
    void loopsChanged();
    void playbackStateChanged(AudioPlay::PlaybackState newState);
    void mutedChanged(bool newmuted);
    void seekableChanged(bool seekable);
    void volumeChanged(int volume);
public slots:
    void setSource(const QUrl &source)
    {
        m_source=source;
        _audio->isUpdate=true;
        emit this->sourceChanged(m_source);
    }
    void setDuration(qint64 inDuration){
        if(inDuration!=m_duration){
            m_duration = inDuration;
            emit this->durationChanged(m_duration);
        }

    }
    void setPosition(qint64 inPosition)
    {
//        if(!_audio->isSeek){
//            return;
//        }
//        m_position= _audio->seek(inPosition);

//        emit this->positionChanged(m_position);

        if(_audio->isSeek){
            return;
        }
        m_position=inPosition;
        _audio->position=m_position;
        _audio->seek(_audio->position);
        emit this->positionChanged(m_position);


    }
    void setLoops(int loops)
    {
        m_loops=loops;
        if(m_loops==-1){
            setSource(m_source);
        }
        emit this->loopsChanged();
    }
    void setMuted(bool muted){
        if(muted)
        {
            m_muted=muted;
            _audio->setVolume(0);
        }else{
            m_muted=muted;
            _audio->setVolume(100);
        }
        emit this->mutedChanged(m_muted);
    }
    void setVolume(int volume)
    {
        if(volume!=m_volume){
            m_volume=volume;
            _audio->m_volume=m_volume;
            emit this->volumeChanged(m_volume);
        }

    }
    void play();
    void pause();
    void stop();
public:
    QUrl source()const{
        return m_source;
    }
    qint64 duration()const
    {
        return m_duration;
    }
    qint64 position()const{
        return m_position;
    }
    int loops()const{
        return m_loops;
    }
    AudioPlay::PlaybackState playbackState() const{
        return m_state;
    }

    bool muted()const{
        return m_muted;
    }
    int volume()const
    {
        return m_volume;
    }
    bool isSeekable()const{
        return _audio->isSeek;
    }
private:
    Audio *_audio;
    QUrl m_source;
    qint64 m_duration;
    qint64 m_position;
    int m_loops;//循环
    bool m_muted=false;//静音
    int m_volume;//音量
    AudioPlay::PlaybackState m_state;
};

#endif // AUDIOPLAY_H
