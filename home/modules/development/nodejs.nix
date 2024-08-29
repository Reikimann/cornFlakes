{ pkgs, config, ... }:

let
  configHome = config.xdg.configHome;
  dataHome = config.xdg.dataHome;
  cacheHome = config.xdg.cacheHome;
in
{
  home = {
    packages = with pkgs; [ nodejs corepack ]; # Corepack to install pkgmanagers

    sessionVariables = {
      NPM_CONFIG_USERCONFIG = "${configHome}/npm/npmrc";
      NPM_CONFIG_CACHE = "${configHome}/npm";
      NPM_CONFIG_PREFIX = "${dataHome}/npm";
      NODE_REPL_HISTORY = "${dataHome}/node/repl_history";
    };

    sessionPath = [ "${dataHome}/npm/bin" ];
  };

  xdg.configFile."npm/npmrc".text = ''
    prefix=${dataHome}/npm
    cache=${cacheHome}/npm
    init-module=${configHome}/npm/config/npm-init.js
    logs-dir=${config.xdg.stateHome}/npm/logs
  '';
}
