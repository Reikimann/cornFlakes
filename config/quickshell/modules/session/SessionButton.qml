pragma ComponentBehavior: Bound
import Quickshell.Widgets
import QtQuick.Effects
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Io
import "../../config"
import "../../services"


Button {
  id: root

	property color buttonColor: "#1e1e1e00"
	property color buttonHoverColor: "#cba6f7"

  required property string command
  required property string picture
  required property string label
  required property int keybind

  readonly property var process: Process {
    command: ["sh", "-c", `sleep .3 && ${root.command}`]
  }

  onClicked: {
    process.startDetached();
    GlobalStates.sessionOpen = false
  }

  MouseArea {
    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor
    hoverEnabled: true
    onEntered: {
      root.forceActiveFocus()
    }
    onClicked: {
      root.clicked()
    }
  }

  Keys.onPressed: (event) => {
    if (event.key == keybind) {
      root.clicked();
      event.accepted = true
    }
  }
  Keys.onReturnPressed: {
    root.clicked()
  }

  // FIX: For some reason this doesn't work: Icons are wrong
  // Obviously move this to the top: import "../../widgets"
  //MaterialIcon {
  //  id: texticon
  //  text: root.icon
  //  font.pointSize: 75
  //  anchors.centerIn: parent
  //}

  background: Rectangle {
    color: root.activeFocus ? root.buttonHoverColor : root.buttonColor
    border.color: "white"
    border.width: 3
    radius: Appearance.rounding.normal
    Layout.fillWidth: true
    Layout.fillHeight: true
    implicitWidth: parent.parent.width / 5 - 10
    implicitHeight: parent.parent.height

    Behavior on color {
      ColorAnimation {
        duration: Appearance.anim.durations.small
      }
    }

    ColumnLayout {
      anchors.centerIn: parent
      spacing: Appearance.spacing.large

      IconImage {
        id: icon
        source: Qt.resolvedUrl(`../../assets/pics/${root.picture}`)
        implicitSize: root.width * 0.25
        layer.enabled: true
        layer.effect: MultiEffect {
          colorization: 1.0
          colorizationColor: root.activeFocus ? "black" : "white"

          Behavior on colorizationColor {
            ColorAnimation {
              duration: Appearance.anim.durations.small
            }
          }
        }
        Layout.alignment: Qt.AlignHCenter

      }

      Text {
        text: root.label
        font.pointSize: Appearance.font.size.large
        font.family: Appearance.font.family.mono
        color: root.activeFocus ? "black" : "white"
        Layout.alignment: Qt.AlignHCenter

        Behavior on color {
          ColorAnimation {
            duration: Appearance.anim.durations.small
          }
        }
      }
    }
  }
}
