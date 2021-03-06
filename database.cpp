#include "database.h"

DataBase::DataBase()
{
    if(QSqlDatabase::contains("qt_sql_default_connection"))
    {
        database=QSqlDatabase::database("qt_sql_default_connection");
    }
    else{
        database=QSqlDatabase::addDatabase("QSQLITE");
        database.setDatabaseName("songList.db");
    }


}

bool DataBase::openDb()//打开数据库
{
    if(!database.open())
    {
        qDebug()<<"Error:open failed"<<database.lastError();
    }

    return true;
}

void DataBase::createTable(QString& tableName)//创建数据表
{
    openDb();

    QSqlQuery sqlQuery;
    QString createSql=QString ("CREATE TABLE %1(\
                                  songName TEXT KEY NOT NULL,\
                                  songArtist TEXT,\
                                  songAlbum TEXT,\
                                  songTime TEXT,\
                                  songPath TEXT)"
                              ).arg(tableName);
    sqlQuery.prepare(createSql);

    if(!sqlQuery.exec()){
        qDebug()<<"Error:Fail to create table."<<sqlQuery.lastError();
    }
    else
    {
        qDebug()<<"Table created successful!";
    }
}
bool DataBase::isTableExist(QString& tableName)// 判断数据库中某个数据表是否存在
{
    QSqlDatabase database = QSqlDatabase::database();
    if(database.tables().contains(tableName))
    {
        return true;
    }

    return false;
}

void DataBase::queryTable(QString tableName, QList<QString> &songname, QList<QString> &songart, QList<QString> &songalbum, QList<QString> &songtime, QList<QString> &path)
{// 查询全部数据
    QSqlQuery sqlQuery;
    sqlQuery.exec(QString("SELECT * FROM %1").arg(tableName));
    if(!sqlQuery.exec())
    {
        qDebug() << "Error: Fail to query table. " << sqlQuery.lastError();
    }
    else
    {
        while(sqlQuery.next())
        {
            songname.push_back(sqlQuery.value(0).toString());
            songart.push_back(sqlQuery.value(1).toString()) ;
            songalbum.push_back(sqlQuery.value(2).toString()) ;
            songtime.push_back(sqlQuery.value(3).toString()) ;
            path.push_back(sqlQuery.value(4).toString()) ;

        }
    }
}


void DataBase::singleInsertData(QString tableName,QString songname,QString songpath,QString songartist,QString songalbum,QString songtime)//插入单条数据
{
    QSqlQuery sqlQuery;
        sqlQuery.prepare(QString("INSERT INTO %1 VALUES(:songName,:songArtist,:songAlbum,:songTime,:songPath)").arg(tableName));
        sqlQuery.bindValue(":songName", songname);
        sqlQuery.bindValue(":songArtist", songartist);
        sqlQuery.bindValue(":songAlbum", songalbum);
        sqlQuery.bindValue(":songTime", songtime);
        sqlQuery.bindValue(":songPath", songpath);
        if(!sqlQuery.exec())
        {
            qDebug() << "Error: Fail to insert data. " << sqlQuery.lastError();
        }
        else
        {
            qDebug()<<"insert successfully!";
        }
}


QList<QString> DataBase::readTables()
{
    QList<QString> tables;
    QSqlQuery sqlQuery;


    for (const auto& tableName : database.tables())
        {
            QString selectSql = QString("select * from %1;").arg(tableName);
            if (!sqlQuery.exec(selectSql))
            {
                qDebug() << sqlQuery.lastError().text();
                continue;
            }
            selectSql.remove("select * from ").remove(";");
            tables.push_back(selectSql);
    }
    return tables;
}

void DataBase::deleteData(QString songName)// 删除数据
{
    QSqlQuery sqlQuery;

    sqlQuery.exec(QString("DELETE FROM song WHERE id = %1").arg(songName));
    if(!sqlQuery.exec())
    {
        qDebug()<<sqlQuery.lastError();
    }
    else
    {
        qDebug()<<"deleted data success!";
    }
}

void DataBase::deleteTable(QString& tableName)//删除数据表
{
    QSqlQuery sqlQuery;

    sqlQuery.exec(QString("DROP TABLE %1").arg(tableName));
    if(sqlQuery.exec())
    {
        qDebug() << sqlQuery.lastError();
    }
    else
    {
        qDebug() << "deleted table success";
    }
}

void DataBase::closeDb(void)
{
    database.close();
}
