{ lib, ... }:

let
  inherit (lib) types mkOption;
in
{
  options.isLaptop = mkOption {
    type = types.bool;
    default = false;
    description = "Whether or not the host is a laptop";
  };
}
