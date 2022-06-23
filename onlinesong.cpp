#include "onlinesong.h"
#include <QJsonDocument>
#include <QJSValue>
#include <QJsonArray>
#include <QJsonObject>


OnlineSong::OnlineSong(QObject *parent):QObject(parent)
{
    manager=new QNetworkAccessManager;
    manager2=new QNetworkAccessManager;
    request=new QNetworkRequest;
    request2=new QNetworkRequest;

    request2->setRawHeader("Cookie","kg_mid=233");
    request2->setHeader(QNetworkRequest::CookieHeader,2333);
    connect(manager,&QNetworkAccessManager::finished,this,&OnlineSong::replyFinished);
    connect(manager,&QNetworkAccessManager::finished,this,&OnlineSong::replyFinished2);


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
    emit songNameChanged(m_songName);
    if(!isDownloadSong) {
        emit urlChanged(m_url);
    } else {
        emit getUrl();
    }
    isDownloadSong=false;

    reply->deleteLater();//释放reply对象

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
        QString KGAPI = QString("http://wwwapi.kugou.com/yy/index.php?r=play/getdata&hash=%1&album_id=%2").arg(fileHash[index]).arg(alumId[index]);

        request2->setUrl(QUrl(KGAPI));
        manager2->get(*request2);

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
                                if(obj.contains("AlumID")&&obj["AlumID"].isString())
                                {
                                    alumId.push_back(obj["AlumID"].toString());

                                }
                                if(obj.contains("FileHash")&&obj["FileHash"].isString())
                                {
                                    fileHash.push_back(obj["FileHash"].toString());
                                }

                                getInformation(i);

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
{
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
                if(dataobj.contains("audio_name")&&dataobj["audio_name"].isString())
                {
                    m_songName.push_back(dataobj["audio_name"].toString());
                }
                if(dataobj.contains("alum_name")&&dataobj["alum_name"].isString())
                {
                    m_alumName.push_back(dataobj["alum_name"].toString());
                }
                if(dataobj.contains("timelength")&&dataobj["timelength"].isDouble())
                {
                    m_duration.push_back(dataobj["timelength"].toDouble());
                }
                if(dataobj.contains("song_name")&&dataobj["song_name"].isString())
                {
                    m_singerName.push_back(dataobj["song_name"].toString());
                }
                if(dataobj.contains("img")&&dataobj["img"].isString()&&!dataobj["img"].isNull())
                {
                    m_image=dataobj["img"].toString();
                }
                if(dataobj.contains("lyrics")&&dataobj["lyrics"].isString()&&!dataobj["lyrics"].isNull())
                {
                    m_lyrics=dataobj["lyrics"].toString();
                }
                if(dataobj.contains("url")&&dataobj["url"].isString()&&!dataobj["url"].isNull())
                {
                    m_url=dataobj["url"].toString();
                }
            }

        }
    }

}

void OnlineSong::clear()
{//刷新
    alumId.clear();
    fileHash.clear();
    m_songName.clear();
    m_singerName.clear();
    m_duration.clear();
    m_alumName.clear();
    m_url.clear();
    m_image.clear();
    m_lyrics.clear();

}
