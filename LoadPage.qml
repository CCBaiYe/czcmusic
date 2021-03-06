import QtQuick
import QtQuick.Controls

Item {
    id:loadpage
    width: parent.width
    height: parent.height
    Rectangle{
        id:songtitle
        width: loadpage.width
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

    Rectangle{
        id:songlist
        anchors.top: songtitle.bottom
        width: parent.width
        height: parent.height-songtitle.height
        Label{
            opacity: 0.3
            id:loadicon
            text: "\uf019"
            font.family: "FontAwesome"
            font.pixelSize: 100
            anchors.verticalCenter: songlist.verticalCenter
            anchors.horizontalCenter: songlist.horizontalCenter
        }
        ListView{
            id:list
            width: songlist.width
            height: songlist.height
            model: dialogs.loadmodel
            delegate: LoadPageBtn{
                count:Count;
                filename:songName;
                fileartist: songArtist;
                filealbum: songAlbum;
                filetime: songTime;
            }
        }
    }
}
