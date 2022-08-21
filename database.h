#ifndef DATABASE_H
#define DATABASE_H

#include <QSqlDatabase>
#include <QSqlQuery>
#include <QSqlError>
#include <QDebug>
#include "songlist.h"
#include <QList>

class DataBase:public QObject
{
    Q_OBJECT
    Q_PROPERTY(QList<QString> tableNames READ tableNames WRITE setTableNames NOTIFY tableNamesChanged)
    Q_PROPERTY(QList<SongList *> songLists READ songLists WRITE setSongLists NOTIFY songListsChanged)

public:
    DataBase();

    bool openDb(void);// 打开数据库

    void createTable(QString& tableName);// 创建数据表

    Q_INVOKABLE bool isTableExist(QString& tableName);// 判断数据表是否存在

    void queryTable(QString tableName,QList<QString> &songname,QList<QString> &songart,QList<QString> &songalbum,QList<QString> &songtime,QList<QString> &path );// 根据歌单名查询其全部数据

    void singleInsertData(QString tableName,QString songname,QString songpath,QString songartist,QString songalbum,QString songtime); // 插入单条数据

    //void modifyData(int id, QString name, int age);// 修改数据

    QList<QString> readTables();//读表

    void deleteData(QString songName);// 删除数据

    void deleteTable(QString& tableName);//删除数据表

    void closeDb(void);// 关闭数据库

public slots:
    void setTableNames(QList<QString> tableNames){
        m_tableNames=tableNames;
        emit tableNamesChanged();
    }
    void setSongLists(QList<SongList *> songListS){
        SongLists=songListS;
        emit songListsChanged();
    }


    Q_INVOKABLE void insert(QString tableName,QString songname,QString songpath,QString songartist,QString songalbum,QString songtime)
    {
        openDb();
        if(isTableExist(tableName)){

            singleInsertData(tableName,songname,songpath,songartist,songalbum,songtime);
            int index=m_tableNames.indexOf(tableName);
            SongLists.at(index)->addSong(songname,songpath,songartist,songalbum,songtime);


        }else{
            qDebug()<<"dont't find "+tableName+"table!";
        }
        closeDb();

    }
    Q_INVOKABLE void deleteSongList(QString tableName)//删除歌单
    {
        openDb();
        if(isTableExist(tableName)){
            deleteTable(tableName);
            qDebug()<<"delete successfully!";
        }else{
            qDebug()<<"dont't find "+tableName+"table!"+" delete failed! ";
        }
        closeDb();
    }

    Q_INVOKABLE void createlist(QString &tableName)//创建歌单
    {

        m_tableNames.push_back(tableName);

        SongLists.push_back(new SongList);


        openDb();
        createTable(tableName);
        closeDb();


        int index=m_tableNames.indexOf(tableName);
        SongLists.at(index)->songListName()=tableName;

    }

    Q_INVOKABLE void querySongDatas(QString tableName)//获取歌单
    {
        int index=m_tableNames.indexOf(tableName);

        openDb();
        if(isTableExist(tableName)){

            queryTable(tableName,SongLists.at(index)->m_songName,SongLists.at(index)->m_songArtist,SongLists.at(index)->m_songAlbum,SongLists.at(index)->m_songTime,SongLists.at(index)->m_songPath);

        }else{
            qDebug()<<"dont't find "+tableName+"table!";
        }

        closeDb();
    }

    Q_INVOKABLE void readSongListTables()//初始化读取所有歌单名
    {
        m_tableNames=readTables();

        for(int i=0;i<m_tableNames.length();i++){
            SongLists.push_back(new SongList);
            SongLists.at(i)->songListName()=m_tableNames[i];
            querySongDatas(m_tableNames[i]);
        }



    }

public:
    QList<QString> tableNames(){
        return m_tableNames;
    }

    QList<SongList *>songLists(){
        return SongLists;
    }

signals:
        void tableNamesChanged();
        void songListsChanged();


private:
    QSqlDatabase database;
    QList<SongList *> SongLists;
    QList<QString> m_tableNames;
};

#endif // DATABASE_H
