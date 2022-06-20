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
         //color: titleColor
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
         Text{id:tec;
             text: filename
             anchors.left: parent.right
             anchors.leftMargin: 18
         }
         font.pixelSize: 12*dp;
     }
        MouseArea{
            anchors.fill: parent
            onDoubleClicked: {
                //var count=fileDialog.listM.
            }
        }

}
