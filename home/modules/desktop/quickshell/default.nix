{ config, lib, pkgs, inputs, ... }:

with lib;
let
  cfg = config.reiki.modules.desktop.quickshell;
in
{
  options.reiki.modules.desktop.quickshell = {
    enable = mkEnableOption "Quickshell configuration";
  };

  # NOTE: Nix users should note that qmlls will not be able
  # to pick up qml modules that are not in QML2_IMPORT_PATH.
  # The easiest way to ensure this is by setting qt.enable
  # to true and installing the quickshell package globally.
  config = mkIf cfg.enable {
    home.packages = [
      inputs.quickshell.packages."${pkgs.system}".default
      pkgs.qt6.qtdeclarative
    ];
    qt.enable = true;

    xdg.configFile = {
      "quickshell" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.dotfilesPath}/config/quickshell";
      };
    };
  };
}
