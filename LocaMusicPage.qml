import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import QtMultimedia
//import Qt.labs.platform
import Qt.labs.folderlistmodel
Item{
    property alias folderfileslistxisible: folderfileslist.visible
    id:pageroot
    width: parent.width
    height: parent.height
    Rectangle{
        id: rectangle1
        width: pageroot.width
        height: pageroot.height/15
        Label {
            id: title
            width: 79
            height: 30
            text: qsTr("本地音乐")
            font.pixelSize: 20
            font.bold: true
            anchors.verticalCenter: rectangle1.verticalCenter
            anchors.left: rectangle1.left
            anchors.leftMargin: 20
            font.family: "Arial"
        }

        Label {
            id: musicNum
            width: 66
            height: 20
            text: dialogs.folderlistm.count+qsTr("首音乐");
            font.pixelSize: 14
            anchors.verticalCenter: rectangle1.verticalCenter
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignBottom
            color: "#0C9DDA"
            anchors.left: title.right
            anchors.leftMargin: 10
        }

        Label{
            id: chooseDir
            width: 66
            height: 20
            anchors.verticalCenter: rectangle1.verticalCenter
            anchors.left: musicNum.right
            anchors.leftMargin: 10
            text: qsTr("选择目录")
            color: "#0C9DDA"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignBottom
            font.pixelSize: 14
            TapHandler{
                cursorShape: Qt.PointingHandCursor;
                onTapped: {
                    dialogs.folderDialog.open();
                    console.log("111");
                    rectangle3.visible=false;
                    label.visible=false;label1.visible=false;
                    folderfileslist.visible=true;
                }
            }
        }
        Label{
            id: newMusic
            width: 66
            height: 20
            anchors.verticalCenter: rectangle1.verticalCenter
            anchors.left: chooseDir.right
            anchors.leftMargin: 10
            text: qsTr("选择音乐")
            color: "#0C9DDA"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignBottom
            font.pixelSize: 14
            TapHandler {
                cursorShape: Qt.PointingHandCursor;
                onTapped:  {dialogs.fileDialog.open();}
            }
        }
    }

    Rectangle{
        id: rectangle2
        anchors.top: rectangle1.bottom
        anchors.topMargin: 2
        width: pageroot.width
        height:pageroot.height-rectangle1.height
        Rectangle {
            id: rectangle3
            width: 240
            height: 75
            anchors.horizontalCenter: rectangle2.horizontalCenter
            anchors.verticalCenter: rectangle2.verticalCenter
            radius: 5
            visible: true
            color:"#1167A8"
            Label{
                anchors.centerIn: rectangle3
                text: qsTr("选择本地文件夹")
                color: "#ffffff"
                font{
                    family: "Microsoft YaHei";
                    pixelSize: 20
                }
            }
            TapHandler{
                cursorShape: Qt.PointingHandCursor;
                onTapped: {
                    dialogs.folderDialog.open();
                    rectangle3.visible=false;
                    label.visible=false;label1.visible=false;
                    folderfileslist.visible=true;
                }

            }
        }
        Label {
            id: label
            text: qsTr("请选择本地音乐")
            font.bold: true
            visible: true
            anchors.bottom: label1.top
            anchors.bottomMargin: 20
            anchors.horizontalCenter: rectangle3.horizontalCenter
            font{
                family: "Microsoft YaHei";
                pixelSize: 18
                bold: true;
            }

        }
        Label {
            id: label1
            text: qsTr("升级本地音乐为高品质并和朋友分享！")
            visible: true
            anchors.bottom: rectangle3.top
            anchors.bottomMargin: 20
            anchors.horizontalCenter: rectangle3.horizontalCenter
            font{
                family: "Microsoft YaHei";
                pixelSize: 16
            }
        }
        ListView{
            visible: false
            id:folderfileslist
            width: rectangle2.width
            height: rectangle2.height
            model: dialogs.savefoldermodel
            delegate: FolderListBtn{
                count:Count;
                filename:fileName;
                fileartist: fileArtist;
                filealbum: fileAlbum
                filetime: fileTime
            }
        }
    }

}



