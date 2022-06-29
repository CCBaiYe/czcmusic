import QtQuick 2.15
import QtQuick.Controls 2.15

 Button{
     property color hoveredColor: "#dddde1"
     property color clickedColor: "#dddde1"
     property color normalColor: "white"
     property bool currentItem : false;
     property string filename;
     property string count;
     property string fileartist
     property string filetime
     property string filealbum


     id:navItemBtn;
     width: pageLoader.width;
     height: 30*dp;
     background:Rectangle{
         id:backgroundRect
         color: currentItem ? clickedColor:(hovered?hoveredColor:normalColor)
     }
     Label{
         id:symbolText_
         anchors{
             left: parent.left
             leftMargin: 1*dp
         }
         width: parent.height - 2*dp
         height: parent.height - 2*dp
         anchors.verticalCenter: navItemBtn.verticalCenter
         text: count
         Label{
             id:tec1
             text: filename
             anchors.left: symbolText_.right
             width: 200
             elide: Text.ElideRight
             font.pixelSize: 13;
         }
         Label{
             id:tec2
             text: fileartist
             width: 300
             elide: Text.ElideRight
             anchors.left: symbolText_.right
             anchors.leftMargin: 200
             font.pixelSize: 13;
         }
         Label{
             id:tec3
             text: filealbum
             elide: Text.ElideRight
             anchors.left: symbolText_.right
             anchors.leftMargin: 500
             font.pixelSize: 13;
         }
         Label{
             id:tec4
             text: filetime
             anchors.left: symbolText_.right
             anchors.leftMargin: 700
             font.pixelSize: 13;
         }

     }
     MouseArea{
         anchors.fill: parent
         onDoubleClicked: {
             dialogs.addplayerlist();
             mdp.mdplayer.stop();
             footer.palyslider.musicName=dialogs.fileDialog.removeSuffix(dialogs.folderlistm.get(index,"fileName"));
             mdp.mdplayer.source="file://"+dialogs.folderlistm.get(index,"filePath");
             mdp.desktopbtncontrol();
         }
     }
}
