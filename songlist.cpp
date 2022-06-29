#include "songlist.h"
#include"database.h"
#include<QStringListModel>
SongList::SongList(QObject *parent)
    : QObject{parent}
{
    songDB=new DataBase();
    songDB->openDb();
    readSongListTables();



}

void SongList::deleteData(QString tableName,QString songName){//删除歌曲

    songDB->openDb();
    if(songDB->isTableExist(tableName)){
        songDB->deleteData(songName);
        qDebug()<<"delete successfully!";
    }else{
        qDebug()<<"dont't find "+tableName+"table!"+" delete failed! ";
    }
    songDB->closeDb();

}

void SongList::deleteTable(QString tableName)//删除歌单
{

    songDB->openDb();
    if(songDB->isTableExist(tableName)){
        songDB->deleteTable(tableName);
        qDebug()<<"delete successfully!";
    }else{
        qDebug()<<"dont't find "+tableName+"table!"+" delete failed! ";
    }
    songDB->closeDb();

}
void SongList::inSert(QString tableName,QString songname,QString songpath,QString songartist,QString album,QString time){//插入歌曲

    songDB->openDb();
    if(songDB->isTableExist(tableName)){
        songinfo var;
        var.songName=songname;
        var.songAlbum=album;
        var.songTime=time;
        var.songArtist=songartist;
        var.songPath=songpath;

        songDB->singleInsertData(var,tableName);
    }else{
        qDebug()<<"dont't find "+tableName+"table!";
    }
    songDB->closeDb();
}

void SongList::createlist(QString tableName)//创建歌单
{

    m_songListName=tableName;
    m_tableNames.push_back(tableName);
    songDB->openDb();
    songDB->createTable(tableName);
    songDB->closeDb();

}

void SongList::readSongListTables()
{
    m_tableNames=songDB->readTables();

}



void SongList::querySongDatas(QString tableName)//获取歌单
{

    songDB->openDb();
    if(songDB->isTableExist(tableName)){
        songDB->queryTable(tableName,m_songName,m_songArtist,m_songAlbum,m_songTime,m_songPath);
    }else{
        qDebug()<<"dont't find "+tableName+"table!";

    }
    songDB->closeDb();

}
