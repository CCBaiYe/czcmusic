#include "songlist.h"
#include"database.h"
#include<QStringListModel>
SongList::SongList(QObject *parent)
    :QObject{parent}
{


}

void SongList::addSong(QString songname,QString songpath,QString songartist,QString album,QString time){//加入歌曲

    m_songname=songname;
    m_songalbum=album;
    m_songartist=songartist;
    m_songtime=time;
    m_songpath=songpath;

    m_songName.push_back(songname);
    m_songAlbum.push_back(album);
    m_songArtist.push_back(songartist);
    m_songTime.push_back(time);
    m_songPath.push_back(songpath);

}

