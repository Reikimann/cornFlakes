{ config, lib, ... }:

with lib;
let
  cfg = config.reiki.modules.cli.btop;
in
{
  options.reiki.modules.cli.btop = {
    enable = mkEnableOption "Btop configuration";
  };

  config = mkIf cfg.enable {
    programs.btop = {
      enable = true;
      settings = {
        color_theme = "tokyo-night";
        theme_background = false;
        vim_keys = true;
        update_ms = 500;
      };
    };
  };
}
