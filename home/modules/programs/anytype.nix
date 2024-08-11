{ pkgs, ... }:

{
  home.packages = [
    (pkgs.symlinkJoin {
      name = "anytype";
      paths = [ pkgs.anytype ];
      buildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/anytype \
          --unset NIXOS_OZONE_WL
      '';
    })
  ];
}
