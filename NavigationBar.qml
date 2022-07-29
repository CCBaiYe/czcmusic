import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    property color backGroundColour: "#f3f3f5";  //边框颜色
    property alias navbarListmodel: navbarListmodel
    property alias songlistName: inputtext.text
    color: backGroundColour
    ListModel{
        id:navbarListmodel
        ListElement{
            type:qsTr("recommend")
            symbolText_:"\uf00e"
            itemText_:qsTr("Search New Song")
            fontfamily_:"FontAwesome"
            Count:1
        }
        ListElement{
            type:qsTr("recommend")
            symbolText_:"\uf26c"
            itemText_:qsTr("MV")
            fontfamily_:"Solid"
            Count:2
        }
        ListElement{
            type:qsTr("recommend")
            symbolText_:"\uf0c0"
            itemText_:qsTr("Friend")
            fontfamily_:"Solid"
            Count:3
        }
        ListElement{
            type:qsTr("MySong")
            symbolText_:"\uf192"
            itemText_:qsTr("Local Music")
            fontfamily_:"Solid"
            Count:4
        }
        ListElement{
            type:qsTr("MySong")
            symbolText_:"\uf019"
            itemText_:qsTr("Download Manage")
            fontfamily_:"FontAwesome"
            Count:5
        }
        ListElement{
            type:qsTr("MySong")
            symbolText_:"\uf017"
            itemText_:qsTr("Recents")
            fontfamily_:"Regular"
            Count:6
        }
        ListElement{
            type:qsTr("MySong")
            symbolText_:"\uf0c2"
            itemText_:qsTr("MySongCloud")
            fontfamily_:"Solid"
            Count:7
        }

        ListElement{
            type:qsTr("MySong")
            symbolText_:"\uf2ce"
            itemText_:qsTr("EditLyr")
            fontfamily_:"Solid"
            Count:8
        }
        ListElement{

            type:qsTr("MySong")
            symbolText_:"\uf0fe"
            itemText_:qsTr("MyCollection")
            fontfamily_:"Solid"
            Count:9
        }
        ListElement{
            type:qsTr("List")
            symbolText_:"\uf055"
            itemText_:qsTr("Create List")
            fontfamily_:"Regular"
            Count:10
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
    Popup{
        id:input
        x:150
        y:200
        width: 150
        height: 40
        TextField{
            id: inputtext
            anchors.fill: parent
            width: parent.width
            height: parent.height
            font.pixelSize: 13
            placeholderText: qsTr("list name");
            selectByMouse: true
            verticalAlignment: Text.AlignVCenter
            Keys.onPressed: event=>{
                if(event.key===Qt.Key_Return)
                   {
                      var songlistname=inputtext.text;

                      db.createlist(songlistname)//创建歌单
//                      songplaylist.createlist(songlistname);


                      navbarListmodel.append({"type":qsTr("List"),"itemText_":songlistname,
                                                 "symbolText_":"\uf0ca","fontfamily_":"Solid","Count":navbarListmodel.count+1})
                      input.close();
                   }
            }
        }
    }

}
