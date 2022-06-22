import QtQuick 2.15
import QtQuick.Controls 2.15

 Button{
     property color hoveredColor: "#dddde1"
     property color clickedColor: "#dddde1"
     property color normalColor: "white"
     property bool currentItem : false;
     property string filename;
     property string count;


     id:navItemBtn;
     width: pageLoader.width;
     height: 30*dp;
     background:Rectangle{
         id:backgroundRect
         color: currentItem ? clickedColor:(hovered?hoveredColor:normalColor)
     }
     Label{
         id:symbolText_
         width: parent.height - 2*dp
         height: parent.height - 2*dp
         text: count
         Text{
             id:tec
             text: filename
             anchors.left: parent.left
             anchors.verticalCenter: parent.verticalCenter
         }
         font.pixelSize: 12*dp;
     }
     MouseArea{
         anchors.fill: parent
         onDoubleClicked: {
             dialogs.addplayerlist();
             mdp.mdplayer.stop();
             footer.palyslider.musicName=dialogs.fileDialog.removeSuffix(dialogs.folderlistm.get(index,"fileName"));
             mdp.mdplayer.source="file://"+dialogs.folderlistm.get(index,"filePath");
             mdp.mdplayer.play();
         }
     }
}
