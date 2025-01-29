{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.reiki.modules.programs.keepassxc;
in
{
  options.reiki.modules.programs.keepassxc = {
    enable = mkEnableOption "KeepassXC configuration";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      keepassxc
    ];
  };
}
