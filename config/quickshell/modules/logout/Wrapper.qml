import QtQuick
import Quickshell
import Quickshell.Hyprland

Scope {
  GlobalShortcut {
    name: "logoutScreenToggle"
    description: qsTr("Toggles the fullscreen logout utility on press")

    onPressed: {
      logoutLoader.active = !logoutLoader.active;
    }
  }

  Loader {
    id: logoutLoader
    active: false

    // TODO: Make this better
    // and add GlobalStates (git-user:end-4)
    sourceComponent: Item{
      visible: logoutLoader.active

      Logout {
        LogoutButton {
          text: qsTr("Lock[l]")
          command: "swaylock"
          keybind: Qt.Key_L
          icon: "lock.png" // Material icon: lock
        }
        LogoutButton {
          text: qsTr("Reboot[r]")
          command: "systemctl reboot"
          keybind: Qt.Key_R
          icon: "restart.png" // Material icon: restart
        }
        LogoutButton {
          text: qsTr("Shutdown[s]")
          command: "systemctl poweroff"
          keybind: Qt.Key_S
          icon: "power.png" // Material icon: mode_off_on
        }
        LogoutButton {
          text: qsTr("Logout[o]")
          command: "hyprctl dispatch exit 0"
          keybind: Qt.Key_O
          icon: "logout.png" // Material icon: logout
        }
        LogoutButton {
          text: qsTr("Suspend[u]")
          command: "systemctl suspend"
          keybind: Qt.Key_U
          icon: "sleep.png" // Material icon: bedtime
        }
      }
    }
  }
}
