{ config, lib, ... }:

with lib;
let
  cfg = config.reiki.modules.cli.eza;
in
{
  options.reiki.modules.cli.eza = {
    enable = mkEnableOption "Eza configuration";
    enableIntegrations = mkOption {
      description = "Enable aliasing ls to eza";
      default = false;
      type = types.bool;
    };
  };

  config = mkIf cfg.enable {
    programs.eza = {
      enable = true;
      icons = "auto";
      colors = "auto";
      git = true;
      extraOptions = [
        "--group-directories-first"
        "--sort=type"
        "--header"
      ];
      # NOTE: Integrations is default for all shells (also Fish, Ion and Nushell)
      enableZshIntegration = cfg.enableIntegrations;
      enableBashIntegration = cfg.enableIntegrations;
    };
  };
}
