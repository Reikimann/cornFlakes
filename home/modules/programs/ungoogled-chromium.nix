{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.reiki.modules.programs.ungoogled-chromium;
in
{
  options.reiki.modules.programs.ungoogled-chromium = {
    enable = mkEnableOption "Ungoogled Chromium configuration";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      ungoogled-chromium
    ];
  };
}
