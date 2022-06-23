#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "getinformation.h"
#include "onlinesong.h"
#include<QFontDatabase>
int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    //添加字体文件
    const int fontId = QFontDatabase::addApplicationFont(":/Font/fontawesome-webfont.ttf");
    QStringList fontFamilies = QFontDatabase::applicationFontFamilies(fontId);

    //注册c++类
    qmlRegisterType<GetInformation,1>("GetInformation",1,0,"GetInformation");
    qmlRegisterType<OnlineSong,1>("OnlineSong",1,0,"OnlineSong");
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
