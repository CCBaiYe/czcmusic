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
            footer.songlist.fileLyr.url = player.source
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
    }
    Component.onDestruction: {
        loadFromFile.setLoadPath(player.source.toString())
        loadFromFile.setMusicName(footer.palyslider.musicName)
    }
}
