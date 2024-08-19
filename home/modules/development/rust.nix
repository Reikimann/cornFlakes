{ pkgs, config, ... }:

{
  home = {
    packages = [ pkgs.rustup ];

    sessionVariables = {
      RUSTUP_HOME = "${config.xdg.dataHome}/rustup";
      CARGO_HOME = "${config.xdg.dataHome}/cargo";
    };

    sessionPath = [ "$CARGO_HOME/bin" ];
  };
}
