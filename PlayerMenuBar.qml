import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs
import QtQuick.Layouts
import QtMultimedia

Item {
    id: root

    required property MediaPlayer mediaPlayer
    required property VideoOutput videoOutput

    height: menuBar.height

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

    MenuBar {
        id: menuBar
        anchors.left: parent.left
        anchors.right: parent.right

        Menu {
            title: qsTr("&File")
            Action {
                text: qsTr("&Open")
                onTriggered: fileDialog.open()
            }

            Action {
                text: qsTr("&Exit");
                onTriggered: closePlayer()
            }
        }

        Menu {
            title: qsTr("&Video")
            Action {
                text: qsTr("&Play")
                onTriggered: mediaPlayer.play()
            }

            Action {
                text: qsTr("&Pause")
                onTriggered: mediaPlayer.pause()
            }

            Action {
                text: qsTr("&Stop")
                onTriggered: mediaPlayer.stop()
            }
        }
    }
}
