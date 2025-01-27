{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.reiki.modules.programs.firefox;
in
{
  options.reiki.modules.programs.firefox = {
    enable = mkEnableOption "Firefox configuration";
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

    # TODO: Add a proper setting for the default browser
    home.sessionVariables = {
      BROWSER = "firefox";
    };
  };
}
