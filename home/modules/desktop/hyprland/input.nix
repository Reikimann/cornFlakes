{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    gesture = [
      "3, vertical, workspace"
    ];
    input = {
      kb_layout = "dk";
      #kb_options = ctrl:swapcaps
      numlock_by_default = true;

      # 0 - Cursor movement will not change focus.
      # 1 - Cursor movement will always change focus to the window under the cursor.
      # 2 - Cursor focus will be detached from keyboard focus. Clicking on a window will move keyboard focus to that window.
      # 3 - Cursor focus will be completely separate from keyboard focus. Clicking on a window will not change keyboard focus.
      follow_mouse = 2;
      sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
      repeat_rate = 40;

      touchpad = {
        natural_scroll = true;
        # TEST: The settings below should be the default
        # disable_while_typing = 1;
        # clickfinger_behavior = 0;
        # middle_button_emulation = 0;
        # tap-to-click = 1;
      };
    };
  };
}
