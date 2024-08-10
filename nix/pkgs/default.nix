{ pkgs ? import <nixpkgs> {}, }: {
  sf-mono-liga-bin = pkgs.callPackage ./sf-mono-liga-bin {};
  anytype = pkgs.callPackage ./anytype-no-wayland { enableWayland = false; };
}

# TODO: Make this work: or something similar
#rec {
#  overlay = final: prev:
#    let
#      dirContents = builtins.readDir ../pkgs;
#      genPackage = name: {
#        inherit name;
#        value = final.callPackage (../pkgs + "/${name}") { };
#      };
#      names = builtins.attrNames dirContents;
#    in
#    builtins.listToAttrs (map genPackage names);
#}
