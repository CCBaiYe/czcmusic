#include "lyrinfo.h"
#include <QFile>
#include <QTextStream>
#include <QDebug>
LyrInfo::LyrInfo(QObject *parent)
    : QObject{parent}
{

}

int LyrInfo::duration()
{
    for(int i = 0; i < m_time.length()-1;i++){
        if(m_duration >= m_time[i]&&m_duration<= m_time[i+1]){
            emit this->durationChanged(i);
            return 0;
        }
    }
    emit this->timeOut();
    return -1;
}

void LyrInfo::getLyr(QString url)
{
    m_lyr.clear();
    if(url.endsWith(".mp3")){
        url = url.replace(".mp3",".lrc");
    }
    if(url.startsWith("file://")){
        url=url.remove("file://");
    }
    QFile *file = new QFile(url);


    if(file->open(QIODevice::ReadOnly|QIODevice::Text)){
        QString line;
        QString timePart;
        QTextStream in(file);
        line = in.readLine();

        part(line,timePart);
        while(!line.isNull()){
            m_time.append(getTime(timePart));
            m_lyr.append(line);
            line = in.readLine();
            part(line,timePart);
        }
    }else{
        m_lyr.append("暂无歌词");
    }
}

void LyrInfo::part(QString &inforPart, QString &timePart)
{
    if(inforPart.contains('.')){
        timePart=inforPart.left(10);
        inforPart.remove(timePart);

    }else{
        timePart = inforPart.left(7);
        inforPart.remove(timePart);
    }


}

int LyrInfo::getTime(QString lineInfo)
{
    qint64 minute =lineInfo.mid(1,2).toLongLong()*60*1000;
    qint64 seconds = lineInfo.mid(4,2).toLongLong()*1000;
    qint64 millseconed=lineInfo.mid(7,2).toLongLong();
    if(lineInfo.length()!=6)
        return minute + seconds+millseconed;
    else return minute + seconds;

}

