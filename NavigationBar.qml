import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    property color backGroundColour: "#f3f3f5";  //边框颜色
    property alias navbarListmodel: navbarListmodel
    color: backGroundColour
    ListModel{
        id:navbarListmodel
        ListElement{
            type:qsTr("recommend")
            symbolText_:"\uf00e"
            itemText_:qsTr("Search New Song")
            fontfamily_:"FontAwesome"
            count:1
        }
        ListElement{
            type:qsTr("recommend")
            symbolText_:"\uf26c"
            itemText_:qsTr("MV")
            fontfamily_:"Solid"
            count:2
        }
        ListElement{
            type:qsTr("recommend")
            symbolText_:"\uf0c0"
            itemText_:qsTr("Friend")
            fontfamily_:"Solid"
            count:3
        }
        ListElement{
            type:qsTr("MySong")
            symbolText_:"\uf192"
            itemText_:qsTr("Local Music")
            fontfamily_:"Solid"
            count:4
        }
        ListElement{
            type:qsTr("MySong")
            symbolText_:"\uf019"
            itemText_:qsTr("Download Manage")
            fontfamily_:"FontAwesome"
            count:5
        }
        ListElement{
            type:qsTr("MySong")
            symbolText_:"\uf017"
            itemText_:qsTr("Recents")
            fontfamily_:"Regular"
            count:6
        }
        ListElement{
            type:qsTr("MySong")
            symbolText_:"\uf0c2"
            itemText_:qsTr("MySongCloud")
            fontfamily_:"Solid"
            count:7
        }
        ListElement{
            type:qsTr("MySong")
            symbolText_:"\uf2ce"
            itemText_:qsTr("EditLyr")
            fontfamily_:"Solid"
            count:8
        }
        ListElement{
            type:qsTr("MySong")
            symbolText_:"\uf0fe"
            itemText_:qsTr("MyCollection")
            fontfamily_:"Solid"
            count:9
        }
        ListElement{
            type:qsTr("List")
            symbolText_:"\uf004"
            itemText_:qsTr("LikeMusic")
            fontfamily_:"Regular"
            count:10
        }
    }


    ListView {
            id: navbarListView
            width: parent.width
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            model: navbarListmodel
            delegate: NavBarBtn { symbolText: symbolText_; itemText: itemText_;fontfamily:fontfamily_;}

            section.property: "type"
            section.criteria: ViewSection.FullString
            section.delegate: sectionHeading

            ScrollBar.vertical: ScrollBar{

            }
        }
    Component{
        id:sectionHeading
        Rectangle{
            width: navbarListView.width
            height: 30*dp
            color: backGroundColour
            Label {
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.top: parent.top
                font.family: "FontAwesome"
                anchors.topMargin: 3*dp
                anchors.bottom: parent.bottom
                text: section === "top" ? "":section
                font{family:"Microsoft YaHei"; pixelSize: 11*dp}
                verticalAlignment:Label.AlignVCenter;
                color: "#999999"
            }

        }
    }
}
