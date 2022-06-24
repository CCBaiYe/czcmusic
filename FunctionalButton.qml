import QtQuick
import QtQuick.Controls
Rectangle {
    Button {
        id: closeButton
        icon.name: "window-close"
        width: 20
        height: 20
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: 15
        onClicked: {
            close()
        }
        background: Rectangle {
            color: "lightgray"
        }
    }
    Button {
        id: maxButton
        icon.name: "window-maximize"
        width: 20
        height: 20
        anchors.right: closeButton.left
        anchors.top: closeButton.top
        anchors.rightMargin: 15
        onClicked: {
            if(root.visibility === Window.Maximized){
                root.showNormal()
            }else {
                root.showMaximized()
            }
        }
        background: Rectangle {
            color: "lightgray"
        }
    }
    Button {
        id:minButton
        icon.name: "window-minimize"
        width: 20
        height: 20
        anchors.right: maxButton.left
        anchors.top: maxButton.top
        anchors.rightMargin: 15
        onClicked: {
            root.visibility = "Minimized"
        }
        background: Rectangle {
            color: "lightgray"
        }
    }
    Button {
        id: setupButton
        icon.name: "document-page-setup"
        width: 20
        height: 20
        anchors.right: minButton.left
        anchors.top: minButton.top
        anchors.rightMargin: 15
        onClicked: {

        }
        background: Rectangle {
            color: "lightgray"
        }
    }
}
