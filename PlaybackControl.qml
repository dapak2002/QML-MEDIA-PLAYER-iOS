import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia

Item {
    id: root

    required property MediaPlayer mediaPlayer
    property int mediaPlayerState: mediaPlayer.playbackState

    height: frame.height

    opacity: 1

    Connections {
        target: mediaPlayer
        function onPlaybackStateChanged() { updateOpacity() }
        function onHasVideoChanged() { updateOpacity() }
    }

    Frame {
        id: frame
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        background: Rectangle {
            color: "white"
        }

        ColumnLayout {
            id: playbackControlPanel
            anchors.fill: parent
            anchors.leftMargin: 10
            anchors.rightMargin: 10

            PlaybackSeekControl {
                            Layout.fillWidth: true
                            mediaPlayer: root.mediaPlayer
                        }

            RowLayout {
                id: playerButtons

                Layout.fillWidth: true

                Item {
                    Layout.fillWidth: true
                }

                RowLayout {
                    Layout.alignment: Qt.AlignCenter
                    id: controlButtons

                    RoundButton {
                        id: pauseButton
                        radius: 50.0
                        text: "\u2016";
                        onClicked: mediaPlayer.pause()
                    }

                    RoundButton {
                        id: playButton
                        radius: 50.0
                        text: "\u25B6";
                        onClicked: mediaPlayer.play()
                    }

                    RoundButton {
                        id: stopButton
                        radius: 50.0
                        text: "\u25A0";
                        onClicked: mediaPlayer.stop()
                    }
                }

                Item {
                    Layout.fillWidth: true
                }
            }
        }
    }

    states: [
        State {
            name: "playing"
            when: mediaPlayerState == MediaPlayer.PlayingState
            PropertyChanges { target: pauseButton; visible: true}
            PropertyChanges { target: playButton; visible: false}
            PropertyChanges { target: stopButton; visible: true}
        },
        State {
            name: "stopped"
            when: mediaPlayerState == MediaPlayer.StoppedState
            PropertyChanges { target: pauseButton; visible: false}
            PropertyChanges { target: playButton; visible: true}
            PropertyChanges { target: stopButton; visible: false}
        },
        State {
            name: "paused"
            when: mediaPlayerState == MediaPlayer.PausedState
            PropertyChanges { target: pauseButton; visible: false}
            PropertyChanges { target: playButton; visible: true}
            PropertyChanges { target: stopButton; visible: true}
        }
    ]

}
