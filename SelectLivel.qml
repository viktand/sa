import QtQuick 2.0

Image {
    id: title
    source: "qrc:/images/selectLabel"
    width: 100
    height: 100
    x: 0
    y: 0
    visible: false

    MouseArea{
        id: liv1
        x: 0
        y: title.height/3
        width: title.width/3
        height: y*2
        onClicked: startLiv(1)
    }

    MouseArea{
        id: liv2
        x: title.width/3
        y: title.height/3
        width: title.width/3
        height: y*2
        onClicked: startLiv(2)
    }

    MouseArea{
        id: sLiv
        x: 0
        y: 0
        width: title.width/3
        height: width/5
        onClicked: {
            bls.superLife=true
            info.text="super life mode"
        }
    }


}

