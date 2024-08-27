import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import "CustomCumponent"

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Email Manager")
    color: "#ffd700"
    StackView{
        id: stack
        anchors.fill: parent
        initialItem: mainWindow
    }
    Item {
        id: mainWindow
        Rectangle{
            id: csvrectangle
            width: parent.width*0.22
            height: parent.height*0.22
            radius: Math.max(parent.height,parent.width)*0.01
            anchors.right: parent.right
            anchors.margins:Math.max(parent.height,parent.width)*0.01
            color:"transparent"
            Image {
                id: imagecsvButton
                source: "Logo//CSV.png"
                fillMode: Image.PreserveAspectFit
                anchors.fill: parent
                MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onEntered: {
                    popuptext.visible=true
                }
                onExited: {
                    submit.color="red"
                    popuptext.visible=false
                }
                onClicked:{
                    stack.push("CustomCumponent//retriveDataBase.qml")
                }
                }
            }
            Text {
                id: popuptext
                text: "Click!! get data in Excel"
                visible: false
                fontSizeMode:Math.max(Math.max(parent.height,parent.width)*0.01,1)
                anchors.top: parent.bottom
            }
        }
        Image {
            id: logo
            width: parent.width*0.2
            height: parent.height*0.2
            source: "Logo//emailManager.png"
            fillMode: Image.PreserveAspectFit
        }
        Column {
            spacing: Math.min(parent.height,parent.width)*0.019
            anchors.centerIn: parent
            width: parent.width*0.9
            height: parent.height*0.9

            TextHolders {
                id: fromMale
                heightOfscroll: parent.height*0.1
                widthOfscroll: parent.width*0.5
                placeHolder: "From Mail"
                colors: "black"
                anchors.horizontalCenter: parent.horizontalCenter
            }
            TextHolders {
                id: toMale
                heightOfscroll: parent.height*0.1
                widthOfscroll: parent.width*0.5
                placeHolder: "to Mail"
                colors: "black"
                anchors.horizontalCenter: parent.horizontalCenter
            }
            TextHolders {
                id: subject
                heightOfscroll: parent.height*0.1
                widthOfscroll: parent.width*0.5
                placeHolder: "subject"
                colors: "black"
                anchors.horizontalCenter: parent.horizontalCenter
            }
            TextHolders {
                id: body
                heightOfscroll: parent.height*0.4
                widthOfscroll: parent.width*0.5
                placeHolder: "Body of the Mail"
                colors: "black"
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Rectangle {
                id: submit
                width: parent.width*0.3
                height: parent.height*0.1
                radius: Math.min(parent.width,parent.height)*0.015
                color: "red"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: 20
                Text {
                    anchors.centerIn: parent
                    text: "Submit"
                    color: "white"
                    font.bold: true
                    font.pointSize: Math.max(Math.max(parent.width, parent.height) * 0.1, 1)
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
                        middle.creatTable()
                      if(middle.insert(fromMale.contient,toMale.contient,subject.contient,body.contient)){
                            popup.imageUrl="..//popuplogos//datasaved.png"
                            popup.message="data Saved"
                            popup.popcolor="#f5f5f5"
                            popup.visible=true
                      }
                      else if(fromMale.contient==="" || toMale.contient===""|| subject.contient===""||body.contient===""){
                          popup.imageUrl="..//popuplogos//errormessage.png"
                          popup.message="TextFiled are empty"
                          popup.popcolor="red"
                          popup.visible=true

                      }
                      else{
                          popup.imageUrl="..//popuplogos//errormessage.png"
                          popup.message="Data Not Saved"
                          popup.popcolor="red"
                          popup.visible=true
                      }
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
