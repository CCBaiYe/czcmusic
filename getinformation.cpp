#include "getinformation.h"
#include <QDebug>
#include <QByteArray>

#include <taglib/tag.h>
#include <taglib/audioproperties.h>
#include <taglib/wavfile.h>
#include <taglib/mpegfile.h>
#include <taglib/flacfile.h>
#include <taglib/mp4file.h>
#include <taglib/asffile.h>
#include <taglib/apefile.h>

GetInformation::GetInformation(QObject *parent)
    : QObject{parent}
{
    connect(this,SIGNAL(fileUrlChanged()),this,SLOT(onEndsWith()));
}

void GetInformation::onEndsWith()
{
//    QString fileUrl = QString("/root/tmp/Justin Timberlake-Five Hundred Miles.mp3");
    QString fileUrl = m_fileUrl;
    if(fileUrl.startsWith("file://")){
        fileUrl=fileUrl.remove("file://");
    }
    //判断传入的文件的后缀
    if(fileUrl.endsWith(".mp3")){
        analysisMP3(fileUrl);
    }else if(fileUrl.endsWith(".wav")){
        analysisWAV(fileUrl);
    }else if(fileUrl.endsWith(".flac")){
        analysisFLAC(fileUrl);
    }else if(fileUrl.endsWith(".mp4")){
        analysisMP4(fileUrl);
    }else if(fileUrl.endsWith(".asf")){
        analysisASF(fileUrl);
    }else if(fileUrl.endsWith(".ape")){
        analysisAPE(fileUrl);
    }
    else {
        emit this->failed();
        return;
    }
    emit this->succeed();
}

void GetInformation::analysisMP3(QString fileUrl)
{
    QByteArray ba = fileUrl.toUtf8();
    const char *ch = ba.data();

    TagLib::MPEG::File *tmf = new TagLib::MPEG::File(ch);
    if(tmf->isOpen()){
        m_title = tmf->tag()->title().toCString();
        m_artist = tmf->tag()->artist().toCString();
        m_album = tmf->tag()->album().toCString();
        m_genre = tmf->tag()->genre().toCString();
    }else {
        emit this->failed();
    }
}

void GetInformation::analysisWAV(QString fileUrl)
{
    QByteArray ba = fileUrl.toUtf8();
    const char *ch = ba.data();

    TagLib::RIFF::WAV::File *trwf = new TagLib::RIFF::WAV::File(ch);
    if(trwf->isOpen()){
        m_title = trwf->tag()->title().toCString();
        m_artist = trwf->tag()->artist().toCString();
        m_album = trwf->tag()->album().toCString();
        m_genre = trwf->tag()->genre().toCString();
    }else {
        emit this->failed();
    }
}

void GetInformation::analysisFLAC(QString fileUrl)
{
    QByteArray ba = fileUrl.toUtf8();
    const char *ch = ba.data();

    TagLib::FLAC::File *tff = new TagLib::FLAC::File(ch);
    if(tff->isOpen()){
        m_title = tff->tag()->title().toCString();
        m_artist = tff->tag()->artist().toCString();
        m_album = tff->tag()->album().toCString();
        m_genre = tff->tag()->genre().toCString();
    }else {
        emit this->failed();
    }
}

void GetInformation::analysisMP4(QString fileUrl)
{
    QByteArray ba = fileUrl.toUtf8();
    const char *ch = ba.data();

    TagLib::MP4::File *tmf = new TagLib::MP4::File(ch);
    if(tmf->isOpen()){
        m_title = tmf->tag()->title().toCString();
        m_artist = tmf->tag()->artist().toCString();
        m_album = tmf->tag()->album().toCString();
        m_genre = tmf->tag()->genre().toCString();
    }else {
        emit this->failed();
    }
}

void GetInformation::analysisASF(QString fileUrl)
{
    QByteArray ba = fileUrl.toUtf8();
    const char *ch = ba.data();

    TagLib::ASF::File *taf = new TagLib::ASF::File(ch);
    if(taf->isOpen()){
        m_title = taf->tag()->title().toCString();
        m_artist = taf->tag()->artist().toCString();
        m_album = taf->tag()->album().toCString();
        m_genre = taf->tag()->genre().toCString();
    }else {
        emit this->failed();
    }
}

void GetInformation::analysisAPE(QString fileUrl)
{
    QByteArray ba = fileUrl.toUtf8();
    const char *ch = ba.data();

    TagLib::APE::File *taf = new TagLib::APE::File(ch);
    if(taf->isOpen()){
        m_title = taf->tag()->title().toCString();
        m_artist = taf->tag()->artist().toCString();
        m_album = taf->tag()->album().toCString();
        m_genre = taf->tag()->genre().toCString();
    }else {
        emit this->failed();
    }
}

