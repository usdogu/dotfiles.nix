{ pkgs, inputs, ... }:

{
  imports = [ inputs.self.homeManagerModules.dogu ];

  home.packages = with pkgs; [
    file
    ps_mem
    killall
    inotify-tools
  ];

  programs.zellij.enable = false;

  dogu = { };
}
