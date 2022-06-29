import QtQuick
import QtQuick.Controls
Item {
    id:likelistroot
    width: parent.width
    height: parent.height

    Label{
        id:likeTitle
        anchors.top: parent.top
        width: parent.width
        height: 30
        text: ""
        font.pixelSize: 15
        Label{
            id:tec1
            Text{
                text: qsTr("标题")
                anchors.left: tec1.left

            }
            anchors.left: likeTitle.left
            anchors.top: likeTitle.top
            anchors.topMargin: 2
            anchors.leftMargin: 60
            font.pixelSize: 15;
        }
        Label{
            id:tec2
            Text{
                text: qsTr("歌手")
                anchors.left: tec2.left

            }
            anchors.left: tec1.right
            anchors.top: likeTitle.top
            anchors.topMargin: 2
            anchors.leftMargin: 220
            font.pixelSize: 15;
        }
        Label{
            id:tec3
            Text{
                text: qsTr("专辑")
                anchors.left: tec3.left

            }
            anchors.left: tec2.right
            anchors.top: likeTitle.top
            anchors.topMargin: 2
            anchors.leftMargin: 220
            font.pixelSize: 15;
        }
        Label{
            id:tec4
            Text{
                text: qsTr("时长")
                anchors.left: tec4.left
            }
            anchors.left: tec3.right
            anchors.top: likeTitle.top
            anchors.topMargin: 2
            anchors.leftMargin: 220
            font.pixelSize: 15;
        }
    }
    ListView{
        id:likelist
        anchors.top: likeTitle.bottom
        width: parent.width
        height: parent.height-30
        model: songplaylistmodel
        delegate: dele
    }
    Component{
        id:dele
        Row{
            spacing: 150

            Text{text:Title;font.pixelSize: 13}
            Text{text:Artist;font.pixelSize: 13}
            Text{text:Album;font.pixelSize: 13}
            Text{text:Time;font.pixelSize: 13}
        }
    }


}
