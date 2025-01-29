{ pkgs, config, lib, ... }:

with lib;
let
  cfg = config.reiki.modules.programs.lunatask;
in
{
  options.reiki.modules.programs.lunatask = {
    enable = mkEnableOption "Lunatask configuration";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      lunatask
    ];
  };
}
