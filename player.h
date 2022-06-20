#ifndef FREEPLAYCW_H
#define FREEPLAYCW_H

#include <QSharedDataPointer>
#include <QWidget>

class FreePlayCwData;
class QMediaPlayer;
class QVideoWidget;
class QAudioOutput;
class QVBoxLayout;
class QMediaMetaData;
class QSlider;
class QLabel;
QT_BEGIN_NAMESPACE
QT_END_NAMESPACE
class Player:public QObject
{
    Q_OBJECT
public:
    Player(QObject *parent = nullptr);
    ~Player();
    Q_INVOKABLE void openFile();
    void startFile();
    void pauseFile();
    void stopFile();
    Q_INVOKABLE void playSL(QString);
private slots:
    void seek(int mseconds);
    void durationChanged(qint64 duration);
    void positionChanged(qint64 progress);
signals:
    void musicChanged(QString);

private:
    void updateDurationInfo(qint64 currentInfo);
    QStringList m_paths;
    int m_currentIndex{-1};
    QAudioOutput *audioOutput;
    QVideoWidget *videoWidget;
    QMediaPlayer *player;
    QVBoxLayout *displayLayout;
    qint64 m_duration;
    QSlider *m_slider;
    QLabel *m_label;
};

#endif // FREEPLAYCW_H
