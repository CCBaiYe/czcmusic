import QtQuick 2.15
import Qt.labs.folderlistmodel
import QtQuick.Controls
Rectangle{
    color: "#dddde1"
    property alias widthw: listv.width
    property alias heighth: listv.height
    width: parent.width
    height: parent.height
    ListView {
        id:listv
        width: parent.width
        height: parent.height
        //滚动条
        ScrollBar.vertical: ScrollBar{
            width: 30
            policy: ScrollBar.AlwaysOn
        }
        model: dialogs.listM

        delegate: Item {
            width: 700
            height: 30
            CurrentListBtn{count:Count;filename:fileName;fileartist: fileArtist;filetime: fileTime}
            MouseArea{
                anchors.fill: parent
                onDoubleClicked: {
                    mdp.mdplayer.stop()
                    footer.palyslider.musicName=dialogs.listM.get(index).fileName
                    mdp.mdplayer.source=dialogs.listM.get(index).filePath
                    mdp.mdplayer.play();
                }
            }


        }
    }
}


