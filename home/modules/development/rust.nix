{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.reiki.modules.development.rust;
in
{
  options.reiki.modules.development.rust = {
    enable = mkEnableOption "Rust configuration";
  };

  config = mkIf cfg.enable {
    home = {
      packages = [ pkgs.rustup ];

      sessionVariables = {
        RUSTUP_HOME = "${config.xdg.dataHome}/rustup";
        CARGO_HOME = "${config.xdg.dataHome}/cargo";
      };

      sessionPath = [ "$CARGO_HOME/bin" ];
    };
  };
}
