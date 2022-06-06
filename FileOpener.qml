import QtQuick 2.0
import QtQuick.Dialogs
import QtMultimedia

Item {
    id: root

    required property MediaPlayer mediaPlayer

    height: fileButton.height

    property string text: 'text'

    signal clicked();

    signal closePlayer

    FileDialog {
        id: fileDialog
        title: "Please choose a file"
        onAccepted: {
            mediaPlayer.stop()
            mediaPlayer.source = fileDialog.currentFile
            mediaPlayer.play()
        }
    }

    Rectangle {
        id: fileButton
        anchors.left: parent.left
    // public



    // private
        width: 100; height: 50 // default size
        border.color: text? 'black': 'transparent' // Keyboard
        border.width: 0.05 * fileButton.height
        opacity:      enabled  &&  !mouseArea.pressed? 1: 0.3 // disabled/pressed state

        Text {
            text: root.text
            font.pixelSize: 0.4 * fileButton.height
            anchors.centerIn: parent
        }

        MouseArea {
            id: mouseArea

            anchors.fill: parent

            onClicked:  fileDialog.open()
        }
    }
}
