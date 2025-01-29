{ config, lib, ... }:

with lib;
let
  cfg = config.reiki.modules.cli.bat;
in
{
  options.reiki.modules.cli.bat = {
    enable = mkEnableOption "Bat configuration";
  };

  config = mkIf cfg.enable {
    programs.bat.enable = true;
  };
}
