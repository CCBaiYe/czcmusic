#include "onlinesong.h"
#include <QJsonDocument>
#include <QJSValue>
#include <QJsonArray>
#include <QJsonObject>
#include <QFile>
#include <QThread>


OnlineSong::OnlineSong(QObject *parent):QObject(parent)
{
    manager=new QNetworkAccessManager;
    manager2=new QNetworkAccessManager;
    manager3=new QNetworkAccessManager;
    request=new QNetworkRequest;
    request2=new QNetworkRequest;
    request3=new QNetworkRequest;


    request2->setRawHeader("Cookie","kg_mid=233");
    request2->setHeader(QNetworkRequest::CookieHeader,2333);
    connect(manager,&QNetworkAccessManager::finished,this,&OnlineSong::replyFinished);
    connect(manager2,&QNetworkAccessManager::finished,this,&OnlineSong::replyFinished2);
    connect(manager3,&QNetworkAccessManager::finished,this,&OnlineSong::replyFinished3);

}


void OnlineSong::replyFinished(QNetworkReply *reply)
{//响应请求request
    if(reply->error()==QNetworkReply::NoError){
        QByteArray bytes=reply->readAll();  //获取字节
        QString result=bytes;  //转化为字符串
        parsejson_getIdHash(result);//解析json获得alumid和filehash
    }else{
        //处理错误
        qDebug()<<"error";
    }

    emit songNameChanged(m_songName);

    reply->deleteLater();//释放请求对象
}

void OnlineSong::replyFinished2(QNetworkReply *reply)
{//响应请求request2
    if(reply->error()==QNetworkReply::NoError){
        QByteArray bytes=reply->readAll();//获取字节
        QString result=bytes;//转化为字符串
        parsejson_getinformation(result);
    }else{
        //处理错误
        qDebug()<<"error";
    }

    if(!isDownloadSong&&!isDowloadLrc){
        emit urlChanged(m_url);
//        qDebug()<<"m_url";
        emit lyricsChanged(m_lyrics);
//        qDebug()<<"m_lyrics";
    }else if(isDownloadSong&&!isDowloadLrc){
        emit getUrl();
//        qDebug()<<"getUrl";
    }
    else  if(!isDownloadSong&&isDowloadLrc){
        emit getlyrics();
//        qDebug()<<"getlyrics";
    }


    isDownloadSong=false;
    isDowloadLrc=false;


    reply->deleteLater();//释放reply对象

}

void OnlineSong::replyFinished3(QNetworkReply *reply)
{//响应请求request3

    QFile songFile(m_songSavePath);
    if(reply->error()==QNetworkReply::NoError){
        QByteArray bytes=reply->readAll();//获取字节
        if(songFile.open(QIODevice::WriteOnly|QIODevice::Truncate))
        {
            qDebug()<<"正在下载...";
            songFile.write(bytes);
            songFile.close();
        }
        qDebug()<<"下载成功";


    }
    else{
            qDebug()<<"error";
        }

       reply->deleteLater();

}


void OnlineSong::search(QString keyword)
{
    clear();

    QString KGAPI=QString("http://songsearch.kugou.com/song_search_v2?keyword=%1&page=&pagesize=30"
                          "&userid=-1&clientver=&platform=WebFilter&tag=em&filter=2&iscorrection=1&privilege_filter=0").arg(keyword);

    //歌曲搜索请求
    request->setUrl(QUrl(KGAPI));
    manager->get(*request);
}

void OnlineSong::getInformation(int index)
{

        //通过歌曲ID,hash发送请求，得到歌曲详细信息
        QString KGAPI = QString("http://wwwapi.kugou.com/yy/index.php?r=play/getdata&hash=%1&album_id=%2").arg(fileHash[index]).arg(albumId[index]);

        request2->setUrl(QUrl(KGAPI));
        manager2->get(*request2);

}

void OnlineSong::downLoadsong(int index)
{
    m_songSavePath="/root/.config/"+m_songName[index]+".mp3";
    isDownloadSong=true;
    getInformation(index);

    qDebug()<<m_lyrics;
    connect(this,&OnlineSong::getUrl,this,[&](){
        request3->setUrl(m_url);
        manager3->get(*request3);
    });

}

