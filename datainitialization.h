#ifndef DATAINITIALIZATION_H
#define DATAINITIALIZATION_H

#include <QObject>
#include <QtQml/qqmlregistration.h>
#include <QUrl>
#include <QSettings>
#include <QDebug>
class DataInitialization : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString loadPath READ loadPath WRITE setLoadPath NOTIFY loadPathChanged)
    Q_PROPERTY(QString musicName READ musicName WRITE setMusicName NOTIFY musicNameChanged)
    Q_PROPERTY(bool netFlag READ netFlag WRITE setNetFlag NOTIFY netFlagChanged)
public:
    explicit DataInitialization(QObject *parent = nullptr);

signals:
    void succeed();

    void loadPathChanged();

    void musicNameChanged();

    void netFlagChanged();
public slots:
    void setLoadPath(QString loadPath){
        m_loadPath = loadPath;
        loadFile->setValue("loadFile",m_loadPath);
        loadFile->sync();
    }

    void setMusicName(QString musicName){
        m_musicName = musicName;
        loadFile->setValue("musicName",m_musicName);
        loadFile->sync();
    }

    void setNetFlag(bool netFlag){
        m_netFlag=netFlag;
        loadFile->setValue("netFlag",m_netFlag);
        loadFile->sync();
    }
public:
    QString loadPath(){
        m_loadPath = loadFile->value("loadFile").toString();
        return m_loadPath;
    }

    QString musicName(){
        m_musicName = loadFile->value("musicName").toString();
        return m_musicName;
    }
    bool netFlag(){
        return m_netFlag;
    }
private:
    QString m_loadPath;
    QString m_musicName;
    bool m_netFlag;
    QSettings *loadFile = new QSettings("loadFile.ini",QSettings::IniFormat);
};

#endif // DATAINITIALIZATION_H
