#ifndef GETINFORMATION_H
#define GETINFORMATION_H

#include <QObject>
#include <QtQml/qqmlregistration.h>
#include <QDebug>
class information{
public:
    QString title = "";//标题
    QString artist = "";//作者
    QString album = "";//专辑
    QString genre = "";//类型
public:
    void showAllInformation(){
        qDebug()<< title;
        qDebug()<< artist;
        qDebug()<< album;
        qDebug()<< genre;
    }
};

class GetInformation : public QObject
{
    Q_OBJECT
//    Q_PROPERTY(information baseInformation READ baseInformation WRITE setBaseInformation NOTIFY informationChanged)
//    QML_ELEMENT

public:
    explicit GetInformation(QObject *parent = nullptr);

signals:
    void succeed();

    void failed();

    void informationChanged();

public slots:
//    void setBaseInformation(information changedInformation){
//        m_Information = changedInformation;
//    }

public:
//    information baseInformation(){
////        endsWith(fileUrl);
//        return m_Information;
//    }

    void endsWith(QString fileUrl);

    void analysisMP3(QString fileUrl);

    void analysisWAV(QString fileUrl);

    void analysisFLAC(QString fileUrl);

    void analysisMP4(QString fileUrl);

public:
    information m_Information;
};

#endif // GETINFORMATION_H
