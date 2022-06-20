import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls
ApplicationWindow {
    id:root
    //flags:Qt.FramelessWindowHint | Qt.Window;
    visible: true
    width:1020
    height: 650
    property alias fileDialog: fileDialog
    property string icon;
    property real dpScale: 1.5;     //在不同的分辨率屏幕下的窗口伸缩因子
    readonly property real dp: Math.max(Screen.pixelDensity*25.4/160*dpScale);
    header: ToolBar{
        id:menu
        height:parent.height*0.07
            Image {
                id: titleIcon
                source: icon
                width: 650*0.07-15*1.5
                height: 650*0.07-15*1.5
                anchors{
                    left: root.left;
                    leftMargin: 5*1.5;
                    verticalCenter: root.verticalCenter;
                }
                TapHandler{
                    onTapped: console.log("image")
                }
            }
    }
    footer: Footerwindow{
        id:footer
        height: root.height*0.07
        width: root.width

    }
    Mediaplayer{
        id:mdp
    }
    FileD {
            id: fileDialog
            }
    SplitView {
        id: splitView
        height: parent.height*0.86
        anchors.fill: parent
        handle: Rectangle {
            implicitWidth: 4
            implicitHeight: 4
            color: SplitHandle.pressed ? "#81e889"
                : (SplitHandle.hovered ? Qt.lighter("#c2f4c6", 1.1) : "#c2f4c6")

            containmentMask: Item {
                x: -width / 2
                width: 64
                height: splitView.height
            }
        }

        NavigationBar{
            implicitWidth: 170
            color: "white"
            width: parent.width
            height: splitView.height
        }

        Rectangle {
            implicitWidth: 50
            color: "white"
            Loader{id:pageLoader

            }
        }
    }
}

