#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "fileio.h"
#include"player.h"
int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qmlRegisterType<FileIo, 1>("FileIo", 1, 0, "FileIo");
    qmlRegisterType<Player,1>("Player",1,0,"Player");

    QQmlApplicationEngine engine;
    const QUrl url(u"qrc:/untitled17/main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
