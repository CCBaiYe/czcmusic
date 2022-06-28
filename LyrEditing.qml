import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs
import Qt.labs.platform
import EditLyr 1.0
Rectangle {
    function loadFile(){

    }

    anchors.fill: parent
    Rectangle {
        color:"lightblue"
        id: buttonArea
        height: 30
        anchors.left: parent.left
        anchors.right: parent.right
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
            anchors.leftMargin: 10
            onClicked: {
                editlyr.setLyrs(textarea.text)
            }
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
        onSaveSuccess: {
        }
    }
    ScrollView {
        anchors.top: buttonArea.bottom
        anchors.bottom: parent.bottom
        TextArea {
            id: textarea
            font.pointSize: 20
            text: qsTr("[00:00]")
        }
    }
    FileDialog {
        id: saveLyr
        fileMode: FileDialog.SaveFile
        nameFilters: ["Text files (*.lrc)"]
        onAccepted: {
            console.log("save")
        }
    }

    FileDialog {
        id: openLyr
        nameFilters: ["Text files (*.lrc)"]
        fileMode: FileDialog.OpenFile
        onAccepted: {
            editlyr.setUrl(currentFile)
        }
    }
}
