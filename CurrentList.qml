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
            CurrentListBtn{count:Count;filename:fileName;fileartist:fileArtist;filetime:fileTime}
            MouseArea{
                anchors.fill: parent
                acceptedButtons:Qt.LeftButton
                onDoubleClicked: {
                    play1.triggered()
                }
                onClicked: {
                    listv.currentIndex=index
                }
            }
            MouseArea{
                anchors.fill: parent
                acceptedButtons: Qt.RightButton
                onClicked: {
                    menu1.popup()
                }
            }
            Menu{
                id:menu1
                contentData: [play1,pause1,addlove,creatlist]

            }

        }
    }
    Action{
        id:pause1
        text: qsTr("pause")
        icon.name: "media-playback-pause"
        onTriggered:mdp.desktoppausebtn()

    }
    Action{
        id:play1
        text: qsTr("play")


        icon.name: "media-playback-start"
        onTriggered: {
            mdp.mdplayer.stop()
            footer.palyslider.musicName=dialogs.listM.get(listv.currentIndex).fileName
            mdp.mdplayer.source=dialogs.listM.get(listv.currentIndex).filePath
            mdp.desktopbtncontrol()
            loadFromFile.writeData(dialogs.listM.get(listv.currentIndex).fileName,
                                   dialogs.listM.get(listv.currentIndex).filePath,
                                   dialogs.listM.get(listv.currentIndex).fileArtist,
                                   dialogs.listM.get(listv.currentIndex).fileAlbum,
                                   dialogs.listM.get(listv.currentIndex).fileTime)
        }

    }
    Action{
        id:addlove
        text: qsTr("like")
        icon.name: "list-add"
        onTriggered: {

        }
    }
    Action{
        id:creatlist
        text: qsTr("add list")
        onTriggered: {

        }
    }


}




