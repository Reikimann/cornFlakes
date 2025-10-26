{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.reiki.profiles.development;
in
{
  options.reiki.profiles.development = {
    enable = mkEnableOption "Development profile";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      gnome-font-viewer
      #rpi-imager
      jq
      nmap
      # Shell script analysis tool
      shellcheck
      # Just a command runner
      just
      # Codebase statistics
      tokei
      # Colorpicker
      hyprpicker
      sqlitebrowser
      inetutils
      sqlite
    ];

    reiki.modules = {
      development = {
        editors.emacs.enable = true;
        go.enable = true;
        nodejs.enable = true;
        python.enable = true;
        rust.enable = true;
        latex.enable = true;
        typst.enable = true;
      };
    };
  };
}
