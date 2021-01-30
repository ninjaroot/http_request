import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.0
Item {

    id:root
    visible: true
    property var data_ : 0
    property var user_num : 0
    property string data_id: "0001"
   //Component.onCompleted: http_getData()
    function http_getData() {
        var http = new XMLHttpRequest()
        var url = "http://192.168.1.109:4000/get_data";
        var params = "id="+data_id+"";
        http.open("POST", url, true);
        http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        http.setRequestHeader("Content-length", params.length);
        http.setRequestHeader("Connection", "close");
        http.onreadystatechange = function() { // Call a function when the state changes.
            if (http.readyState == 4) {
                if (http.status == 200) {
                    data_ = JSON.parse(http.responseText);
                } else {
                    console.log("error: " + http.status)
                }
            }
        }

        http.send(params);
    }

    Rectangle{
        id:col
        width: root.width
        height: root.height
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#eaecee" }
            GradientStop { position: 0.5; color: "#17202A" }
            GradientStop { position: 1.0; color: "#eaecee" }
        }

        Column{
            id:column
            spacing:15
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width *0.5
            height: parent.height
            Rectangle{
                id:image_
                width:  col.height / 4
                height: col.height / 4
                radius: width /2
                anchors.horizontalCenter: parent.horizontalCenter
                clip: true
                Image {
                    id: _image
                    source:"http://192.168.1.109:4000"+data_[user_num].photo
                    smooth: true
                    visible: false
                    anchors.fill: parent
                    sourceSize: Qt.size(image_.width, image_.height)
                    antialiasing: true
                }

                Rectangle {
                   id: _mask
                   color: "black"
                   anchors.fill: parent
                   radius: width/2
                   visible: false
                   antialiasing: true
                   smooth: true
               }
                OpacityMask {
                   id:mask_image
                   anchors.fill: _image
                   source: _image
                   maskSource: _mask
                   visible: true
                   antialiasing: true
               }
            }

            Text {
                id: id_
                anchors.horizontalCenter: parent.horizontalCenter
                color: "#FFFFFF"
                font.pixelSize: 26
                font.bold:true
                text: "ID : " + data_[user_num].id
            }

            Text {
                id: username
                anchors.horizontalCenter: parent.horizontalCenter
                color: "#FFFFFF"
                font.pixelSize: 26
                font.bold:true
                text: "Name : " + data_[user_num].name
            }
        }
    }

    Rectangle{
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        width: parent.width*0.7
        height: back.height
        color: "#00000000"
        B_button{
            id:back
            anchors.left: parent.left
            b_txt:"back"
            bb_font:22
            onButtonClicked: {
               if(user_num >0 )
                   user_num --;
               else
                   user_num = data_.length -1
            }
        }

        B_button{
            id:next
            width: back.width
            height:back.height
            anchors.right: parent.right
            b_txt:"next"
            bb_font:22
            onButtonClicked: {
                if(user_num < data_.length-1)
                    user_num++;
                else
                    user_num = 0;
            }
        }
    }
}
