import QtQuick 2.15
import QtQuick.Controls 2.15

Popup {
    id: popup
    width: parent.width/2
    height: parent.height/2
    modal: true
    visible: false
    closePolicy: Popup.CloseOnPressOutside
    anchors.centerIn: parent

    property string imageUrl: ""
    property string message: ""
    property string popcolor: ""
    Rectangle {
        id: poprectangle
        width: parent.width
        height: parent.height
        color: popcolor
        opacity: 0.9
        Column {
            anchors.centerIn: parent
            spacing: 10

            Image {
                id: popupImage
                source: popup.imageUrl
                width: poprectangle.width/3
                height: poprectangle.height/3
                fillMode: Image.PreserveAspectFit
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                id: popupMessage
                text: popup.message
                anchors.horizontalCenter: parent.horizontalCenter
                wrapMode: Text.Wrap
                font.pixelSize: Math.min(popupImage.width,popupImage.height )/5
                font.bold: true
                height: implicitHeight
            }
        }
    }
}
