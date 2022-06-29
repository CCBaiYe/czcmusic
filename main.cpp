#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "getinformation.h"
#include "onlinesong.h"
#include "datainitialization.h"
#include "lyrinfo.h"
#include"songlist.h"
#include "editlyr.h"
#include<QFontDatabase>
#include <QSettings>
#include"sqlite3.h"
#include<stdio.h>
#include<QSqlDatabase>
#include<QSql>
#include<QSqlQuery>
#include<QSqlError>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    //添加字体文件
    const int fontId = QFontDatabase::addApplicationFont(":/Font/fontawesome-webfont.ttf");
    QStringList fontFamilies = QFontDatabase::applicationFontFamilies(fontId);

    //注册c++类
    qmlRegisterType<GetInformation,1>("GetInformation",1,0,"GetInformation");
    qmlRegisterType<OnlineSong,1>("OnlineSong",1,0,"OnlineSong");
    qmlRegisterType<DataInitialization,1>("DataInitialization",1,0,"DataInitialization");
    qmlRegisterType<LyrInfo,1>("LyrInfo",1,0,"LyrInfo");
    qmlRegisterType<SongList,1>("SongList",1,0,"SongList");
    qmlRegisterType<EditLyr,1>("EditLyr",1,0,"EditLyr");

    QCoreApplication::setOrganizationName("MySoft");
    QCoreApplication::setOrganizationDomain("mysoft.com");
    QCoreApplication::setApplicationName("Star Runner");

    QQmlApplicationEngine engine;
    const QUrl url(u"qrc:/ccmusic/main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);
    return app.exec();
}
