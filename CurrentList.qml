import QtQuick 2.15
import Qt.labs.folderlistmodel
import FileIo 1.0
import QtQuick.Controls
Rectangle{
    color: "#dddde1"
    property alias widthw: listv.width
    property alias heighth: listv.height
    ListView {
        id:listv
        width: parent.width
        height: parent.height

//        FolderListModel {
//            id: folderModel
//            //folder: "file:///root/tmp"
//            folder: fileDialog.setFile()
//            nameFilters: ["*.mp3",]
//        }
        //滚动条
        ScrollBar.vertical: ScrollBar{
            width: 30
            policy: ScrollBar.AlwaysOn
        }


        model: fileDialog.listM

        delegate: CurrentListBtn{count:Count;filename:fileName}
        }
    }


