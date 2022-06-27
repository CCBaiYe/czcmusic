import QtQuick 2.15
import QtQuick.Controls 2.15

 Button{
     property color hoveredColor: "#dddde1"
     property color clickedColor: "#dddde1"
     property color normalColor: "white"
     property bool currentItem : false;
     property real mx:0.0
     property real my: 0.0
     property string fontfamily;
     property string count  //索引
     property string title; //标题
     property string artist; //歌手
     property string album; //专辑
     property string time //时长

     id:navItemBtn;
     width: pageloaderw
     height: 30*dp;
     background:Rectangle{
         id:backgroundRect;
         color: currentItem ? clickedColor:(hovered?hoveredColor:normalColor)
     }


     Rectangle{
         id:chooseItem
         visible: currentItem
         anchors.left: parent.left
         anchors.top:parent.top
         height: parent.height
         width: 3*dp
     }

     Label{
         id:symbolText_
         anchors{
             left: parent.left
             leftMargin: 1*dp
         }
         width: parent.height - 2*dp
         height: parent.height - 2*dp
         text: count
         font.pixelSize: 15
         Label{
             id:tec1
             Text{
                 text: title
                 width: 200
                 anchors.left: tec1.left
                 elide: Text.ElideRight
             }
             anchors.left: symbolText_.right
             anchors.top: symbolText_.top
             anchors.topMargin: 2
             anchors.leftMargin: 20
             font.pixelSize: 15;
         }
         Label{
             id:tec2
             Text{
                 text: artist
                 width: 200
                 anchors.left: tec2.left
                 elide: Text.ElideRight
             }
             anchors.left: tec1.right
             anchors.top: symbolText_.top
             anchors.topMargin: 2
             anchors.leftMargin: 220
             font.pixelSize: 15;
         }
         Label{
             id:tec3
             Text{
                 text: album
                 width: 200
                 anchors.left: tec3.left
                 elide: Text.ElideRight
             }
             anchors.left: tec2.right
             anchors.top: symbolText_.top
             anchors.topMargin: 2
             anchors.leftMargin: 220
             font.pixelSize: 15;
         }
         Label{
             id:tec4
             Text{
                 text: time
                 anchors.left: tec4.left
             }
             anchors.left: tec3.right
             anchors.top: symbolText_.top
             anchors.topMargin: 2
             anchors.leftMargin: 220
             font.pixelSize: 15;
         }
     }



}
