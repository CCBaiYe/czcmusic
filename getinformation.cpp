#include "getinformation.h"
#include <QDebug>
#include <QByteArray>

#include <taglib/tag.h>
#include <taglib/wavfile.h>
#include <taglib/mpegfile.h>
#include <taglib/flacfile.h>
#include <taglib/mp4file.h>
#include <taglib/audioproperties.h>
GetInformation::GetInformation(QObject *parent)
    : QObject{parent}
{
    endsWith("/root/music/海阔天空.mp3");
}

void GetInformation::endsWith(QString fileUrl)
{
    //判断传入的文件的后缀
    if(fileUrl.endsWith(".mp3")){
        analysisMP3(fileUrl);
    }else if(fileUrl.endsWith(".wav")){
        analysisWAV(fileUrl);
    }else if(fileUrl.endsWith(".flac")){
        analysisFLAC(fileUrl);
    }else if(fileUrl.endsWith(".mp4")){
        analysisMP4(fileUrl);
    }
}

void GetInformation::analysisMP3(QString fileUrl)
{
    QByteArray ba = fileUrl.toUtf8();
    const char *ch = ba.data();

    TagLib::MPEG::File *tmf = new TagLib::MPEG::File(ch);
    if(tmf->isOpen()){
        m_Information.title = tmf->tag()->title().toCString();
        m_Information.artist = tmf->tag()->artist().toCString();
        m_Information.album = tmf->tag()->album().toCString();
        m_Information.genre = tmf->tag()->genre().toCString();

        //test code
        m_Information.showAllInformation();

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
        m_Information.title = trwf->tag()->title().toCString();
        m_Information.artist = trwf->tag()->artist().toCString();
        m_Information.album = trwf->tag()->album().toCString();
        m_Information.genre = trwf->tag()->genre().toCString();

        //test code
        m_Information.showAllInformation();
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
        m_Information.title = tff->tag()->title().toCString();
        m_Information.artist = tff->tag()->artist().toCString();
        m_Information.album = tff->tag()->album().toCString();
        m_Information.genre = tff->tag()->genre().toCString();

        //test code
        m_Information.showAllInformation();
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
        m_Information.title = tmf->tag()->title().toCString();
        m_Information.artist = tmf->tag()->artist().toCString();
        m_Information.album = tmf->tag()->album().toCString();
        m_Information.genre = tmf->tag()->genre().toCString();
    }
}

