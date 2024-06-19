{ pkgs, ... }:

{
  imports = [ ./home ];
  services.nix-daemon.enable = true;
  users.users.dogu = {
    name = "dogu";
    home = "/Users/dogu";
    shell = pkgs.fish;
  };
  programs.fish.enable = true;
  fonts.packages = with pkgs;
    [ (nerdfonts.override { fonts = [ "Iosevka" ]; }) ];

}
