import QtQuick
import QtQuick.Controls
import QtMultimedia
import DataInitialization 1.0
Item {
    property alias mdplayer:player
    property alias audioout: audioOutput
    property alias bb: mdroot
    id:mdroot
    MediaPlayer {
        id: player
        audioOutput: audioOutput
        onPositionChanged:{
            if(mdp.mdplayer.position!==0&&mdp.mdplayer.position===mdp.mdplayer.duration&&mdp.mdplayer.mediaStatus===6){
                fileDialog.nextplay();
            }
            footer.songlist.fileLyr.setDuration(player.position);
        }
        onSourceChanged: {
            if(player.source.toString().search("http")!=-1)
                footer.songlist.fileLyr.url="/tmp/lyrics.lrc"

            else footer.songlist.fileLyr.url = player.source
        }


    }
    AudioOutput {
        id: audioOutput
        muted:false
    }
    DataInitialization {
        id: loadFromFile
    }

    Component.onCompleted: {

        player.source = loadFromFile.loadPath
        footer.palyslider.musicName = loadFromFile.musicName
//        player.play();
    }
    Component.onDestruction: {
        loadFromFile.setLoadPath(player.source.toString())
        loadFromFile.setMusicName(footer.palyslider.musicName)
    }
    function desktopbtncontrol(){
        mdp.mdplayer.play();
        desktopLrc.pausebtn.visible=false
        desktopLrc.playbtn.visible=true
    }
    function desktoppausebtn(){
        mdp.mdplayer.pause();
        desktopLrc.pausebtn.visible=true
        desktopLrc.playbtn.visible=false
    }
}
