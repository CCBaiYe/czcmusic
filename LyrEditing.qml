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
        Button {
            id: saveAsLyrFile
            text: qsTr("SaveAs")
            anchors.left: saveLyrFile.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.leftMargin: 10
            onClicked: {
                saveAsLyr.open()
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
            popup.open()
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
        id: saveAsLyr
        fileMode: FileDialog.SaveFile
        nameFilters: ["Text files (*.lrc)"]
        onAccepted: {
            editlyr.setSaveAsUrl(currentFile)
            editlyr.setLyrs(textarea.text)
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
    Popup {
        id: popup
        x: 200
        y: 200
        width: 300
        height: 300
        contentItem: Text {
            width: 300
            text: "Save Successfully!\nPlease press esc\nto close message"
            color: "red"
            font.pixelSize: 40
            //自动换行
            wrapMode: Text.WordWrap
            //行间距
            lineHeight: 0.7
            //水平居中
            horizontalAlignment: Text.AlignHCenter
            //垂直居中
            verticalAlignment: Text.AlignVCenter
        }

        closePolicy: Popup.CloseOnEscape
    }
}
