#include "player.h"
#include <QMediaPlayer>
#include <QAudioOutput>
#include <QVBoxLayout>
#include <QMediaMetaData>
#include<QLabel>
#include<QFileDialog>
#include<QMouseEvent>
#include<QSlider>
Player::Player(QObject *parent)
    : QObject(parent)
{


    //player->setAudioOutput(audioOutput);
//    connect(player,&QMediaPlayer::durationChanged,this,&Player::durationChanged);
//    connect(player, &QMediaPlayer::positionChanged, this, &Player::positionChanged);
    //m_slider->setRange(0, player->duration());
    //connect(m_slider, &QSlider::sliderMoved, this, &Player::seek);

    //displayLayout={new QVBoxLayout};
    //displayLayout->addWidget(videoWidget);
    //setLayout(displayLayout);
}
Player::~Player()
{

}

void Player::playSL(QString path)
{
    //player->setSource(QUrl::fromLocalFile(path));
    player->setSource(QUrl(path));
    player->play();
    auto name = path.mid(path.lastIndexOf('/')+1);
    name.chop(4);
    emit musicChanged(name);
}

void Player::openFile()
{
//    QString fileName = QFileDialog::getOpenFileName(this,
//                               tr("Open line"), ".",
//                               tr("Textline files (*.mp3);all files(*.*)"));
//    player->setSource(QUrl(fileName));
//    player->play();
}

void Player::startFile()
{
    player->play();
}

void Player::pauseFile()
{
    player->pause();
}
void Player::stopFile()
{
    player->stop();
}
void Player::durationChanged(qint64 duration)
{
    m_duration = duration / 1000;
    m_slider->setMaximum(duration);
}
void Player::seek(int mseconds)
{
    player->setPosition(mseconds);
}
void Player::positionChanged(qint64 progress)
{
    if (!m_slider->isSliderDown())
        m_slider->setValue(progress);

    updateDurationInfo(progress / 1000);
}
void Player::updateDurationInfo(qint64 currentInfo)
{
    QString tStr;
    if (currentInfo || m_duration) {
        QTime currentTime((currentInfo / 3600) % 60, (currentInfo / 60) % 60,
            currentInfo % 60, (currentInfo * 1000) % 1000);
        QTime totalTime((m_duration / 3600) % 60, (m_duration / 60) % 60,
            m_duration % 60, (m_duration * 1000) % 1000);
        QString format = "mm:ss";
        if (m_duration > 3600)
            format = "hh:mm:ss";
        tStr = currentTime.toString(format) + " / " + totalTime.toString(format);
    }
    m_label->setText(tStr);
}

