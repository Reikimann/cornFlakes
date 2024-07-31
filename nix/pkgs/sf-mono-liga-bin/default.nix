{ stdenvNoCC
, fetchFromGitHub
, lib
,
}:
stdenvNoCC.mkDerivation rec {
  pname = "sf-mono-liga-bin";
  version = "dc5a3e6fcc2e16ad476b7be3c3c17c2273b260ea";

  src = fetchFromGitHub {
    owner = "shaunsingh";
    repo = "SFMono-Nerd-Font-Ligaturized";
    rev = version;
    sha256 = "sha256-AYjKrVLISsJWXN6Cj74wXmbJtREkFDYOCRw1t2nVH2w=";
  };

  dontConfigure = true;
  installPhase = ''
    mkdir -p $out/share/fonts/opentype
    cp -r $src/*.otf $out/share/fonts/opentype
  '';

  meta = with lib; {
    description = "SFMono Nerd Font with Ligatures";
    homepage = "https://github.com/shaunsingh/SFMono-Nerd-Font-Ligaturized";
    platforms = platforms.all;
  };
}
