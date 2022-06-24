#include "lyrinfo.h"
#include <QFile>
#include <QTextStream>
LyrInfo::LyrInfo(QObject *parent)
    : QObject{parent}
{

}

void LyrInfo::getLyr(QString url)
{
    QFile *file = new QFile(url);
    if(file->open(QIODevice::ReadOnly|QIODevice::Text)){
        QString line;
        QString timePart;
        QTextStream in(file);
        line = in.readLine();
        part(line,timePart);
        while(!line.isNull()){
            m_lyr.insert(getTime(timePart),line);
            line = in.readLine();
            part(line,timePart);
        }
    }
}

void LyrInfo::part(QString &inforPart, QString &timePart)
{
    timePart = inforPart.left(7);
    inforPart.remove(timePart);
}

int LyrInfo::getTime(QString lineInfo)
{
    qint64 minute =lineInfo.mid(1,2).toLongLong()*60*1000;
    qint64 seconds = lineInfo.mid(4,2).toLongLong()*1000;
    return minute + seconds;
}

