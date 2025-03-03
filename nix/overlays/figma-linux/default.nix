self: super:
{
  figma-linux = super.figma-linux.overrideAttrs (old: {
    postFixup = ''
    substituteInPlace $out/share/applications/figma-linux.desktop \
      --replace "Exec=/opt/figma-linux/figma-linux" "Exec=figma-linux"
    '';
  });
}
