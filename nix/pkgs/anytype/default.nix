{
  lib,
  fetchurl,
  appimageTools,
  makeWrapper,
  enableWayland ? true,
}:

let
  pname = "anytype";
  version = "0.42.3";
  name = "Anytype-${version}";
  src = fetchurl {
    url = "https://github.com/anyproto/anytype-ts/releases/download/v${version}/${name}.AppImage";
    name = "Anytype-${version}.AppImage";
    hash = "sha256-4Tz080lNQXqTq+LEax4fYV27/DDSRUalpkO46KZ1ay8=";
  };
  appimageContents = appimageTools.extractType2 { inherit name src; };
in
appimageTools.wrapType2 {
  inherit name src;

  extraPkgs = pkgs: [ pkgs.libsecret ];

  extraInstallCommands = ''
    mv $out/bin/${name} $out/bin/${pname}
    source "${makeWrapper}/nix-support/setup-hook"
    ${
      if enableWayland then
        ''
          wrapProgram $out/bin/${pname} \
            --add-flags "\''${NIXOS_OZONE_WL:+\''${WAYLAND_DISPLAY:+--ozone-platform-hint=auto --enable-features=WaylandWindowDecorations}}"
        ''
      else
        ""
    }
    install -m 444 -D ${appimageContents}/anytype.desktop -t $out/share/applications
    substituteInPlace $out/share/applications/anytype.desktop \
      --replace 'Exec=AppRun' 'Exec=${pname}'
    for size in 16 32 64 128 256 512 1024; do
      install -m 444 -D ${appimageContents}/usr/share/icons/hicolor/''${size}x''${size}/apps/anytype.png \
        $out/share/icons/hicolor/''${size}x''${size}/apps/anytype.png
    done
  '';

  meta = with lib; {
    description = "P2P note-taking tool without wayland-wrapper for old nvidia cards";
    homepage = "https://anytype.io/";
    license = licenses.unfree;
    platforms = [ "x86_64-linux" ];
  };
}