import QtQuick
import QtQuick.Controls
import AudioPlay 1.0
import DataInitialization 1.0
Item {
    property alias mdplayer:player
    property alias playerVolume: player.volume
    property alias bb: mdroot
    id:mdroot
    AudioPlayer {
        id: player
        onPositionChanged:{
            if(mdp.mdplayer.position!==0&&mdp.mdplayer.position===mdp.mdplayer.duration){
                dialogs.fileDialog.nextplay();
            }
            footer.songlist.fileLyr.setDuration(player.position);
        }
        onSourceChanged: {
            if(player.source.toString().search("http")!==-1)
                footer.songlist.fileLyr.url="/tmp/lyrics.lrc"

            else footer.songlist.fileLyr.url = player.source
        }
    }



    Component.onCompleted: {
        player.source = loadFromFile.loadPath
        footer.palyslider.musicName = loadFromFile.musicName
        var data1=loadFromFile.allKey();
        for(var i=0;i<data1.length;i++){
            var data2=loadFromFile.readData(data1[i]);
            var data3={"songName":data2[0],"songPath":data2[1],
                "songArtist":data2[2],"songAlbum":data2[3],"songTime":data2[4],
                "Count":dialogs.recentplay.count+1}
            dialogs.recentplay.append(data3);
        }
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
