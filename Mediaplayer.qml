import QtQuick
import QtQuick.Controls
import QtMultimedia

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
        }
    }
    AudioOutput {
        id: audioOutput
        muted:false
    }
    Component.onCompleted: {
        player.play();
    }

}
