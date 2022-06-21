import QtQuick 2.0
import QtCore
import QtQuick.Dialogs
import Qt.labs.folderlistmodel
Item{
    property alias listM: listm
    property alias folderDialog: folderDialog
    property alias fileDialog:fileDialog
    property alias folderlistm: folderlistm
    FileDialog {
        id: fileDialog
        title: qsTr("Please choose an image file")
        nameFilters: [
            "Audio Files (*.mp3 *.ogg *.wav *.wma *.ape *.ra)",
            "*.*"
        ];
        fileMode: FileDialog.OpenFiles
        onAccepted: {
            var filepath = new String(fileDialog.currentFile);
            var dot = filepath.lastIndexOf(".");
            var sep = filepath.lastIndexOf("/");
            if(dot > sep){
                var ext = filepath.substring(dot);
                processFile(fileDialog.currentFile, ext.toLowerCase());
                setFilesModel(fileDialog.selectedFiles);
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
        //查找指定路径
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
        //下一首
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
        //上一首
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
        //列表循环
        function loopplaymodel(){
            if(mdp.mdplayer.mediaStatus===6){
                nextplay();
            }
        }
        ListModel{
            id:listm
        }
    }
    //选择目录
    function setFolderModel(){
        folderlistm.folder = arguments[0];
        //listm = folderlistm;

    }
    //选择多文件
    function setFilesModel(){
        listm.clear();
        for(var i = 0; i < arguments[0].length; i++){
            var str=fileDialog.currentFiles[i].toString();
            var data = {"filePath": arguments[0][i],"fileName":fileDialog.setMusicName(str),"Count":listm.count+1};
            listm.append(data);
        }
    }
    FolderListModel{
        id:folderlistm
        nameFilters: ["*.mp3"]
    }

    FolderDialog{
        id:folderDialog
        //currentFolder: StandardPaths.writableLocation(StandardPaths.DocumentsLocation)
        title: "Select an player folder"
        onAccepted: {
            setFolderModel(folderDialog.selectedFolder);
        }
    }
}
