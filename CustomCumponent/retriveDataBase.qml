import QtQuick 2.15
Item {
    Rectangle{
        id: rectangle
        width: parent.width
        height: parent.height
        color: "#ffd700"
        Image {
            id: logo
            width: parent.width*0.2
            height: parent.height*0.2
            source: "..//Logo//emailManager.png"
            fillMode: Image.PreserveAspectFit
        }
        Column{
            spacing: Math.max(Math.min(parent.width,parent.height)*0.02,1)
            anchors.centerIn: parent
            TextHolders {
                id: date
                heightOfscroll: rectangle.height*0.09
                widthOfscroll: rectangle.width*0.4
                placeHolder: "dd-mm-yyyy"
                colors: "black"
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Rectangle{
                id: submit
                width: rectangle.height*0.4
                height: rectangle.width*0.09
                radius: Math.max(parent.width,parent.height)*0.015
                color: "red"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: 20
                Text {
                    anchors.centerIn: parent
                    text: "Submit"
                    color: "white"
                    font.bold: true
                    font.pointSize: Math.max(Math.max(parent.width, parent.height) * 0.09, 1)
                }
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onEntered: {
                        submit.color="#dc143c"
                    }
                    onExited: {
                        submit.color="red"
                    }
                    onClicked: {
                        var result=middle.databasetocsv(date.contient,date.contient)
                        if(result){
                            popup.imageUrl="..//popuplogos//csvSaved.png"
                            popup.message="Excel Created"
                            popup.popcolor="#f5f5f5"
                            popup.visible=true
                        }else if(date.contient===""){
                            popup.imageUrl="..//popuplogos//errormessage.png"
                            popup.message="DateFiled is empty"
                            popup.popcolor="red"
                            popup.visible=true
                        }
                        else{
                            popup.imageUrl="..//popuplogos//errormessage.png"
                            popup.message="Error"
                            popup.popcolor="red"
                            popup.visible=true
                        }
                    }
                }
            }
            Rectangle{
                id: back
                width: rectangle.height*0.4
                height: rectangle.width*0.09
                radius: Math.max(parent.width,parent.height)*0.015
                color: "red"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: 20
                Text {
                    anchors.centerIn: parent
                    text: "Back"
                    color: "white"
                    font.bold: true
                    font.pointSize: Math.max(Math.max(parent.width, parent.height) * 0.09, 1)
                }
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onEntered: {
                        back.color="#dc143c"
                    }
                    onExited: {
                        back.color="red"
                    }
                    onClicked: {
                        stack.pop()
                        // middle.deletee()
                    }
                }
            }
        }
    }

    Popupmasseage{
        id: popup
        visible: false
    }
}
