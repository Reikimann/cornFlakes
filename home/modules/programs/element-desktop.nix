{ config, lib, ... }:

with lib;
let
  cfg = config.reiki.modules.programs.element-desktop;
in
{
  options.reiki.modules.programs.element-desktop = {
    enable = mkEnableOption "Element-desktop configuration";
  };

  config = mkIf cfg.enable {
    programs.element-desktop = {
      enable = true;
    };
  };
}
