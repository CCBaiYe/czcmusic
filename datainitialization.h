#ifndef DATAINITIALIZATION_H
#define DATAINITIALIZATION_H

#include <QObject>
#include <QtQml/qqmlregistration.h>
#include <QUrl>
#include <QSettings>
#include <QDebug>
#include <QStringList>
struct SongInFo{
    QString songName;
    QString songPath;
    QString songArtist;
    QString songAlbum;
    QString songTime;
};

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
    void writeData(QString name,QString path,QString artist,QString album,QString time);
    QStringList readData(QString name);
    QStringList allKey(){
        QStringList allkey=loadFiles->childGroups();
        return allkey;
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
    QStringList songs;
    QString m_loadPath;
    QString m_musicName;

    QSettings *loadFile = new QSettings("/root/.config/loadFile.ini",QSettings::IniFormat);
    QSettings *loadFiles = new QSettings("/root/.config/loadFiles.ini",QSettings::IniFormat);
    bool m_netFlag;
};

#endif // DATAINITIALIZATION_H
