{ pkgs, config, lib, ... }:

with lib;
let
  cfg = config.reiki.modules.programs.spotify;
in
{
  options.reiki.modules.programs.spotify = {
    enable = mkEnableOption "Spotify configuration";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      spotify
    ];
  };
}
