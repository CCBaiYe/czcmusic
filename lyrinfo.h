#ifndef LYRINFO_H
#define LYRINFO_H

#include <QObject>
#include <QtQml/qqmlregistration.h>
#include <QMap>
class LyrInfo : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QMap<int,QString> lyr READ lyr WRITE setLyr NOTIFY lyrChanged)
    Q_PROPERTY(QString url READ url WRITE setUrl NOTIFY urlChanged)

public:
    explicit LyrInfo(QObject *parent = nullptr);

signals:
    void lyrChanged();

    void urlChanged();

public slots:
    void setLyr(QMap<int,QString> lyr){
        if(m_lyr!=lyr)
            m_lyr = lyr;
    }

    void setUrl(QString url){
        if(m_url!=url){
            m_url = url;
            getLyr(m_url);
        }

    }

public:
    QMap<int,QString> lyr(){
        return m_lyr;
    }

    QString url(){
        return m_url;
    }

private:
    void getLyr(QString url);

    void part(QString &inforPart,QString &timePart);

    int getTime(QString lineInfo);

private:
    QMap<int,QString> m_lyr;
    QString m_url;
};

#endif // LYRINFO_H
