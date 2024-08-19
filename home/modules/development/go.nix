{ config, ... }:

{
  programs = {
    go = {
      enable = true;
    };
  };

  home.sessionVariables = {
    GOPATH = "${config.xdg.dataHome}/go";
  };
}
