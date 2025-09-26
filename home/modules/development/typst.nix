{ pkgs, config, lib, ... }:

with lib;
let
  cfg = config.reiki.modules.development.typst;
in
{
  options.reiki.modules.development.typst = {
    enable = mkEnableOption "Typst configuration";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      typst
      typst-live
    ];
  };
}
