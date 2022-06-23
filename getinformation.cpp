#include "getinformation.h"
#include <QDebug>
#include <QByteArray>
#include <QImage>
#include <QDir>
#include <taglib/tag.h>

#include <taglib/wavfile.h>
#include <taglib/mpegfile.h>
#include <taglib/flacfile.h>
#include <taglib/mp4file.h>
#include <taglib/asffile.h>
#include <taglib/apefile.h>

#include <taglib/audioproperties.h>
GetInformation::GetInformation(QObject *parent)
    : QObject{parent}
{
    connect(this,SIGNAL(fileUrlChanged()),this,SLOT(onEndsWith()));
}

void GetInformation::onEndsWith()
{
    QString fileUrl = m_fileUrl;
    //删除不符合taglib格式的前缀
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
        //解析数据
        m_title = tmf->tag()->title().toCString();
        m_artist = tmf->tag()->artist().toCString();
        m_album = tmf->tag()->album().toCString();
        m_genre = tmf->tag()->genre().toCString();
        m_time = tmf->tag()->year();
        //获取ID3v2中的封面段
        TagLib::List<TagLib::ID3v2::Frame *> TL  = tmf->ID3v2Tag()->frameListMap()["APIC"];
        TagLib::ID3v2::Frame *TIF = TL.front();
        TagLib::ID3v2::AttachedPictureFrame *TIA = reinterpret_cast<TagLib::ID3v2::AttachedPictureFrame *>(TIF);
        //判断是否存在图片
        if(!TIA->picture().isNull()){
            TagLib::ByteVector tb = TIA->picture();
            QImage cover;
            QImage covpic;
            if(cover.loadFromData(QByteArray::fromRawData(tb.data(), tb.size()))) {
                covpic = cover.scaled(500,500,Qt::IgnoreAspectRatio,Qt::SmoothTransformation);
                qDebug()<<"读取MP3封面信息成功";
            }
            //判断图片数
            QList<QImage> covPiclist;
            covPiclist.append(covpic);
            int covCount = covPiclist.length();
            //为图片随机生成姓名
            QString covpicpath = QDir::tempPath()+QString("/%1.png").arg(covCount);
            //将解析出的图片保存在本地
            covpic.save(covpicpath);
            //获得本地图片
            m_picture = QUrl::fromLocalFile(covpicpath);
        }

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
        //解析数据
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
        //解析数据
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
        //解析数据
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
        //解析数据
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
        //解析数据
        m_title = taf->tag()->title().toCString();
        m_artist = taf->tag()->artist().toCString();
        m_album = taf->tag()->album().toCString();
        m_genre = taf->tag()->genre().toCString();
    }else {
        emit this->failed();
    }
}

