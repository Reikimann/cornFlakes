{ pkgs, ... }:
{
  programs = {
    bash = {
      enable = true;
      enableCompletion = true;
      shellAliases = (import ../aliases.nix).myAliases;
    };

    zoxide = {
      enable = true;
      enableBashIntegration = true;
    };

    # TODO: Find a way to include the configuration
    starship = {
      enable = true;
      enableBashIntegration = true;
    };
  };
}
