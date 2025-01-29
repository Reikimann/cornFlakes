{ config, lib, ... }:

with lib;
let
  cfg = config.reiki.modules.development.go;
in
{
  options.reiki.modules.development.go = {
    enable = mkEnableOption "Go Configuration";
  };

  config = mkIf cfg.enable {
    programs.go = {
      enable = true;
    };

    home.sessionVariables = {
      GOPATH = "${config.xdg.dataHome}/go";
    };
  };
}
