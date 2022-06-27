#ifndef EDITLYR_H
#define EDITLYR_H

#include <QObject>

class EditLyr : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString url READ url WRITE setUrl NOTIFY urlChanged)
    Q_PROPERTY(QList<QString> lyrs READ lyrs WRITE setLyrs NOTIFY lyrsChanged)

public:
    explicit EditLyr(QObject *parent = nullptr);

signals:
    void urlChanged();
    void lyrsChanged();

public slots:
    void setUrl(QString url);

    void setLyrs(QList<QString> lyrs);

public:
    QString url(){
        return m_url;
    }

    QList<QString> lyrs(){
        return m_lyrs;
    }

private:
    QString m_url;
    QList<QString> m_lyrs;
};

#endif // EDITLYR_H
