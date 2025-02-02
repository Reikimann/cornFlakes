{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.reiki.modules.desktop.dunst;
in
{
  options.reiki.modules.desktop.dunst = {
    enable = mkEnableOption "Lightweight notification-deamon service";
    font = mkOption {
      description = "Override notification font";
      default = "Liga SFMono Nerd Font";
      type = types.str;
    };
    fontSize = mkOption {
      description = "Override notification font size";
      default = 12;
      type = types.int;
    };
  };

  config = {
    services.dunst = {
      enable = true;
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
        size = "32x32";
      };
      settings = {
        global = {
          follow = "mouse"; # Mouse, keyboard, none
          width = 300;
          height = 300;
          origin = "top-right";
          offset = "10x10";
          notification_limit = 0;
          progress_bar = true;
          progress_bar_height = 10;
          progress_bar_frame_width = 1;
          progress_bar_min_width = 150;
          progress_bar_max_width = 300;
          separator_height = 2;
          padding = 8;
          horizontal_padding = 8;
          text_icon_padding = 0;
          frame_width = 2;
          frame_color = "#bb9af7";
          separator_color = "frame";
          font = "${cfg.font} ${toString cfg.fontSize}";
          markup = "full";
          # The format of the message.  Possible variables are:
          #   %a  appname
          #   %s  summary
          #   %b  body
          #   %i  iconname (including its path)
          #   %I  iconname (without its path)
          #   %p  progress value if set ([  0%] to [100%]) or nothing
          #   %n  progress value if set without any extra characters
          #   %%  Literal %
          # Markup is allowed
          format = "<b>%s</b>\n%b";
          enable_recursive_icon_lookup = true;
          icon_theme = "Papirus-Dark";
          max_icon_size = 64;
          corner_radius = 5;
          # Defines list of actions for each mouse event
          # Possible values are:
          # * none: Don't do anything.
          # * do_action: Invoke the action determined by the action_name rule. If there is no
          #              such action, open the context menu.
          # * open_url: If the notification has exactly one url, open it. If there are multiple
          #             ones, open the context menu.
          # * close_current: Close current notification.
          # * close_all: Close all notifications.
          # * context: Open context menu for the notification.
          # * context_all: Open context menu for all notifications.
          mouse_left_click = "close_current";
          mouse_middle_click = "do_action, close_current";
          mouse_right_click = "close_all";
          # TODO: Set a highlight color
        };
        urgency_low = {
          timeout = 3;
          background = "#1a1b30";
          foreground = "#c0caf5";
        };
        urgency_normal = {
          timeout = 5;
          background = "#1a1b30";
          foreground = "#c0caf5";
        };
        urgency_critical = {
          timeout = 0;
          background = "#1a1b30";
          foreground = "#c0caf5";
          frame_color = "#db4b4b";
        };
      };
    };
  };
}
