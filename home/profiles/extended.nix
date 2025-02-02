{ config, lib, ... }:

with lib;
let
  cfg = config.reiki.profiles.extended;
in
{
  options.reiki.profiles.extended = {
    enable = mkEnableOption "Extended profile";
  };

  config = mkIf cfg.enable {
    reiki.modules = {
      programs = {
        ungoogled-chromium.enable = true;
      };
      cli = {
        xdg-ninja.enable = true;
        yt-dlp.enable = true;
      };
    };
  };
}
