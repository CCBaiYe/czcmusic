import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts


Rectangle{
    width: height
    property alias text: musicControlBtnText.text
    property alias fontfamily: musicControlBtnText.font.family;
    property alias color : musicControlBtnText.color
    Label{
        id:musicControlBtnText
        anchors.fill: parent
        font.family: "FontAwesome"
        font.pixelSize: 15*dp;
        text: "\uf192";
        verticalAlignment:Label.AlignVCenter;
        horizontalAlignment: Label.AlignHCenter;
        color: "#999999"
    }
}
