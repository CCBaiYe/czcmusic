#include "songlist.h"
#include<QStringListModel>
SongList::SongList(QObject *parent)
    : QObject{parent}
{

}

void SongList::deleteData(qsizetype i){
    m_data.remove(i);

}

void SongList::inSert(QStringList data){
    m_songName=data[0];
    m_songPath=data[1];
    m_songArtist=data[2];
    m_songAlbum=data[3];
    m_songTime=data[4];
    QStringList var={m_songName,m_songArtist,
                  m_songAlbum,m_songTime,m_songPath};
    m_data.append(var);

}

void SongList::creatList(){
    QList<QString> m_data;
}
