import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia
import Qt.labs.folderlistmodel
Rectangle{
    property alias palyslider: sliderWindow
    property alias playmodel: playModeBtn.playMode
    property alias songlist: songlist
    property alias footimage: footimage
    property alias showDesktop: showDesktop
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
        color: "#ffc480"
        opacity: 0.3
        anchors{
            top:border__.bottom
            topMargin: 1*dp
            left: parent.left
            leftMargin: 1*dp
            bottom: parent.bottom
            bottomMargin: 1*dp
        }
        Image {
            id:footimage
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
        }
        Label{
            text: "\uf065"
            font.family: "FontAwesome"
            font.pixelSize: parent.width/1.5
            anchors.verticalCenter: musicInfoImage.verticalCenter
            anchors.horizontalCenter: musicInfoImage.horizontalCenter
        }

        TapHandler{
            cursorShape: Qt.PointingHandCursor;
            onTapped: {
                   songlist.visible=!songlist.visible
            }
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

            cursorShape: Qt.PointingHandCursor;
            onTapped:  {
                switch(mdp.mdplayer.playbackState) {
                    case MediaPlayer.PlayingState: mdp.desktoppausebtn(); break;
                    case MediaPlayer.PausedState: mdp.desktopbtncontrol(); break;
                    case MediaPlayer.StoppedState: mdp.desktopbtncontrol(); break;
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
            right: showDesktop.left
            rightMargin:3*dp
            top:root.top
            topMargin: 9*dp
            bottom:root.bottom
            bottomMargin: 5*dp
        }

    }

    //桌面歌词
    MusicControlBtn{
        id:showDesktop
        border.color: "grey"
        color: "transparent"
        anchors{
            right: playModeBtn.left
            rightMargin:0
            top:root.top
            topMargin: 5*dp
            bottom:root.bottom
            bottomMargin: 5*dp
        } 
        width: 25
        Text{
            id:tex
            text: qsTr("词")
            anchors.centerIn: parent
            font.pointSize: 14
            color: "grey"
            TapHandler{
                cursorShape: Qt.PointingHandCursor;
                onTapped: {

                    if(desktopLrc.visible){
                        tex.color="grey"
                        desktopLrc.visible=false
                    }else {tex.color="lightblue";desktopLrc.visible=true}
                }
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
        text:playMode==0?"\uf03a":(playMode==1?"\uf074":playMode==2?"\uf0ec":"")
        TapHandler{
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
        x:(showDesktop.x+showDesktop.width/2 - width/9*2.5)
        width: 700*dp
        height: parent.height*dp*8
    }
    SongList{
        id:songlist
        visible: false
        y:(border__.y-height)
        width: rootwidth
        height: splitviewheiht
    }

}

