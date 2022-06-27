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
public:
    explicit DataInitialization(QObject *parent = nullptr);

signals:
    void succeed();

    void loadPathChanged();

    void musicNameChanged();
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
public:
    QString loadPath(){
        m_loadPath = loadFile->value("loadFile").toString();
        return m_loadPath;
    }

    QString musicName(){
        m_musicName = loadFile->value("musicName").toString();
        return m_musicName;
    }
private:
    QString m_loadPath;
    QString m_musicName;
    QSettings *loadFile = new QSettings("loadFile.ini",QSettings::IniFormat);
};

#endif // DATAINITIALIZATION_H
