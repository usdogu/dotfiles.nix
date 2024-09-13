{ pkgs, inputs, ... }:
{

  home.packages = with pkgs; [
    file
    ps_mem
    killall
    clang
    rustc
    cargo
    gtk-engine-murrine
    inotify-tools
    pavucontrol
    mpv
    wl-clipboard
    telegram-desktop
    inputs.self.packages."${pkgs.system}".spotify-adblock
    wf-recorder # obs but lighter and for wayland
  ];
}
