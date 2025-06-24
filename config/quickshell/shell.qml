//@ pragma Env QS_NO_RELOAD_POPUP=1

import Quickshell
import "modules/bar"
import "modules/osd"

ShellRoot {
  Bar {}
  Osd {}
}
