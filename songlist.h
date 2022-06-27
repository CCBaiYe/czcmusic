#ifndef SONGLIST_H
#define SONGLIST_H

#include <QObject>
#include <QtQml/qqmlregistration.h>
#include <QDebug>
#include <QUrl>
#include<QStringListModel>

class SongList:public QObject
{
    Q_OBJECT
    //Q_PROPERTY（QString name READ name WRITE setName）
public:
    explicit SongList(QObject *parent=nullptr);
public slots:
    void inSert(QStringList data);
    void append(QStringList data);
    void deleteData(int row,int count);
    void creatList();
public:
    //void flags();

private:
    QStringListModel *m_model;//模型
};

#endif // SONGLIST_H
