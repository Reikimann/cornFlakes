{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.reiki.modules.cli.yt-dlp;
in
{
  options.reiki.modules.cli.yt-dlp = {
    enable = mkEnableOption "YT-DLP configuration";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      yt-dlp
    ];
  };
}
