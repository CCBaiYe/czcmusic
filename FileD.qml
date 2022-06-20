import QtQuick 2.0
import QtQuick.Dialogs
//import Player
FileDialog {
        id: fileDialog
        property alias listM: listm
        title: qsTr("Please choose an image file")
        nameFilters: [
                    "Audio Files (*.mp3 *.ogg *.wav *.wma *.ape *.ra)",
                    "*.*"
                ];
        onAccepted: {
            var filepath = new String(fileDialog.currentFile);
            var dot = filepath.lastIndexOf(".");
            var sep = filepath.lastIndexOf("/");
            if(dot > sep){
                var ext = filepath.substring(dot);
                processFile(fileDialog.currentFile, ext.toLowerCase());
            }else{
                //root.statusBar.text = "Not Supported!";
            }
        }
        function setFile()
        {
            console.log(fileDialog.currentFile)
            return fileDialog.currentFile;
        }

        function setMusicName(path){
            var newPath;
            //去掉目录
            for(var i=path.length-1;i>=0;i--) {
                if(path[i]==="/") {
                    newPath=path.slice(i+1)
                    break;
                }
            }
             //去掉后缀
            return removeSuffix(newPath);
        }

        function removeSuffix(newPath){
            for(var j=0;j<newPath.length;j++) {
                if(newPath[j]===".") {
                      footer.palyslider.musicName=newPath.slice(0,j);
                      return newPath.slice(0,j);
                }
            }
        }
        function isexist(path){
            for(var i=0;i<listm.count;i++){
                    if(path===listm.get(i).filePath)
                        return true;
            }
            return false;
        }

        function processFile(fileUrl,ext)
        {
           mdp.mdplayer.source=fileUrl;
           var str=fileDialog.currentFile.toString();
           if(!(isexist(fileUrl))){
               listm.append({"Count":listm.count+1,"fileName":setMusicName(str),"filePath":fileUrl});
           }
           mdp.mdplayer.play();
        }
        //xiayihsou
        function nextplay()
        {
            if(footer.playmodel===0||footer.playmodel===2){
                for(var i=0;i<listm.count;i++)
                {
                    if(mdp.mdplayer.source===listm.get(i).filePath){
                        mdp.mdplayer.source=listm.get((i+1)%listm.count).filePath;
                        footer.palyslider.musicName=listm.get((i+1)%listm.count).fileName;
                        mdp.mdplayer.play();
                        break;
                    }
                }
            }
            else if(footer.playmodel===1){
                var x=Math.random()*(listm.count-1);
                var j=Math.round(x);
                mdp.mdplayer.source=listm.get(j).filePath;
                footer.palyslider.musicName=listm.get(j).fileName;
                mdp.mdplayer.play();
            }
        }
        //shangyishou
        function preplay(){
            if(footer.playmodel==0||footer.playmodel===2){
                for(var i=0;i<listm.count;i++)
                {
                    if(mdp.mdplayer.source===listm.get(i).filePath&&i!=0){
                        mdp.mdplayer.source=listm.get(i-1).filePath;
                        footer.palyslider.musicName=listm.get(i-1).fileName;
                        mdp.mdplayer.play();
                        break;
                    }
                    else if(mdp.mdplayer.source===listm.get(i).filePath&&i==0){
                        mdp.mdplayer.source=listm.get(listm.count-1).filePath;
                        footer.palyslider.musicName=listm.get(listm.count-1).fileName;
                        mdp.mdplayer.play();
                        break;
                    }
                }
            }
            else if(footer.playmodel==1){
                var x=Math.random()*(listm.count-1);
                var j=Math.round(x);
                mdp.mdplayer.source=listm.get(j).filePath;
                footer.palyslider.musicName=listm.get(j).fileName;
                mdp.mdplayer.play();
            }
        }
        //时间转化   [00:00]
        function setTime(playTime) {
            var m,s;
            var time;
            playTime=(playTime-playTime%1000)/1000;
            m=(playTime-playTime%60)/60
            s=playTime-m*60
            if(m>=0&m<10) {
                if(s>=0&s<10) {
                    time="0"+m+":0"+s;
                } else {
                    time="0"+m+":"+s;
                }
            } else {
                if(s>=0&s<10) {
                    time=m+":0"+s;
                } else {
                    time=m+":"+s;
                }
            }
            return time;
        }
        //liebiaoxunhuan
        function loopplaymodel(){
                if(mdp.mdplayer.mediaStatus===6){
                    nextplay();

                }
        }
//        //playmodel
//        function setplaymodel(){
//            if(footer.playmodel===0){

//            }
//        }

        ListModel{
            id:listm
        }
    }
