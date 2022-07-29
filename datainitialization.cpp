#include "datainitialization.h"
#include <QSettings>
#include <QDir>
#include <QDebug>
#include <QFile>
#include <QStringList>
#include <QVariant>
DataInitialization::DataInitialization(QObject *parent)
    : QObject{parent}
{
}

void DataInitialization::writeData(QString name,QString path,QString artist,QString album,QString time)
{
    loadFiles->beginWriteArray(name);   
        loadFiles->setArrayIndex(0);
        loadFiles->setValue("songName", name);
        loadFiles->setValue("songPath", path);
        loadFiles->setValue("songArtist", artist);
        loadFiles->setValue("songAlbum", album);
        loadFiles->setValue("songTime", time);
    loadFiles->endArray();
}

QStringList DataInitialization::readData(QString name)
{
    loadFiles->beginReadArray(name);
        loadFiles->setArrayIndex(0);
        songs.clear();
        songs.append(loadFiles->value("songName").toString());
        songs.append(loadFiles->value("songPath").toString());
        songs.append(loadFiles->value("songArtist").toString());
        songs.append(loadFiles->value("songAlbum").toString());
        songs.append(loadFiles->value("songTime").toString());
    loadFiles->endArray();
    return songs;
}
