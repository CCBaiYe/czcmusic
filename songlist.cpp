#include "songlist.h"
#include<QStringListModel>
SongList::SongList(QObject *parent)
        : QObject{parent}
{

}

void SongList::append(QStringList data ){
    //m_model=new QStringListModel;
    //QStringList data1={"fileName","fileArtist","fileAlbum","fileTime"};
    //m_model->setStringList(data1);
    m_model->setStringList(data);
}
void SongList::deleteData(int row,int count){
    m_model->removeRows(row,count);
}

void SongList::inSert(QStringList data){
    QModelIndex index=m_model->index(m_model->rowCount());
    m_model->setData(index,data);
}
void SongList::creatList(){
    m_model=new QStringListModel;
}
