//@ pragma Env QS_NO_RELOAD_POPUP=1
//
// Animate content-size; not window sizes

import Quickshell
import "modules/bar"
import "modules/osd"
import "modules/session"

ShellRoot {
  Bar {}
  Osd {}

  Session {}
}
