{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ripgrep
    fd
    wget
    lsd
    rm-improved
    tealdeer
    htop-vim
    jaq # alternative for jq
    home-manager
    fzf
    gh
    bun
  ];
}
