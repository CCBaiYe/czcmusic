import QtQuick 2.0
import QtCore
import QtQuick.Dialogs
import Qt.labs.folderlistmodel
import GetInformation 1.0
Item{
    property alias listM: listm
    property alias folderDialog: folderDialog
    property alias fileDialog:fileDialog
    property alias folderlistm: folderlistm
    property alias savefoldermodel: savefoldermodel
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
                getinfor.setFileUrl(fileUrl);
                getinfor.onEndsWith();
                listm.append({"Count":listm.count+1,"fileName":setMusicName(str),
                                 "filePath":fileUrl,"fileArtist":getinfor.artist,
                                 "fileTime":dialogs.fileDialog.setTime(mdp.mdplayer.duration)});
            }
            footer.palyslider.musicName=setMusicName(str);
            mdp.mdplayer.play();
        }
        //下一首
        function nextplay()
        {
            if(footer.playmodel===0||footer.playmodel===2){
                for(var i=0;i<listm.count;i++)
                {
                    var path=listm.get(i).filePath;
                    if(mdp.mdplayer.source===path){
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
        console.log(arguments[0]);
        //把目录下文件保存到一个model中
        for(var i=0;i<folderlistm.count;i++)
        {
            var filepath="file://"+folderlistm.get(i,"filePath");
            getinfor.setFileUrl(Qt.resolvedUrl(filepath));
            getinfor.onEndsWith();
            if(!(fileDialog.isexist(getinfor.fileUrl))){
                var str=fileDialog.removeSuffix(folderlistm.get(i,"fileName"));
                var data={"Count":savefoldermodel.count+1,"fileName":str,
                "filePath":getinfor.fileUrl,"fileArtist":getinfor.artist,
                "fileTime":dialogs.fileDialog.setTime(mdp.mdplayer.duration),
                "fileAlbum":getinfor.album}
                if(!(folderlistm.isFolder(i))){
                    savefoldermodel.append(data);
                }
            }
        }

    }
    //选择多文件
    function setFilesModel(){
        for(var i = 0; i < arguments[0].length; i++){
            if(!(fileDialog.isexist(arguments[0][i]))){
                getinfor.setFileUrl(arguments[0][i]);
                getinfor.onEndsWith();
                var str=fileDialog.currentFiles[i].toString();
                var data = {"filePath": arguments[0][i],"fileName":fileDialog.setMusicName(str),
                    "Count":listm.count+1,"fileArtist":getinfor.artist,
                    "fileTime":dialogs.fileDialog.setTime(mdp.mdplayer.duration)};
                listm.append(data);
            }
        }
    }
    //目录中所有文件加入到播放列表
    function addplayerlist(){
        for(var i=0;i<folderlistm.count;i++){
            var filename=fileDialog.removeSuffix(folderlistm.get(i,"fileName"));
            var filepath="file://"+folderlistm.get(i,"filePath");            
            if(!(fileDialog.isexist(Qt.resolvedUrl(filepath)))){
                getinfor.setFileUrl(Qt.resolvedUrl(filepath));
                getinfor.onEndsWith();
            listm.append({"Count":listm.count+1,"fileName":filename,
                             "filePath":Qt.resolvedUrl(filepath),"fileArtist":getinfor.artist,
                             "fileTime":dialogs.fileDialog.setTime(mdp.mdplayer.duration),"fileAlbum":getinfor.album});
            }
        }
    }

    FolderListModel{
        id:folderlistm
        nameFilters: ["*.mp3","*.ogg"]
        showDirs: false
    }

    FolderDialog{
        id:folderDialog
        title: "Select an player folder"
        onAccepted: {
            setFolderModel(folderDialog.selectedFolder);

        }
    }
    //保存目录下的文件
    ListModel{
        id:savefoldermodel
    }
}
