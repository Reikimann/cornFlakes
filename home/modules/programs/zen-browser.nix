{ config, lib, pkgs, inputs, ... }:

with lib;
let
  cfg = config.reiki.modules.programs.zen-browser;
in
{
  options.reiki.modules.programs.zen-browser = {
    enable = mkEnableOption "Zen-browser configuration";
    isDefaultBrowser = mkOption {
      description = "Whether or not Zen-browser is the default browser";
      default = false;
      type = types.bool;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      inputs.zen-browser.packages."${pkgs.system}".default
    ];

    home.sessionVariables = mkIf cfg.isDefaultBrowser {
      BROWSER = "zen";
    };

    xdg.mimeApps.defaultApplications = mkIf cfg.isDefaultBrowser {
      "text/html" = ["zen.desktop"];
      "text/xml" = ["zen.desktop"];
      "x-scheme-handler/http" = ["zen.desktop"];
      "x-scheme-handler/https" = ["zen.desktop"];
    };
  };
}
