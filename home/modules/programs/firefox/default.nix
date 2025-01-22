{ config, lib, ... }:

with lib;
let
  cfg = config.reiki.modules.programs.firefox;
in
{
  options.reiki.modules.programs.firefox = {
    enable = mkEnableOption "Firefox configuration";
  };

  config = mkIf cfg.enable {
    programs.firefox = {
      enable = true;
    };

    # TODO: Add a proper setting for the default browser
    home.sessionVariables = {
      BROWSER = "firefox";
    };
  };
}
