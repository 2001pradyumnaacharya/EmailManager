import QtQuick 2.15
import QtQuick.Controls.Basic 2.15

Item {
    property int widthOfscroll: 0
    property int heightOfscroll: 0
    property string placeHolder: ""
    property string colors: ""
    property string contient: textArea.text
    width: widthOfscroll
    height: heightOfscroll

    ScrollView {
        id: view
        width: widthOfscroll
        height: heightOfscroll
        TextArea {
            id: textArea
            placeholderText: placeHolder
            wrapMode: TextEdit.Wrap
            color: colors
            background: Rectangle {
                implicitWidth: view.width
                implicitHeight: view.height
                radius: Math.min(parent.width,parent.height)*0.02
            }
        }
    }
}
