{ config, lib, ... }:

with lib;
let
  cfg = config.reiki.modules.programs.kitty;
in
{
  options.reiki.modules.programs.kitty = {
    enable = mkEnableOption "Kitty terminal configuration";
    font = mkOption {
      description = "Override font";
      default = "Liga SFMono Nerd Font";
      type = types.str;
    };
    fontSize = mkOption {
      description = "Override font size";
      default = 14;
      type = types.int;
    };
  };

  config = mkIf cfg.enable {
    programs.kitty = {
      enable = true;
      font = {
        name = cfg.font;
        size = cfg.fontSize;
      };
      themeFile = "tokyo_night_night";
      settings = {
        enable_audio_bell = false;
        tab_bar_style = "powerline";
        confirm_os_window_close = 0;
      };
      # Kitty_mod = ctrl+shift
      keybindings = {
        "kitty_mod+escape" = ""; # Disable kitty shell
      };
    };

    # TODO: Add a proper setting for the default terminal
    home.sessionVariables = {
      TERMINAL = "kitty";
    };
  };
}
