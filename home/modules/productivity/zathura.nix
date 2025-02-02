{ config, lib, ... }:

with lib;
let
  cfg = config.reiki.modules.productivity.zathura;
in
{
  options.reiki.modules.productivity.zathura = {
    enable = mkEnableOption "Zathura configuration";
    font = mkOption {
      description = "Override font";
      default = "Liga SFMono Nerd Font Regular";
      type = types.str;
    };
    fontSize = mkOption {
      description = "Override font size";
      default = 10;
      type = types.int;
    };
  };

  config = mkIf cfg.enable {
    programs.zathura = {
      enable = true;
      options = {
        font = "${cfg.font} ${toString cfg.fontSize}";

        notification-error-bg       = "#ff5555"; # Red
        notification-error-fg       = "#f8f8f2"; # Foreground
        notification-warning-bg     = "#ffb86c"; # Orange
        notification-warning-fg     = "#44475a"; # Selection
        notification-bg             = "#282a36"; # Background
        notification-fg             = "#f8f8f2"; # Foreground

        completion-bg               = "#282a36"; # Background
        completion-fg               = "#6272a4"; # Comment
        completion-group-bg         = "#282a36"; # Background
        completion-group-fg         = "#6272a4"; # Comment
        completion-highlight-bg     = "#44475a"; # Selection
        completion-highlight-fg     = "#f8f8f2"; # Foreground

        index-bg                    = "#282a36"; # Background
        index-fg                    = "#f8f8f2"; # Foreground
        index-active-bg             = "#44475a"; # Current Line
        index-active-fg             = "#f8f8f2"; # Foreground

        inputbar-bg                 = "#282a36"; # Background
        inputbar-fg                 = "#f8f8f2"; # Foreground
        statusbar-bg                = "#282a36"; # Background
        statusbar-fg                = "#f8f8f2"; # Foreground

        highlight-color             = "#ffb86c"; # Orange
        highlight-active-color      = "#ff79c6"; # Pink

        default-bg                  = "#282a36"; # Background
        default-fg                  = "#f8f8f2"; # Foreground

        render-loading              = true;
        render-loading-fg           = "#282a36"; # Background
        render-loading-bg           = "#f8f8f2"; # Foreground

        #
        # Recolor mode settings
        #

        recolor-lightcolor          = "#282a36"; # Background
        recolor-darkcolor           = "#f8f8f2"; # Foreground

        #
        # Startup options
        #

        recolor = false;

        selection-clipboard = "clipboard";

        statusbar-h-padding = 0;
        statusbar-v-padding = 0;
        adjust-open = "width";
        page-padding = 1;
      };
      mappings = {
        u = "scroll half-up";
        d = "scroll half-down";
        D = "toggle_page_mode";
        r = "reload";
        R = "rotate";
        K = "zoom in";
        J = "zoom out";
        i = "recolor";
        p = "print";
      };
    };

    # TODO: Add a proper setting for the default pdf-viewer
    home.sessionVariables = {
      READER = "zathura";
    };

    xdg.mimeApps = {
      defaultApplications = {
        "application/pdf" = "org.pwmt.zathura-pdf-mupdf.desktop";
      };
    };
  };
}
