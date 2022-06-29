import QtQuick
import QtQuick.Controls

Rectangle{
    id:searchrect
    radius: 5
    //border.color: "#f0f0f0"
    border.width: 3
    Rectangle{
        id:rect1
        width: searchrect.width
        height: 30
        Label{
            text: qsTr("Popular");
            anchors.verticalCenter: rect1.verticalCenter
            anchors.left: rect1.left
            anchors.leftMargin: 5
        }
    }
    Rectangle{
        id:rect2
        width: searchrect.width
        height: searchrect.height-rect1.height
        anchors.top: rect1.bottom
        ListView{
            id:hotsearch
            model: hotsearchtextlist
            delegate: hotsearchtextviewdelegate
            ListModel{
                id:hotsearchtextlist
                ListElement { text_: qsTr("xusong") }
                ListElement { text_: qsTr("NoReason") }
                ListElement { text_: qsTr("CaiXuKun") }
                ListElement { text_: qsTr("LuoZiXian") }
                ListElement { text_: qsTr("JayChou") }
            }
            Component{
                id:hotsearchtextviewdelegate
                Button{
                    height: 30
                    width: parent.width
                    background: Rectangle{
                        color: hovered ? "#f0f0f0":"#ffffff"
                    }
                    Label{
                        anchors.fill: parent
                        anchors.leftMargin: 20
                        text: text_
                        font.family: "Microsoft YaHei";
                        font.pixelSize: 12
                        verticalAlignment: Label.AlignVCenter
                    }
                }
            }
        }
    }
}
