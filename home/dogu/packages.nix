{ pkgs, ... }:

let
  my-python-packages = python-packages:
    with python-packages; [
      requests
      beautifulsoup4
    ];
  python-with-my-packages = pkgs.python3.withPackages my-python-packages;
in {
  home.packages = with pkgs; [
    ripgrep
    fd
    wget
    lsd
    rm-improved
    tealdeer
    gnutls
    gnumake
    python-with-my-packages
    file
    ps_mem
    killall
    htop-vim
    jaq # alternative for jq
    bat-extras.batman # use bat for viewing man pages
    home-manager
    fzf
  ];
}
