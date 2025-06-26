import QtQuick
import "../config"

Text {
  id: root

  property real fill: 0
  property real grad: 0

  required property string symbol
  text: root.symbol

  font.family: Appearance.font.family.icons
  font.pointSize: Appearance.font.size.larger
  font.variableAxes: {
    "FILL": fill.toFixed(1),
    "opsz": root.fontInfo.pixelSize,
    "GRAD": root.grad,
    "wght": root.fontInfo.weight
  }
  renderType: Text.NativeRendering
}
