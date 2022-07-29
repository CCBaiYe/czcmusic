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
             anchors.leftMargin: 450
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
             dialogs.addloadlist();
             mdp.mdplayer.stop();
             //console.log(dialogs.loadmodel.get(index).songName)
             footer.palyslider.musicName=dialogs.loadmodel.get(index).songName;
             //console.log(dialogs.loadmodel.get(index).songPath)
             mdp.mdplayer.source="file://"+dialogs.loadmodel.get(index).songPath;
             mdp.desktopbtncontrol();
             loadFromFile.writeData(dialogs.loadmodel.get(index).songName,
                                    dialogs.loadmodel.get(index).songPath,
                                    dialogs.loadmodel.get(index).songArtist,
                                    dialogs.loadmodel.get(index).songAlbum,
                                    dialogs.loadmodel.get(index).songTime)
         }
     }
}

