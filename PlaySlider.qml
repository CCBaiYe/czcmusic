import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts




Rectangle{
    property bool nolabel: true
    property int duringTime:0
    property alias musicName: songInfo.text
    property alias musicDuringText: songTimeInfo.text
    id:sliderroot
    Slider {
        id: sliderControl
        z:1
        anchors.left: parent.left
        width: parent.width
        anchors.top:parent.top
        anchors.topMargin: parent.height/9*2
        anchors.bottom: parent.bottom        
        enabled: true
        value:mdp.mdplayer.duration > 0 ? mdp.mdplayer.position / mdp.mdplayer.duration : 0
        onMoved: function () {

                mdp.mdplayer.position = mdp.mdplayer.duration * sliderControl.position

        }
        //进度条
        background: Rectangle {
            x: sliderControl.leftPadding
            y: sliderControl.topPadding + sliderControl.availableHeight / 2 - height / 2
            width: sliderControl.width
            implicitHeight: 3*dp
            height: implicitHeight
            radius: 3*dp;
            color: "#999999"

            Rectangle {
                width: sliderControl.visualPosition * sliderControl.width
                height: parent.height
                color: "#b82525"
                radius: 3*dp
            }
            TapHandler{
                cursorShape: Qt.PointingHandCursor;
            }
        }
        //圆点
        handle: Rectangle {
            x: sliderControl.leftPadding + sliderControl.visualPosition * (sliderControl.availableWidth - width)
            y: sliderControl.topPadding + sliderControl.availableHeight / 2 - height / 2
            width: 10*dp;
            height: 10*dp;
            radius: 10*dp;
            color: "#f6f6f6"
            Label{
                id:cd;
                anchors.verticalCenter: parent.verticalCenter;
                anchors.horizontalCenter: parent.horizontalCenter;
                text: "\uf192";
                color: "#b82525";
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter;
                font.pixelSize: 10*dp;
            }
        }
    }
    Label{
        id:songInfo
        visible: nolabel
        text: ""
        anchors{
            left: sliderControl.left
            leftMargin: 1*dp
            right: songTimeInfo.left
            rightMargin: 8*dp
            top:parent.top
            topMargin: 1*dp
            bottom: sliderControl.verticalCenter
        }

        font{
            family: "Microsoft YaHei"
            pixelSize: 11;
            bold: false;
        }
        color: "#777777"
    }

    Label{
        id:songTimeInfo
        visible: nolabel
        width: 60*dp
        text:qsTr(dialogs.fileDialog.setTime(mdp.mdplayer.position) + "/" + dialogs.fileDialog.setTime(mdp.mdplayer.duration))
        anchors{
            right : sliderControl.right
            rightMargin: 5*dp
            verticalCenter: songInfo.verticalCenter
        }

        font{
            family: "Microsoft YaHei"
            pixelSize: 10;
            bold: false;
        }
        color: "#777777"
        horizontalAlignment: Text.AlignRight
    }


}
