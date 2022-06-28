import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs
import EditLyr 1.0
Rectangle {
    function loadFile(){

    }

    anchors.fill: parent
    Rectangle {
        id: buttonArea
        height: 20
        Button {
            id: openLyrFIle
            text: qsTr("&Open")
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            onClicked: openLyr.open()
        }
        Button {
            id: saveLyrFile
            text: qsTr("&Save")
            anchors.left: openLyrFIle.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            onClicked: {

            }
        }
        Button {
            id: addLyrFile
            text: qsTr("&Add")
            anchors.left: saveLyrFile.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
        }
        Button {
            id: revokeLyrFile
            text: qsTr("&Revoke")
            anchors.left: addLyrFile.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
        }
    }
    EditLyr {
        id: editlyr
        onLyrsChanged: {
            textarea.text = "";
            var taskMap = editlyr.lyrs;
            for(var key in taskMap){
                textarea.text +=taskMap[key];
            }
        }
    }

    TextArea {
        id: textarea
        anchors.top: buttonArea.bottom
        font.pointSize: 20
        text: "null"
    }

    FileDialog {
        id: openLyr
        nameFilters: ["Text files (*.lrc)"]
        fileMode: FileDialog.OpenFile | FileDialog.SaveFile
        onAccepted: {
            editlyr.setUrl(currentFile)
        }
    }
}
