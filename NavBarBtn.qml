import QtQuick 2.15
import QtQuick.Controls 2.15

 Button{
     property color hoveredColor: "#dddde1"
     property color clickedColor: "#c8c9cc"
     property color normalColor: "white"
     property bool currentItem : false;
     property string fontfamily;
     property string symbolText;                     //符号名称
     property string itemText;                       //按钮名称
     property string type;


     id:navItemBtn;
     width: navwidth
     height: 30*dp;
     background: Rectangle{
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
             verticalCenter: parent.verticalCenter;
         }
         font.family: "FontAwesome"
         width: parent.height - 2*dp
         height: parent.height - 2*dp
         text: symbolText;
         font.pixelSize: 12*dp;
         verticalAlignment:Label.AlignVCenter;
         horizontalAlignment: Label.AlignHCenter;
     }
     Label{
         anchors{
             left: symbolText_.right
             leftMargin: 5*dp
             right: parent.right
             verticalCenter: parent.verticalCenter;
         }
         height: parent.height - 5*dp
         text: itemText;
         font.family: "Microsoft YaHei";
         font.pixelSize: 10*dp;
         verticalAlignment:Label.AlignVCenter;
     }
     MouseArea{
         anchors.fill: parent
         onClicked :  {
             switch(count){
             case 10:{pageLoader.source="MyLikeList.qml";pageLoader.visible=true;searchPage.visible=false;break}
             case 4:{pageLoader.source="LocaMusicPage.qml";pageLoader.visible=true;searchPage.visible=false; break;}
             case 8:{pageLoader.source="LyrEditing.qml";pageLoader.visible=true;searchPage.visible=false;break;}


             }
            searchPage.visible=false
         }
     }
}
