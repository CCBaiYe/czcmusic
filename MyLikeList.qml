import QtQuick
import QtQuick.Controls

Rectangle {

    property string songlistname
    id:likelistroot
    width: parent.width
    height: parent.height
    color: "white"
    Rectangle{
        id:songtitle
        width: likelistroot.width
        height: 35
        Label{
            id:symbolText_
            anchors{
                left: parent.left
                leftMargin: 1*dp
            }
            width: parent.height - 2*dp
            height: parent.height - 2*dp
            text: "  "
            anchors.verticalCenter: songtitle.verticalCenter
            font.pixelSize: 15;
            Label{
                id:tec1;
                text: qsTr("Title")
                width: 100
                elide: Text.ElideRight
                anchors.left: parent.right
                anchors.leftMargin: 0
                font.pixelSize: 15;
            }
            Label{
                id:tec2;
                text: qsTr("Singer")
                width: 150
                elide: Text.ElideRight
                anchors.left: symbolText_.right
                anchors.leftMargin: 200
                font.pixelSize: 15;
            }
            Label{
                id:tec3;
                text: qsTr("Album")
                anchors.left: symbolText_.right
                anchors.leftMargin: 450
                font.pixelSize: 15;
            }
            Label{
                id:tec4;
                text: qsTr("Duration")
                anchors.left: symbolText_.right
                anchors.leftMargin: 700
                font.pixelSize: 15;
            }
        }
    }
    ListView{
        id:likelist
        anchors.top: songtitle.bottom
        width: parent.width
        height: parent.height-30
        model: songplaylistmodel
        delegate: FolderListBtn{
            filename:Title;
            fileartist: Artist;
            filealbum: Album;
            filetime: Time;
        }
    }




}
