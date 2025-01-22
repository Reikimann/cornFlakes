{ pkgs, config, lib, ... }:

with lib;
let
  cfg = config.reiki.modules.programs.rofi;
in
{
  options.reiki.modules.programs.rofi = {
    enable = mkEnableOption "Rofi configuration";
    font = mkOption {
      description = "Override font";
      default = "Liga SFMono Nerd Font";
      type = types.str;
    };
    fontSize = mkOption {
      description = "Override font size";
      default = 13;
      type = types.int;
    };
  };

  config = mkIf cfg.enable {
    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      theme = "themes/cherry";
      font = "${cfg.font} ${toString cfg.fontSize}";
      extraConfig = {
        modi = "window,drun,ssh,combi,run";
        show-icons = true;
        matching = "regex";
        combi-modi = "drun,run";

        kb-row-up = "Control+k,Up";
        kb-row-down = "Control+j,Down";
        kb-remove-to-eol = "";
        kb-accept-entry = "Control+m,Return,KP_Enter";
      };
    };
    home.file.".config/rofi/themes".source = ./themes;
  };
}
