pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Controls
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import "../../config"

Scope {
  id: root

  GlobalShortcut {
    name: "sessionToggle"
    description: qsTr("Toggles session utility")

    onPressed: {
      sessionLoader.active = !sessionLoader.active;
    }
  }

  Loader {
    id: sessionLoader
    active: false

    // TODO: add GlobalStates (git-user:end-4)
    sourceComponent: PanelWindow {
      id: w
      visible: sessionLoader.active

      exclusionMode: ExclusionMode.Ignore
      WlrLayershell.layer: WlrLayer.Overlay
      WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive

      anchors { top: true; left: true; bottom: true; right: true }
      color: "transparent"

      ListModel {
        id: buttonModel

        ListElement { label: qsTr("Lock[l]"); cmd: "swaylock"; key: Qt.Key_L; pic: "lock.png"; } // Icon: lock
        ListElement { label: qsTr("Reboot[r]"); cmd: "systemctl reboot"; key: Qt.Key_R; pic: "restart.png"; } // Icon: restart
        ListElement { label: qsTr("Shutdown[s]"); cmd: "systemctl poweroff"; key: Qt.Key_S; pic: "power.png"; } // Icon: mode_off_on
        ListElement { label: qsTr("Logout[o]"); cmd: "hyprctl dispatch exit 0"; key: Qt.Key_O; pic: "logout.png"; } // Icon: logout
        ListElement { label: qsTr("Suspend[u]"); cmd: "systemctl suspend"; key: Qt.Key_U; pic: "sleep.png"; } // Icon: bedtime
      }

      Image {
        id: backgroundImage
        source: Qt.resolvedUrl("../../assets/pics/wallpaper.png")
        anchors.fill: parent
        layer.enabled: true
        layer.effect: MultiEffect {
          source: backgroundImage
          blurEnabled: true
          autoPaddingEnabled: false
          blurMax: 80
          blur: 0.5
        }
      }

      MouseArea {
        anchors.fill: parent
        onClicked: sessionLoader.active = false

        RowLayout {
          id: grid
          anchors.centerIn: parent
          width: parent.width * 0.85
          height: parent.height * 0.45
          spacing: Appearance.spacing.smaller

          Keys.onEscapePressed: sessionLoader.active = false

          Repeater {
            id: repeater
            model: buttonModel

            SessionButton {
              required property var model
              required property int index
              readonly property bool first: index === 0
              readonly property bool last: index === (buttonModel.count - 1)

              focus: index === 0

              label: model.label
              command: model.cmd
              keybind: model.key
              picture: model.pic

              KeyNavigation.right: last ? repeater.itemAt(0) : repeater.itemAt(index + 1)
              KeyNavigation.left: first ? repeater.itemAt(buttonModel.count - 1) : repeater.itemAt(index - 1)
            }
          }
        }
      }
    }
  }
}

