{ pkgs, config, lib, ... }:

with lib;
let
  cfg = config.reiki.modules.desktop.swaylock;
in
{
  options.reiki.modules.desktop.swaylock = {
    enable = mkEnableOption "Swaylock configuration";
  };

  config = mkIf cfg.enable {
    programs.swaylock = {
      enable = true;
      package = pkgs.swaylock-effects;
      settings = {
        clock = true;
        datestr = "%d/%m";
        screenshots = true;
        daemonize = true;
        fade-in = 0.1;

        grace = 2;
        grace-no-mouse = true;
        grace-no-touch = true;
        ignore-empty-password = true;

        indicator = true;
        indicator-radius = 180;
        indicator-thickness = 18;

        effect-blur = "9x9";
        effect-vignette = "0.5:0.5";

        ring-color = "3C4360";
        line-color = "00000000";
        inside-color = "00000088";
        separator-color = "00000000";

        text-color = "cdd6f4";
        #text-color=5D00BA
        key-hl-color = "5D00BA";
        bs-hl-color = "880033";

        ring-ver-color = "90BC61";
        inside-ver-color = "90BC61";

        ring-wrong-color = "880033";
        inside-wrong-color = "880033";

        text-caps-lock-color = "880033";

        ring-clear-color = "E7905C";
        inside-clear-color = "E7905C";
      };
    };
  };
}
