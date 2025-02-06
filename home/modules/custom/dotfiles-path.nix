{ config, lib, ... }:

let
  inherit (lib) types mkOption;
in
{
  options.dotfilesPath = mkOption {
    description = "Location of the dotfiles working copy";
    default = "${config.home.homeDirectory}/cornFlakes";
    type = types.path;
    apply = toString;
  };
}
