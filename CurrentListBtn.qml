import QtQuick 2.15
import QtQuick.Controls 2.15

 Button{
     property color hoveredColor: "#c8c9cc"
     property color clickedColor: "#c8c9cc"
     property color normalColor: "#dddde1"
     property bool currentItem : false;
     property string fontfamily;
     property string filename;
     property string count;
     property string type;
     property string fileartist
     property string filetime


     id:navItemBtn;
     width: widthw;
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
         text: count;
         anchors.verticalCenter: navItemBtn.verticalCenter
         font.pixelSize: 13;
         Label{
             id:tec1;
             text: filename
             width: 100
             elide: Text.ElideRight
             anchors.left: parent.right
             font.pixelSize: 13;
         }
         Label{
             id:tec2;
             text: fileartist
             width: 150
             elide: Text.ElideRight
             anchors.left: symbolText_.right
             anchors.leftMargin: 100
             font.pixelSize: 13;
         }
         Label{
             id:tec3;
             text: filetime
             anchors.left: symbolText_.right
             anchors.leftMargin: 270
             font.pixelSize: 13;
         }
     }
}
