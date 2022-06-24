#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "getinformation.h"
#include "onlinesong.h"
#include "datainitialization.h"
#include "lyrinfo.h"
#include<QFontDatabase>
#include <QSettings>
int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    //添加字体文件
    const int fontId = QFontDatabase::addApplicationFont(":/Font/fontawesome-webfont.ttf");
    QStringList fontFamilies = QFontDatabase::applicationFontFamilies(fontId);

    qmlRegisterType<GetInformation,1>("GetInformation",1,0,"GetInformation");
    qmlRegisterType<OnlineSong,1>("OnlineSong",1,0,"OnlineSong");
    qmlRegisterType<DataInitialization,1>("DataInitialization",1,0,"DataInitialization");
    qmlRegisterType<LyrInfo,1>("LyrInfo",1,0,"LyrInfo");

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
