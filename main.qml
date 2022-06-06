import QtQuick
import QtQuick.Window
import QtMultimedia

Window {
    width: 440
    height: 480
    visible: true
    title: qsTr("QML Media Player Demo")

    MediaPlayer {
            id: mediaPlayer

            videoOutput: videoOutput
            audioOutput: AudioOutput {
                id: audio
            }
        }

    VideoOutput {
            id: videoOutput

            property bool fullScreen: false

            anchors.top: fullScreen ? parent.top : menuBar.bottom
            anchors.left: parent.left
            anchors.right: parent.right

            TapHandler {
                onDoubleTapped: {
                    parent.fullScreen ?  showNormal() : showFullScreen()
                    parent.fullScreen = !parent.fullScreen
                }
            }
        }

    FileOpener {
            id: menuBar

            anchors.left: parent.left
            anchors.right: parent.right

            text: 'Open File'

            mediaPlayer: mediaPlayer
        }

    Item {
        width: 300; height: 100

        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        Row {
            spacing: 20
            anchors{
                 horizontalCenter: parent.horizontalCenter
                 verticalCenter: parent.verticalCenter
            }
            height: parent.height
            width: childrenRect.width
            anchors.bottom: parent.bottom

            PauseButton {
                 id: pauseButton
                 anchors.verticalCenter: parent.verticalCenter
                 radius: 50.0
                 text: "\u2016";
                 onClicked: mediaPlayer.pause()
             }

             PlayButton {
                 id: playButton
                 anchors.verticalCenter: parent.verticalCenter
                 radius: 50.0
                 text: "\u25B6";
                 onClicked: mediaPlayer.play()
             }

             StopButton {
                 id: stopButton
                 anchors.verticalCenter: parent.verticalCenter
                 radius: 50.0
                 text: "\u25A0";
                 onClicked: mediaPlayer.stop()
             }

             Text {
                 id: mediaTime
                 horizontalAlignment: Text.AlignRight
                 anchors.verticalCenter: parent.verticalCenter
                 text: {
                     var m = Math.floor(mediaPlayer.position / 60000)
                     var ms = (mediaPlayer.position / 1000 - m * 60).toFixed(1)
                     return `${m}:${ms.padStart(4, 0)}`
                 }
             }
        }

        PlaybackSlider {
            id: mediaSlider
            anchors.bottom: parent.top
            anchors.horizontalCenter: parent.horizontalCenter

            property double backend: 0

            maximum:  mediaPlayer.duration
            value:    mediaPlayer.position
            minimum: 0
            mediaPlayer: mediaPlayer

            onClicked: backend = value
        }
    }
}
