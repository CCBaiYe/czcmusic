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
            type:"推荐"
            symbolText_:"\uf00e"
            itemText_:"发现音乐"
            fontfamily_:"FontAwesome"
            count:1
        }
        ListElement{
            type:"推荐"
            symbolText_:"\uf26c"
            itemText_:"MV"
            fontfamily_:"Solid"
            count:2
        }
        ListElement{
            type:"推荐"
            symbolText_:"\uf0c0"
            itemText_:"朋友"
            fontfamily_:"Solid"
            count:3
        }
        ListElement{
            type:"我的音乐"
            symbolText_:"\uf192"
            itemText_:"本地音乐"
            fontfamily_:"Solid"
            count:4
        }
        ListElement{
            type:"我的音乐"
            symbolText_:"\uf019"
            itemText_:"下载管理"
            fontfamily_:"FontAwesome"
            count:5
        }
        ListElement{
            type:"我的音乐"
            symbolText_:"\uf017"
            itemText_:"最近播放"
            fontfamily_:"Regular"
            count:6
        }
        ListElement{
            type:"我的音乐"
            symbolText_:"\uf0c2"
            itemText_:"我的音乐云盘"
            fontfamily_:"Solid"
            count:7
        }
        ListElement{
            type:"我的音乐"
            symbolText_:"\uf2ce"
            itemText_:"歌词编辑"
            fontfamily_:"Solid"
            count:8
        }
        ListElement{
            type:"我的音乐"
            symbolText_:"\uf0fe"
            itemText_:"我喜欢的音乐"
            fontfamily_:"Solid"
            count:9
        }
        ListElement{
            type:"创建的歌单"
            symbolText_:"\uf004"
            itemText_:"创建歌单"
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
//    Popup{
//        id:input
//        x:150
//        y:450
//        width: 150
//        height: 30
//        TextField{
//            id: inputtext
//            anchors.fill: parent
//            width: parent.width
//            height: parent.height
//            font.pixelSize: 13
//            placeholderText: qsTr("歌单名称");
//            selectByMouse: true
//            verticalAlignment: Text.AlignVCenter
//            Keys.onPressed: event=>{
//                if(event.key===Qt.Key_Return)
//                   {
//                      var songlistname=inputtext.text;
//                      nav.navbarListmodel.append({"type":"创建的歌单","itemText_":songlistname,
//                                                 "symbolText_":"\uf03a","fontfamily_":"Solid","Count":nav.navbarListmodel.count+1})
//                      input.close();
//           }
//        }
//        }
//    }
}
