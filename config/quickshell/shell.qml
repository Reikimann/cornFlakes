//@ pragma Env QS_NO_RELOAD_POPUP=1

import Quickshell
import "modules/bar"
import "modules/osd"
import "modules/session"

ShellRoot {
  //Bar {}
  Osd {}

  LazyLoader { active: true; component: Session { } }
}
