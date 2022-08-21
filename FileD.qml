import QtQuick
import QtCore
import QtQuick.Dialogs
import Qt.labs.folderlistmodel
import GetInformation 1.0
import Qt.labs.settings

Item{
    property alias listM: listm
    property alias folderDialog: folderDialog
    property alias fileDialog:fileDialog
    property alias folderlistm: folderlistm
    property alias savefoldermodel: savefoldermodel
    property alias loadmodel: loadmodel
    property alias recentplay: recentplay
    //property alias setting: setting
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
            footer.songlist.smallimage=getinfor.picture
            footer.songlist.bigimage=getinfor.picture

            footer.songlist.name=setMusicName(filepath)
            footer.songlist.album=getinfor.album
            footer.songlist.artist=getinfor.artist

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
        //判断地址
        function ispath(str){
            var m=str[0];

            if(m==="f")
                return 1;
            return 0;
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
                                 "filePath":fileUrl,"fileAlbum":getinfor.album,
                                 "fileTime":dialogs.fileDialog.setTime(mdp.mdplayer.duration),
                                 "fileArtist":getinfor.artist,
                             });
            }
            footer.palyslider.musicName=setMusicName(str);
            mdp.desktopbtncontrol()
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
                        mdp.desktopbtncontrol()
                        break;
                    }
                }
            }

            else if(footer.playmodel===1){
                var x=Math.random()*(listm.count-1);
                var j=Math.round(x);
                mdp.mdplayer.source=listm.get(j).filePath;
                footer.palyslider.musicName=listm.get(j).fileName;
                mdp.desktopbtncontrol()
            }
        }
        //上一首
        function preplay(){
            if(footer.playmodel===0||footer.playmodel===2){
                for(var i=0;i<listm.count;i++)
                {
                    if(mdp.mdplayer.source===listm.get(i).filePath&&i!=0){
                        mdp.mdplayer.source=listm.get(i-1).filePath;
                        footer.palyslider.musicName=listm.get(i-1).fileName;
                        mdp.desktopbtncontrol()
                        break;
                    }
                    else if(mdp.mdplayer.source===listm.get(i).filePath&&i==0){
                        mdp.mdplayer.source=listm.get(listm.count-1).filePath;
                        footer.palyslider.musicName=listm.get(listm.count-1).fileName;
                        mdp.desktopbtncontrol()
                        break;
                    }
                }
            }
            else if(footer.playmodel===1){
                var x=Math.random()*(listm.count-1);
                var j=Math.round(x);
                mdp.mdplayer.source=listm.get(j).filePath;
                footer.palyslider.musicName=listm.get(j).fileName;
                mdp.desktopbtncontrol()
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
            if(mdp.mdplayer.position!==0&&mdp.mdplayer.position===mdp.mdplayer.duration){
                nextplay();
            }
        }
        //播放列表
        ListModel{
            id:listm
        }
    }

    //选择目录
    function setFolderModel(){
        //把目录下文件保存到一个model中
        for(var i=0;i<folderlistm.count;i++)
        {
            if(!(folderlistm.isFolder(i))){
            var filepath="file://"+folderlistm.get(i,"filePath");
            getinfor.setFileUrl(Qt.resolvedUrl(filepath));
            getinfor.onEndsWith();
            if(!(fileDialog.isexist(getinfor.fileUrl))){
                var str=fileDialog.removeSuffix(folderlistm.get(i,"fileName"));
                var data={"Count":savefoldermodel.count+1,"fileName":str,
                "filePath":getinfor.fileUrl,
                "fileArtist":getinfor.artist,
                "fileTime":dialogs.fileDialog.setTime(mdp.mdplayer.duration),
                "fileAlbum":getinfor.album}
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
                    "Count":listm.count+1,"fileAlbum":getinfor.album,
                    "fileTime":dialogs.fileDialog.setTime(mdp.mdplayer.duration),
                "fileArtist":getinfor.artist
                };
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
    //下载列表中所有文件加入到播放列表
    function addloadlist(){
        for(var i=0;i<loadmodel.count;i++){
            var filename=loadmodel.get(i).songName;
            var filepath="file://"+loadmodel.get(i).songPath;
            if(!(fileDialog.isexist(Qt.resolvedUrl(filepath)))){
                getinfor.setFileUrl(Qt.resolvedUrl(filepath));
                getinfor.onEndsWith();
                dialogs.listM.append({"Count":listm.count+1,"fileName":filename,
                                 "filePath":Qt.resolvedUrl(filepath),"fileArtist":loadmodel.get(i).songArtist,
                                 "fileTime":loadmodel.get(i).songTime,"fileAlbum":loadmodel.get(i).songAlbum});
            }
        }
    }
    //最近列表中所有文件加入到播放列表
    function addrecentlist(){
        for(var i=0;i<recentplay.count;i++){
            var filename=recentplay.get(i).songName;
            var filepath;
            if(fileDialog.ispath(recentplay.get(i).songPath)===1){
                 filepath="file://"+recentplay.get(i).songPath;
            }else{
                 filepath=recentplay.get(i).songPath;
            }
            if(!(fileDialog.isexist(Qt.resolvedUrl(filepath)))){
                getinfor.setFileUrl(Qt.resolvedUrl(filepath));
                getinfor.onEndsWith();
                dialogs.listM.append({"Count":listm.count+1,"fileName":filename,
                                 "filePath":Qt.resolvedUrl(filepath),"fileArtist":recentplay.get(i).songArtist,
                                 "fileTime":recentplay.get(i).songTime,"fileAlbum":recentplay.get(i).songAlbum});
            }
        }
    }

    //创建歌单

    FolderListModel{
        id:folderlistm
        nameFilters: ["*.mp3","*.ogg"]
        showDirs: false
        onFolderChanged: {
            //console.log(folder);
            setFolderModel(folder);
        }
    }
    FolderDialog{
        id:folderDialog
        title: "Select an player folder"
        onAccepted: {
            folderlistm.folder = folderDialog.selectedFolder;
        }
    }
    //保存目录下的文件
    ListModel{
        id:savefoldermodel
    }
    //下载列表
    ListModel{
        id:loadmodel
    }
    //最近播放列表
    ListModel{
        id:recentplay;
    }
}
