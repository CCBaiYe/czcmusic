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
    Q_PROPERTY(QList<QString> songName READ songName WRITE setName NOTIFY songNameChanged)
    Q_PROPERTY(QList<QString> songArtist READ songArtist WRITE setArtist NOTIFY songArtistChanged)
    Q_PROPERTY(QList<QString> songAlbum READ songAlbum WRITE setAlbum NOTIFY songAlbumChanged)
    Q_PROPERTY(QList<QString> songTime READ songTime WRITE setTime NOTIFY songTimeChanged)
    Q_PROPERTY(QList<QString> songPath READ songPath WRITE setPath NOTIFY songPathChanged)
    Q_PROPERTY(QString songListName READ songListName WRITE setSongListName NOTIFY songListNameChanged)
    Q_PROPERTY(QList<QString> tableNames READ tableNames WRITE setTableNames NOTIFY tableNamesChanged)
    //Q_PROPERTY(QString data READ data WRITE setData NOTIFY dataChanged)
public:
    explicit SongList(QObject *parent=nullptr);

signals:
    void songNameChanged();
    void songArtistChanged();
    void songAlbumChanged();
    void songTimeChanged();
    void songPathChanged();
    void songListNameChanged(QString songlistname);
    void tableNamesChanged();

public slots:

    Q_INVOKABLE void deleteTable(QString tableName);

    Q_INVOKABLE void inSert(QString tableName,QString songname,QString songpath,QString songartist,QString album,QString time);

    Q_INVOKABLE void deleteData(QString tableName,QString songName);

    Q_INVOKABLE void querySongDatas(QString tableName);

    Q_INVOKABLE void createlist(QString tableName);

    void readSongListTables();



    void setName(QList<QString> songName){
        m_songName=songName;
        emit this->songNameChanged();
    }

    void setSongListName(QString songListName){
        m_songListName=songListName;
        emit songListNameChanged(m_songListName);
    }

    void setArtist(QList<QString> songArtist){
        m_songArtist=songArtist;
        emit this->songArtistChanged();
    }

    void setAlbum(QList<QString> songAlbum){
        m_songAlbum=songAlbum;
        emit this->songAlbumChanged();
    }

    void setTime(QList<QString> songTime){
        m_songTime=songTime;
        emit this->songTimeChanged();
    }

    void setPath(QList<QString> songPath){
        m_songPath=songPath;
        emit this->songPathChanged();
    }
    void setTableNames(QList<QString> tableNames){
        m_tableNames=tableNames;
        emit tableNamesChanged();
    }


public:
    QList<QString> songName(){
        return m_songName;
    }
    QList<QString> songArtist(){
        return m_songArtist;
    }
    QList<QString> songAlbum(){
        return m_songAlbum;
    }
    QList<QString> songTime(){
        return m_songTime;
    }
    QList<QString> songPath(){
        return m_songPath;
    }
    QString songListName()
    {
        return m_songListName;
    }
    QList<QString> tableNames(){
        return m_tableNames;
    }


private:
    DataBase *songDB;
    QString m_songListName;//歌单名
    QList<QString> m_tableNames;
    QList<songinfo> m_data;//模型
    QList<QString> m_songName;//歌曲名字
    QList<QString> m_songArtist;//歌曲作者
    QList<QString> m_songAlbum;//歌曲专辑
    QList<QString> m_songTime;//歌曲时间
    QList<QString> m_songPath;//歌曲路径
};

#endif // SONGLIST_H
