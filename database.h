#ifndef DATABASE_H
#define DATABASE_H

#include <QSqlDatabase>
#include <QSqlQuery>
#include <QSqlError>
#include <QDebug>
#include<QList>
typedef struct
{

    QString songName;
    QString songArtist;
    QString songAlbum;
    QString songTime;
    QString songPath;
}songinfo;
class DataBase
{
public:
    DataBase();

    bool openDb(void);// 打开数据库

    void createTable(QString& tableName);// 创建数据表

    bool isTableExist(QString& tableName);// 判断数据表是否存在

    void queryTable(QString tableName,QList<QString> &songname,QList<QString> &songart,QList<QString> &songalbum,QList<QString> &songtime,QList<QString> &path );// 查询全部数据

    void singleInsertData(songinfo &singleData,QString tableName); // 插入单条数据

    void moreInsertData(QList<songinfo> &moreData); // 插入多条数据

    //void modifyData(int id, QString name, int age);// 修改数据

    QList<QString> readTables();//读表

    void deleteData(QString songName);// 删除数据

    void deleteTable(QString& tableName);//删除数据表

    void closeDb(void);// 关闭数据库
private:
    QSqlDatabase database;

};

#endif // DATABASE_H
