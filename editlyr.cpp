#include "editlyr.h"
#include <QFile>
#include <QIODevice>
#include <QTextStream>
EditLyr::EditLyr(QObject *parent)
    : QObject{parent}
{

}

void EditLyr::setUrl(QString url)
{
    if(url.startsWith("file://")){
        url.remove("file://");
    }
    m_url = url;
    QFile *fileName = new QFile(url);

    if(fileName->open(QIODevice::ReadOnly|QIODevice::Text)){
        QTextStream in(fileName);
        QString line = in.readLine();
        while(!line.isNull()){
            m_lyrs.append(line+"\n");
            line = in.readLine();
        }
        emit this->lyrsChanged();
    }else {
        m_lyrs.append("none");
    }
}

void EditLyr::setLyrs(QList<QString> lyrs)
{
    m_lyrs = lyrs;
    QFile *fileName = new QFile(m_url);

    if(fileName->open(QIODevice::WriteOnly|QIODevice::Truncate)){
        QTextStream out(fileName);
        for(auto m : m_lyrs){
            out << m;
        }
        emit this->saveSuccess();
    }
}

