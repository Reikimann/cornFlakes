import "../../services"
import "../../config"
import "../../widgets"
import QtQuick
import QtQuick.Layouts

RowLayout {
  MaterialIcon {
    text: "schedule"
  }

  Text {
    text: Time.format("ddd, MMM. dd - hh:mm")
    font.family: Appearance.font.family.mono
    font.pointSize: Appearance.font.size.small
  }
}
