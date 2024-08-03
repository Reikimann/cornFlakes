{ pkgs, lib, ... }:
{
  less = {
    enable = true;
    #envVariables = {
    #  # TODO: Does it recognise this? lib.exe printf maybe
    #  LESSOPEN="| '${lib.getBin pkgs.bat}/bin/bat -f %s 2>/dev/null";
    #};
  };
}


