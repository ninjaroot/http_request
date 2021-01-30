import QtQuick 2.0
import QtQuick.Controls 2.15
import Qt.labs.folderlistmodel 2.15
Item {


    FolderListModel {
        id: folderModel
        folder: "file:///home/ninja/"
        nameFilters: ["*.png","*.txt","*.jpeg","*.jpg"]
    }

    FolderListModel {
        id: folder
        folder: "file:///home/ninja/Downloads"
        nameFilters: ["*.png","*.txt","*.jpeg","*.jpg"]
    }


    Popup {
        id: popup
        anchors.centerIn: parent
        width: screen.width
        height: screen.height /1.25
        modal: false
        focus: false
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
        Overlay.modal: Rectangle {
            color: "#80000000"
        }

        background: Rectangle {
            color: "#333333"
            radius:3
        }

        Rectangle{
            id: popup1
            anchors.fill: parent
            width: popup.width /1.5
            height:popup.height /1.25
            color:"#333333"




            B_button{
                width: popup.width /5
                height: 40
                id: button_1
                b_txt: "Save"
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                onButtonClicked: {

                    file_path = file_path+"/"+inbut.text+".jpeg"
                }
            }

            B_button{
                width: popup.width /5
                height: 40
                b_txt:"close"
                anchors.verticalCenter: button_1.verticalCenter
                onButtonClicked:{
                    popup.close()
                }
            }


            TextField {
                id:inbut
                width: popup1.width -5
                height: popup.height /13
                //   anchors.centerIn: parent
                placeholderText: "Image name"
                background: Rectangle {
                    radius: 3
                    //  implicitWidth: 80
                    // implicitHeight: 20
                    border.color: "gray"
                    border.width: 3

                    clip: true
                }
            }

            Rectangle{
                id:popup2
                width: popup1.width /3
                height: popup1.height -inbut.height -55
                border.color: "gray"
                border.width: 3

                radius:5
                anchors.top: inbut.bottom
                anchors.topMargin: 5
                ListView {
                    id:lv

                    anchors.fill: parent
                    clip: true

                    Component {
                        id: fileDelegate
                        Rectangle{
                            id: popup3
                            width: lv.width
                            height: tex.contentHeight+20
                            color: "#00000000"
                            Rectangle{
                                id:rec
                                width: parent.width - 20
                                height: parent.height - 8
                                anchors.centerIn: parent
                                color: selected_item_index == index ? "#555555" : "#FFFFFF"
                                border.color: selected_item_index == index ? "#FFFFFF" : "#555555"
                                border.width:1
                                radius: 8

                                Text {
                                    id:tex
                                    clip: true
                                    anchors.fill: parent
                                    text: fileName
                                    font.pixelSize: 14
                                    color: selected_item_index == index ? "#FFFFFF" : "#555555"
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignHCenter
                                }
                                MouseArea{
                                    anchors.fill: parent
                                    onPressed: {
                                        selected_item_index = index
                                        selected_item_filename = filePath
                                    }

                                    onClicked:{

                                        folder.folder = "file://"+selected_item_filename
                                        file_path = selected_item_filename
                                        console.log(selected_item_filename)

                                    }
                                }
                            }
                        }
                    }

                    model: folderModel
                    delegate:fileDelegate


                }



                Rectangle{
                    width: popup1.width - popup2.width -9.5
                    height: popup2.height
                    border.color: "gray"
                    border.width: 3
                    radius: 5
                    clip: true
                    anchors.left: popup2.right
                    anchors.leftMargin: 4

                    ListView {
                        id:list

                        anchors.fill: parent
                        clip: true

                        Component {
                            id: file2
                            Rectangle{
                                id: popup3
                                width: list.width
                                height: tex.contentHeight+20
                                color: "#00000000"
                                Rectangle{
                                    id:rec
                                    width: parent.width - 20
                                    height: parent.height - 8
                                    anchors.centerIn: parent
                                    color: selected_item_index_ == index ? "#555555" : "#FFFFFF"
                                    border.color: selected_item_index_ == index ? "#FFFFFF" : "#555555"
                                    border.width:1
                                    radius: 8

                                    Text {
                                        id:tex
                                        clip: true
                                        anchors.fill: parent
                                        text: fileName
                                        font.pixelSize: 14
                                        color: selected_item_index_ == index ? "#FFFFFF" : "#555555"
                                        verticalAlignment: Text.AlignVCenter
                                        horizontalAlignment: Text.AlignHCenter
                                    }
                                    MouseArea{
                                        anchors.fill: parent
                                        onPressed: {
                                            selected_item_index_ = index
                                            selected_item_filename_ = filePath
                                        }

                                        onClicked:{

                                            folder.folder = "file://"+selected_item_filename_
                                            file_path = selected_item_filename_
                                            console.log(selected_item_filename_)

                                        }
                                    }
                                }
                            }
                        }

                        model: folder
                        delegate:file2
                    }


                }
            }
        }
    }
}
