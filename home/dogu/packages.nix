{ pkgs, inputs, ... }:

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
    clang
    rustc
    cargo
    lsd
    rm-improved
    gtk-engine-murrine
    tealdeer
    gnutls
    gnumake
    elixir
    inotify-tools
    python-with-my-packages
    file
    ps_mem
    killall
    pavucontrol
    mpv
    htop-vim
    wl-clipboard
    telegram-desktop
    jaq # alternative for jq
    bat-extras.batman # use bat for viewing man pages
    home-manager
    inputs.self.packages."${pkgs.system}".spotify-adblock
    wf-recorder # obs but lighter and for wayland
    fzf
  ];
}
