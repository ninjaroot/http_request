import QtQuick 2.0
import QtGraphicalEffects 1.12

Item {
    id:root
    property string b_txt: "txt"
    property int bb_font: 0
    signal buttonClicked()
    width: name.implicitWidth *1.8
    height: name.implicitHeight *1.5

    Rectangle{
        id:rect
        width: parent.width
        height: parent.height
        color: "#343a42"
        clip: true
        anchors.centerIn: parent
        radius:3

        Text {
            id: name
            text: b_txt
            font.pointSize: bb_font
            anchors.centerIn: parent
            color: "#eaecee"
        }
    }

    DropShadow {
        anchors.fill: rect
        horizontalOffset: 3
        verticalOffset: 3
        radius: 8.0
        samples: 17
        color: "#80000000"
        source: rect
        id: shadow
    }

    MouseArea{
        anchors.fill: rect
        onPressed: {
            shadow.color = "#00000000"
            root.x+=1
            root.y+=1
            name.font.bold =true
        }

        onReleased:{
            shadow.color = "#80000000"
            root.x-=1
            root.y-=1
            name.font.bold = false
        }

        onClicked: {
            buttonClicked()
        }
    }
}
