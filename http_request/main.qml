import QtQuick 2.15
import QtQuick.Controls 2.15


ApplicationWindow {
    title: qsTr("Ninja")
    width: screen.width
    height: screen.height
    visible: true

    Login{
        id:login_page
    }

    Register{
        id:register_page
    }

    Data{
        id:data_page
    }

    StackView {
        id: stack
        initialItem: login_page
        anchors.fill: parent
    }

}



