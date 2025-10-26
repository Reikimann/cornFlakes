{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.reiki.modules.development.editors.emacs;
in
{
  options.reiki.modules.development.editors.emacs = {
    enable = mkEnableOption "Emacs configuration";
    isDefaultEditor = mkOption {
      description = "Whether or not Emacs is the default editor";
      default = false;
      type = types.bool;
    };
  };

  config = mkIf cfg.enable {
    services.emacs.package = pkgs.emacs-pgtk;
    programs.emacs = {
      enable = true;
      package = (pkgs.emacsWithPackagesFromUsePackage {
        config = "../../../../emacs.org";
        package = pkgs.emacs-pgtk;
        alwaysEnsure = true;
        alwaysTangle = true;
        # extraEmacsPackages = epkgs: with epkgs; [ ];
      });
    };

    services.emacs.defaultEditor = cfg.isDefaultEditor;
    home.sessionVariables = mkIf cfg.isDefaultEditor {
      VISUAL = "emacsclient";
    };

    xdg.configFile = {
      "emacs/emacs.org" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.dotfilesPath}/config/emacs.org";
      };
    };
  };
}
