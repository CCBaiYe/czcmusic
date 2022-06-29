#ifndef SONGLIST_H
#define SONGLIST_H

#include <QObject>
#include <QtQml/qqmlregistration.h>
#include <QDebug>
#include <QUrl>
#include<QStringListModel>
#include<QAbstractListModel>
#include<QList>
#include"database.h"

class SongList:public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString songName READ songName WRITE setName NOTIFY songNameChanged)
    Q_PROPERTY(QString songArtist READ songArtist WRITE setArtist NOTIFY songArtistChanged)
    Q_PROPERTY(QString songAlbum READ songAlbum WRITE setAlbum NOTIFY songAlbumChanged)
    Q_PROPERTY(QString songTime READ songTime WRITE setTime NOTIFY songTimeChanged)
    Q_PROPERTY(QString songPath READ songPath WRITE setPath NOTIFY songPathChanged)
    //Q_PROPERTY(QString data READ data WRITE setData NOTIFY dataChanged)
public:
    explicit SongList(QObject *parent=nullptr);

signals:
    void songNameChanged();
    void songArtistChanged();
    void songAlbumChanged();
    void songTimeChanged();
    void songPathChanged();

public slots:

    void deleteTable(QString tableName);

    void inSert(QString tableName,QStringList data);

    void deleteData(QString tableName,QString songName);

    QList<songinfo> querySongDatas(QString tableName);

    int rowCount(){
        return m_data.count();
    }

    void createlist(QString tableName);

    void setName(QString songName){
        m_songName=songName;
        emit this->songNameChanged();
    }

    void setArtist(QString songArtist){
        m_songArtist=songArtist;
        emit this->songArtistChanged();
    }

    void setAlbum(QString songAlbum){
        m_songAlbum=songAlbum;
        emit this->songAlbumChanged();
    }

    void setTime(QString songTime){
        m_songTime=songTime;
        emit this->songTimeChanged();
    }

    void setPath(QString songPath){
        m_songPath=songPath;
        emit this->songPathChanged();
    }


public:
    QString songName(){
        return m_songName;
    }
    QString songArtist(){
        return m_songArtist;
    }
    QString songAlbum(){
        return m_songAlbum;
    }
    QString songTime(){
        return m_songTime;
    }
    QString songPath(){
        return m_songPath;
    }


private:
    QList<songinfo> m_data;//模型
    QString m_songName="undefined";//歌曲名字
    QString m_songArtist="undefined";//歌曲作者
    QString m_songAlbum="undefined";//歌曲专辑
    QString m_songTime="undefined";//歌曲时间
    QString m_songPath="undefined";//歌曲路径
};

#endif // SONGLIST_H
