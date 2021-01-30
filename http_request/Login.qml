import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id:root
    function http_login(email,pass) {
        var http = new XMLHttpRequest()
        var url = "http://192.168.1.109:4000/login";
        var params = "email="+email+"&pass="+pass+"";
        http.open("POST", url, true);
        http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        http.setRequestHeader("Content-length", params.length);
        http.setRequestHeader("Connection", "close");
        http.onreadystatechange = function() { // Call a function when the state changes.
            if (http.readyState == 4) {
                if (http.status == 200) {
                    if(http.responseText === "loged"){
                        stack.push(data_page)
                        data_page.http_getData()
                    }else{
                        note_txt.text = "Wrong Email or Password"
                        note.visible = true
                    }
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
            spacing:15
            anchors.centerIn: col
            TextField {
                id:email
                width: root.width /1.2
                height: root.height /18
                placeholderText: "email"
                background: Rectangle {
                    border.color: "gray"
                    border.width: 3
                    radius: 6
                    color:email.activeFocus ? "#ececec":"gray"
                    clip: true
                }
            }

            TextField {
                id:pass
                width: email.width
                height: email.height
                placeholderText: "password"
                echoMode: TextInput.Password
                background:Rectangle {
                    border.color: "gray"
                    border.width: 3
                    radius: 6
                    color:  pass.activeFocus ? "#ececec":"gray"
                    clip: true
                }
            }

            B_button{
                id:login
                b_txt:"Login"
                bb_font:17
                anchors.horizontalCenter: pass.horizontalCenter
                onButtonClicked: {
                    http_login(email.text,pass.text)
                }
            }

            B_button{
                id:sign
                b_txt:"Sign up"
                bb_font: 17
                anchors.horizontalCenter: login.horizontalCenter
                onButtonClicked: {
                    stack.push(register_page)
                }
            }
        }
    }

    Rectangle{
        id:note
        color: "gray"
        visible: false
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: col.bottom
        anchors.margins: 90
        Text {
            id: note_txt
            anchors.centerIn: parent
            font.bold: true
            color: "#000033"
        }
        Timer {
            id: timer
            interval: 3000;
            running: false;
            repeat: false
            onTriggered: note.visible = false
        }

        onVisibleChanged: {
            if(visible)
                timer.running = true;
        }
    }
}


