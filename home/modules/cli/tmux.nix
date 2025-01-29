{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.reiki.modules.cli.tmux;
in
{
  options.reiki.modules.cli.tmux = {
    enable = mkEnableOption "Tmux configuration";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      tmux
    ];
  };
}
