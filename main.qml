import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts
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
            anchors.bottom: playbackControl.top
            anchors.left: parent.left
            anchors.right: parent.right

            TapHandler {
                onDoubleTapped: {
                    parent.fullScreen ?  showNormal() : showFullScreen()
                    parent.fullScreen = !parent.fullScreen
                }
            }
        }

    PlaybackControl {
            id: playbackControl

            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right

            mediaPlayer: mediaPlayer
        }

    PlayerMenuBar {
            id: menuBar

            anchors.left: parent.left
            anchors.right: parent.right

            visible: !videoOutput.fullScreen

            mediaPlayer: mediaPlayer
            videoOutput: videoOutput
        }


}
