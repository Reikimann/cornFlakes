{
  # My shell aliases
  myAliases = {
    ls = "eza --icons -l -T -L=1";
    matrix="unimatrix -l cCaGgkr -s 98 -a -f";
    c="clear && zsh";
    C="clear && bash";
    exa="eza --sort=type --icons";
    exal="eza -lah --sort=type --icons";
    v="nvim";
    lf="lfub";
    ls="ls --group-directories-first --color=always";
    fzff="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'";
    yolo="git commit -m '$(curl -s http://whatthecommit.com/index.txt)'";
    standalone="convert -density 300 -alpha remove";
    lv="NVIM_APPNAME=nvimLazy nvim";

    # Dev
    # TODO: Make git aliases instead
    gits="git status";
    gita="git add";
    gpatch="git add --patch";
    gitc="git commit";
    gitp="git push";
  };
}
