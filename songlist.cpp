#include "songlist.h"
#include"database.h"
#include<QStringListModel>
SongList::SongList(QObject *parent)
    : QObject{parent}
{

}

void SongList::deleteData(QString tableName,QString songName){//删除歌曲
    DataBase sqlTest;
    sqlTest.openDb();
    if(sqlTest.isTableExist(tableName)){
        sqlTest.deleteData(songName);
        qDebug()<<"delete successfully!";
    }else{
        qDebug()<<"dont't find "+tableName+"table!"+" delete failed! ";
    }
    sqlTest.closeDb();

}

void SongList::deleteTable(QString tableName)//删除歌单
{
    DataBase sqlTest;
    sqlTest.openDb();
    if(sqlTest.isTableExist(tableName)){
        sqlTest.deleteTable(tableName);
        qDebug()<<"delete successfully!";
    }else{
        qDebug()<<"dont't find "+tableName+"table!"+" delete failed! ";
    }
    sqlTest.closeDb();

}
void SongList::inSert(QString tableName,QStringList data){//插入歌曲
    DataBase sqlTest;
    sqlTest.openDb();
    if(sqlTest.isTableExist(tableName)){
        m_songName=data[0];
        m_songPath=data[1];
        m_songArtist=data[2];
        m_songAlbum=data[3];
        m_songTime=data[4];
        songinfo var={m_songName,m_songArtist,
                      m_songAlbum,m_songTime,m_songPath};
        m_data.push_back(var);
        sqlTest.moreInsertData(m_data);
    }else{
        qDebug()<<"dont't find "+tableName+"table!";
    }
    sqlTest.closeDb();
}

void SongList::createlist(QString tableName)//创建歌单
{
    DataBase sqlTest;
    sqlTest.openDb();
    sqlTest.createTable(tableName);
    sqlTest.closeDb();
}

QList<songinfo> SongList::querySongDatas(QString tableName)//获取歌单
{
    DataBase sqlTest;
    sqlTest.openDb();
    if(sqlTest.isTableExist(tableName)){
        m_data=sqlTest.queryTable();
    }else{
        qDebug()<<"dont't find "+tableName+"table!";

    }
    sqlTest.closeDb();
    return m_data;
}
