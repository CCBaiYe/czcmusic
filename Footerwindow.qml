import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia
import Qt.labs.folderlistmodel
Rectangle{
    property alias palyslider: sliderWindow
    property alias playmodel: playModeBtn.playMode
    id:root
    color: "#ffffff"
    Rectangle{
        id:border__
        anchors.top: parent.top
        width: parent.width
        height: 0.5*dp
        color: "red"
    }

    Rectangle{
        id: musicInfoImage
        color: "#123456"
        anchors{
            top:border__.bottom
            topMargin: 1*dp
            left: parent.left
            leftMargin: 1*dp
            bottom: parent.bottom
            bottomMargin: 1*dp
        }
        width: height
    }
    MusicRoundButton{
        id:stepBackward
        anchors{
            left: musicInfoImage.right
            leftMargin: 15*dp
            verticalCenter: parent.verticalCenter
        }
        TapHandler{
            //anchors.fill: parent
            cursorShape: Qt.PointingHandCursor;
            onTapped:  {
                dialogs.fileDialog.preplay();
            }
        }
        width: 25*dp
        text:"\uf048"
    }
    MusicRoundButton{
        id:playBtn
        anchors{
            left: stepBackward.right
            leftMargin: 10*dp
            verticalCenter: parent.verticalCenter
        }
        width: 30*dp
        text: mdp.mdplayer.playbackState ===  MediaPlayer.PlayingState ? qsTr("\uf04c") : qsTr("\uf04b")
        TapHandler{
            //anchors.fill: parent
            cursorShape: Qt.PointingHandCursor;
            onTapped:  {
                switch(mdp.mdplayer.playbackState) {
                    case MediaPlayer.PlayingState: mdp.mdplayer.pause(); break;
                    case MediaPlayer.PausedState: mdp.mdplayer.play(); break;
                    case MediaPlayer.StoppedState: mdp.mdplayer.play(); break;
                }
            }
        }
    }
    MusicRoundButton{
        id:stepForward
        anchors{
            left: playBtn.right
            leftMargin: 10*dp
            verticalCenter: parent.verticalCenter
        }
        TapHandler{
            //anchors.fill: parent
            cursorShape: Qt.PointingHandCursor;
            onTapped:  {
                dialogs.fileDialog.nextplay();
            }
        }

        width: 25*dp
        text:"\uf051"
    }

    PlaySlider{
        id:sliderWindow
        width: parent.width/2.2
        anchors{
            left: stepForward.right
            leftMargin: 10*dp
            top:parent.top
            topMargin: 1*dp
            bottom: parent.bottom
            bottomMargin: 7*dp
            right: vc.left
            rightMargin: 10*dp
        }
    }

    //yingliang
    VolumnControl{
        id:vc
        width: 100*dp
        anchors{
            right: collectBtn.left
            rightMargin:3*dp
            top:root.top
            topMargin: 9*dp
            bottom:root.bottom
            bottomMargin: 5*dp
        }

    }

    //收藏
    MusicControlBtn{
        id:collectBtn
        property bool isLove: false;
        anchors{
            right: playModeBtn.left
            rightMargin:0
            top:root.top
            topMargin: 5*dp
            bottom:root.bottom
            bottomMargin: 5*dp
        }
        width: height
        text:"\uf0fe"
        color: isLove?"#DC2F2E":"#999999"
        TapHandler{
            //anchors.fill: parent
            cursorShape: Qt.PointingHandCursor;
            onTapped: {
                //collectBtn.isLove = !collectBtn.isLove;
            }
        }
    }


    //播放模式
    MusicControlBtn{
        id:playModeBtn
        property int playMode:0
        anchors{
            right: currentListBtn.left
            rightMargin: 0
            top:root.top
            topMargin: 5*dp
            bottom:root.bottom
            bottomMargin: 5*dp
        }
        width: height
        text:playMode==0?"\uf03a":(playMode==1?"\uf074":playMode==2?"dx":"")
        TapHandler{
            //anchors.fill: parent
            cursorShape: Qt.PointingHandCursor;
            onTapped: {
                switch(playModeBtn.playMode)
                {
                    case 0:playModeBtn.playMode=1;break;
                    case 1:playModeBtn.playMode=2;mdp.mdplayer.loops=MediaPlayer.Infinite;break;
                    case 2:playModeBtn.playMode=0;break;
                    default:break;
                }
            }
        }

    }
    //当前列表
    MusicControlBtn{
        id:currentListBtn
        anchors{
            right: root.right
            rightMargin: 5*dp
            top:root.top
            topMargin: 5*dp
            bottom:root.bottom
            bottomMargin: 5*dp
        }
        width: height
        text:"\uf03c"
        TapHandler{
            //anchors.fill: parent
            cursorShape: Qt.PointingHandCursor;
            onTapped: {
                   currentlist.visible=!currentlist.visible
            }
        }
    }
    CurrentList{
        id:currentlist
        visible: false
        y:(border__.y-height)
        x:(collectBtn.x+collectBtn.width/2 - width/9*2.5)
        width: parent.width
        height: parent.height*dp*8
    }


}

