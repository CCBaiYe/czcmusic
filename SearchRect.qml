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
            text: qsTr("热门搜索");
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
                ListElement { text_: qsTr("许嵩") }
                ListElement { text_: qsTr("没有理由") }
                ListElement { text_: qsTr("林宥嘉") }
                ListElement { text_: qsTr("侧田") }
                ListElement { text_: qsTr("周杰伦") }
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