void OnlineSong::downLoadLyrics(int index)
{
    m_lrcSavePath="/root/.config/"+m_songName[index]+".lrc";

    isDowloadLrc=true;


    getInformation(index);

    connect(this,&OnlineSong::getlyrics,this,[&](){
        QFile lrcFile(m_lrcSavePath);
        QByteArray content=m_lyrics.toUtf8();
        if(lrcFile.open(QIODevice::WriteOnly|QIODevice::Text))
        {
            lrcFile.write(content);
            lrcFile.close();
        }else{
            qDebug()<<"false";
        }
    });

}

void OnlineSong::parsejson_getIdHash(QString json)
{
    //解析json数据
    QJsonParseError json_error;
    QJsonDocument parse_document=QJsonDocument::fromJson(json.toUtf8(),&json_error);
    if(!parse_document.isNull())
    {
        if(parse_document.isObject())
        {
            QJsonObject rootobj=parse_document.object();
            if(rootobj.contains("data"))
            {
                QJsonValue valuedata = rootobj.value("data");
                if(valuedata.isObject())
                {
                    QJsonObject dataobject=valuedata.toObject();
                    if(dataobject.contains("lists"))
                    {
                        QJsonValue listsvalue=dataobject.value("lists");
                        if(listsvalue.isArray())
                        {
                            QJsonArray listsarray=listsvalue.toArray();
                            int size=listsarray.size();
                            for(int i=0;i<size;i++)
                            {

                                QJsonObject obj=listsarray.at(i).toObject();
                                if(obj.contains("AlbumID")&&obj["AlbumID"].isString())
                                {
                                    albumId.push_back(obj["AlbumID"].toString());

                                }
                                if(obj.contains("FileHash")&&obj["FileHash"].isString())
                                {
                                    fileHash.push_back(obj["FileHash"].toString());
                                }
                                if(obj.contains("SingerName")&&obj["SingerName"].isString())
                                {
                                    m_singerName.push_back(obj["SingerName"].toString());
                                }
                                if(obj.contains("SongName")&&obj["SongName"].isString())
                                {
                                    m_songName.push_back(obj["SongName"].toString());
                                }
                                if(obj.contains("AlbumName")&&obj["AlbumName"].isString())
                                {
                                    m_albumName.push_back(obj["AlbumName"].toString());
                                }
                                if(obj.contains("Duration")&&obj["Duration"].isDouble())
                                {
                                    m_duration.push_back(obj["Duration"].toDouble());
                                }


                            }

                        }
                    }
                }
            }
        }
    }else {
        qDebug()<<json_error.errorString();
    }


}

void OnlineSong::parsejson_getinformation(QString json)
{//解析json获得歌曲url,img和歌词

    QJsonParseError json_error;
    QJsonDocument parse_document=QJsonDocument::fromJson(json.toUtf8(),&json_error);
    if(parse_document.isObject())
    {
        QJsonObject rootobj=parse_document.object();

        if(rootobj.contains("data"))
        {
            QJsonValue datavalue=rootobj.value("data");
            if(datavalue.isObject())
            {
                QJsonObject dataobj=datavalue.toObject();

                if(dataobj.contains("img")&&dataobj["img"].isString())
                {
                    m_image=(dataobj["img"].toString());
                }
                if(dataobj.contains("play_url")&&dataobj["play_url"].isString())
                {
                    m_url=dataobj["play_url"].toString();
                }
                if(dataobj.contains("lyrics")&&dataobj["lyrics"].isString())
                {
                    getPureLyrics(dataobj["lyrics"].toString());
                    if(!isDowloadLrc)
                    {
                        //qDebug()<<isDowloadLrc;
                        writeLrc(m_lyrics);
                    }

                }

            }

        }
    }

}

void OnlineSong::getPureLyrics(QString lyrics)
{
    int index=lyrics.indexOf("[00");
    m_lyrics=lyrics.mid(index);
}

void OnlineSong::writeLrc(QString lyrics)
{
    //写歌词文件
    QByteArray content=lyrics.toUtf8();


    QFile lrcFile("/tmp/lyrics.lrc");
    if(lrcFile.open(QIODevice::WriteOnly|QIODevice::Text))
    {
        lrcFile.write(content);
        lrcFile.close();
    }else{
        qDebug()<<"false";
    }
}

void OnlineSong::clear()
{//刷新
    albumId.clear();
    fileHash.clear();
    m_songName.clear();
    m_singerName.clear();
    m_duration.clear();
    m_albumName.clear();
    m_url.clear();
    m_image.clear();
    m_lyrics.clear();

}
