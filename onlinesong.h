#ifndef ONLINESONG_H
#define ONLINESONG_H

#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QList>
#include <QObject>

class OnlineSong :public QObject
{
    Q_OBJECT
    Q_PROPERTY(QList<QString> songName READ songName WRITE setSongName NOTIFY songNameChanged)
    Q_PROPERTY(QList<QString> singerName READ singerName WRITE setSingerName NOTIFY singerNameChanged)
    Q_PROPERTY(QList<QString> alumName READ alumName WRITE setAlumName NOTIFY alumNameChanged)
    Q_PROPERTY(QList<double> duration READ duration WRITE setDuration NOTIFY durationChanged)
    Q_PROPERTY(QString url READ url WRITE setUrl NOTIFY urlChanged)
    Q_PROPERTY(QString image READ image WRITE setImage NOTIFY imageChanged)
    Q_PROPERTY(QString lyrics READ lyrics WRITE setLyrics NOTIFY lyricsChanged)

public:
    OnlineSong(QObject *parent=nullptr);


    Q_INVOKABLE void search(QString keyword);
    Q_INVOKABLE void getInformation(int index);


    void parsejson_getIdHash(QString json);
    void parsejson_getinformation(QString json);

    void clear();

    void setAlumId(QList<QString> newAlumId)
    {
        if(alumId!=newAlumId){
            alumId=newAlumId;
        }
    }
    void setFileHash(QList<QString> newFileHash)
    {
        if(fileHash!=newFileHash){
            fileHash=newFileHash;
        }
    }
    QList<QString> songName() const
    {
        return m_songName;
    }
    QList<QString> singerName() const
    {
        return m_singerName;
    }
    QList<QString> alumName() const
    {
        return m_alumName;
    }
    QList<double> duration()const
    {
        return m_duration;
    }
    QString url()const
    {
        return m_url;
    }
    QString image()const
    {
        return m_image;
    }
    QString lyrics()const
    {
        return m_lyrics;
    }


public slots:
    void setSongName(QList<QString> songName)
    {
         if(m_songName!=songName){
             m_songName=songName;
             emit songNameChanged(m_songName);
         }
    }
    void setSingerName(QList<QString> singerName)
    {
        if(m_singerName!=singerName){
            m_singerName=singerName;
            emit singerNameChanged(m_singerName);
        }
    }
    void setAlumName(QList<QString> alumName)
    {
        if(m_alumName!=alumName){
            m_alumName=alumName;
            emit alumNameChanged(m_alumName);
        }
    }
    void setDuration(QList<double> duration)
    {
        if(m_duration!=duration){
            m_duration=duration;
            emit durationChanged(m_duration);
        }
    }
    void setUrl(QString url)
    {
        if(m_url!=url){
            m_url=url;
            emit urlChanged(m_url);
        }
    }
    void setImage(QString image)
    {
        if(m_image!=image){
            m_image=image;
            emit imageChanged(m_image);
        }
    }
    void setLyrics(QString lyrics)
    {
        if(m_lyrics!=lyrics)
            m_lyrics=lyrics;
            emit lyricsChanged(m_lyrics);
    }

protected slots:
    void replyFinished(QNetworkReply *reply);
    void replyFinished2(QNetworkReply *reply);

signals:
    void songNameChanged(QList<QString> songName);
    void singerNameChanged(QList<QString> singerName);
    void alumNameChanged(QList<QString> alumName);
    void durationChanged(QList<double> duration);
    void urlChanged(QString url);
    void imageChanged(QString image);
    void lyricsChanged(QString lyrics);

private:
    QNetworkAccessManager *manager;
    QNetworkRequest *request;           //通过该请求获取alumId和fileHash
    QNetworkAccessManager *manager2;
    QNetworkRequest *request2;          //通过该请求获取歌曲url和歌词数据
    QList<QString> alumId;
    QList<QString> fileHash;
    QList<QString> m_singerName;
    QList<QString> m_songName;
    QList<QString> m_alumName;
    QList<double> m_duration;
    QString m_url;
    QString m_image;
    QString m_lyrics;
};

#endif // ONLINESONG_H
