#ifndef LYRINFO_H
#define LYRINFO_H

#include <QObject>
#include <QtQml/qqmlregistration.h>
class LyrInfo : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QList<QString> lyr READ lyr WRITE setLyr NOTIFY lyrChanged)
    Q_PROPERTY(QString url READ url WRITE setUrl NOTIFY urlChanged)
    Q_PROPERTY(QList<int> time READ time WRITE setTime NOTIFY timeChanged)
    Q_PROPERTY(qint64 duration READ duration WRITE setDuration NOTIFY durationChanged)
public:
    explicit LyrInfo(QObject *parent = nullptr);

signals:
    void lyrChanged();

    void urlChanged();

    void timeChanged();

    void durationChanged(int i);

    void timeOut();

public slots:

    void setLyr(QList<QString> lyr){
        m_lyr.clear();
        m_lyr = lyr;
    }

    void setUrl(QString url){
        m_url = url;
        getLyr(m_url);
        emit this->urlChanged();

    }

    void setTime(QList<int> time){
        m_time = time;
    }

    void setDuration(qint64 inDuration){
        m_duration = inDuration;
        duration();
    }
public:
    QList<QString> lyr(){
        return m_lyr;
    }

    QString url(){
        return m_url;
    }
    QList<int> time(){
        return m_time;
    }

    int duration();

private:
    void getLyr(QString url);

    void part(QString &inforPart,QString &timePart);

    int getTime(QString lineInfo);

private:
    QList<QString> m_lyr;
    QString m_url = "";
    QList<int> m_time;
    qint64 m_duration;
};

#endif // LYRINFO_H
