#ifndef EDITLYR_H
#define EDITLYR_H

#include <QObject>

class EditLyr : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString url READ url WRITE setUrl NOTIFY urlChanged)
    Q_PROPERTY(QList<QString> lyrs READ lyrs WRITE setLyrs NOTIFY lyrsChanged)
    Q_PROPERTY(QString saveAsUrl READ saveAsUrl WRITE setSaveAsUrl NOTIFY saveAsUrlChanged)
public:
    explicit EditLyr(QObject *parent = nullptr);

signals:
    void urlChanged();

    void lyrsChanged();

    void saveAsUrlChanged();

    void saveSuccess();
public slots:
    void setUrl(QString url);

    void setLyrs(QList<QString> lyrs);

    void setSaveAsUrl(QString saveAsUrl);

public:
    QString url(){
        return m_url;
    }

    QList<QString> lyrs(){
        return m_lyrs;
    }

    QString saveAsUrl(){
        return m_url;
    }

private:
    QString m_url;
    QList<QString> m_lyrs;
};

#endif // EDITLYR_H
