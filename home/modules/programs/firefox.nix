{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.reiki.modules.programs.firefox;
in
{
  options.reiki.modules.programs.firefox = {
    enable = mkEnableOption "Firefox configuration";
    isDefaultBrowser = mkOption {
      description = "Whether or not firefox is the default browser";
      default = true;
      type = types.bool;
    };
    enableKeepassXC = mkOption {
      description = "Enable KeepassXC Integration";
      default = true;
      type = types.bool;
    };
  };

  config = mkIf cfg.enable {
    programs.firefox = {
      enable = true;
      nativeMessagingHosts = [] ++ lib.optional cfg.enableKeepassXC pkgs.keepassxc;
    };

    home.sessionVariables = mkIf cfg.isDefaultBrowser {
      BROWSER = "firefox";
    };

    xdg.mimeApps.defaultApplications = mkIf cfg.isDefaultBrowser {
      "text/html" = ["firefox.desktop"];
      "text/xml" = ["firefox.desktop"];
      "x-scheme-handler/http" = ["firefox.desktop"];
      "x-scheme-handler/https" = ["firefox.desktop"];
    };
  };
}
