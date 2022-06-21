import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia
Rectangle{
    id:button
    width: 30*dp
    height:width
    //signal clicked()
    property alias text:btn_label.text;
    property string secondText: "";
    property color btnColor: "#DC2F2E";

    color: btnColor
    radius:width/2
    border.width: 2
    border.color: "#ffffff"
    Text {
        id: btn_label
        font.pointSize: 10
        width: parent.width
        wrapMode: Text.WordWrap
        horizontalAlignment: Text.AlignHCenter
        anchors.centerIn: button
        color: "#ffffff"
    }
}

