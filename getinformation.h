#ifndef GETINFORMATION_H
#define GETINFORMATION_H

#include <QObject>
#include <QtQml/qqmlregistration.h>
#include <QDebug>
#include <QUrl>
#include <QTime>
class GetInformation : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString title READ title WRITE setTitle NOTIFY titleChanged)
    Q_PROPERTY(QString artist READ artist WRITE setArtist NOTIFY artistChanged)
    Q_PROPERTY(QString album READ album WRITE setAlbum NOTIFY albumChanged)
    Q_PROPERTY(QString genre READ genre WRITE setGenre NOTIFY genreChanged)
    Q_PROPERTY(QString fileUrl READ fileUrl WRITE setFileUrl NOTIFY fileUrlChanged)
    Q_PROPERTY(QUrl picture READ picture WRITE setPicture NOTIFY pictureChanged)
    Q_PROPERTY(int time READ time WRITE setTime NOTIFY timeChanged)

public:
    explicit GetInformation(QObject *parent = nullptr);

signals:
    void succeed();

    void failed();

    void titleChanged();

    void artistChanged();

    void albumChanged();

    void genreChanged();

    void fileUrlChanged();

    void pictureChanged();

    void timeChanged();
public slots:
    void setTitle(QString title){
        m_title = title;
        emit this->titleChanged();
    }

    void setArtist(QString artist){
        m_artist = artist;
        emit this->artistChanged();
    }

    void setAlbum(QString album){
        m_album = album;
        emit this->albumChanged();
    }

    void setGenre(QString genre){
        m_genre = genre;
        emit this->genreChanged();
    }

    void setFileUrl(QString fileUrl){
        m_fileUrl = fileUrl;
        emit this->fileUrlChanged();
    }
    void setPicture(QUrl picture){
        m_picture = picture;
        emit this->pictureChanged();
    }
    void setTime(int time){
        m_time = time;
        emit this->timeChanged();
    }
    void onEndsWith();
public:
    QString title(){
        return m_title;
    }
    QString artist(){
        return m_artist;
    }
    QString album(){
        return m_album;
    }
    QString genre(){
        return m_genre;
    }
    QString fileUrl(){
        return m_fileUrl;
    }
    QUrl picture(){
        return m_picture;
    }
    int time(){
        return m_time;
    }
private:

    void analysisMP3(QString fileUrl);

    void analysisWAV(QString fileUrl);

    void analysisFLAC(QString fileUrl);

    void analysisMP4(QString fileUrl);

    void analysisASF(QString fileUrl);

    void analysisAPE(QString fileUrl);

private:
    QString m_title = "unknown";//标题
    QString m_artist = "unknown";//作者
    QString m_album = "unknown";//专辑
    QString m_genre = "unknown";//类型
    QString m_fileUrl = "";//歌曲地址
    QUrl m_picture;//歌曲封面
    int m_time;//发行时间
};

#endif // GETINFORMATION_H
