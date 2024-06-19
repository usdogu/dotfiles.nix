{ pkgs, ... }:

{
  imports = [ ./home ];
  networking.hostName = "mek";
  services.nix-daemon.enable = true;
  users.users.dogu = {
    name = "dogu";
    home = "/Users/dogu";
    shell = pkgs.fish;
  };
  programs.fish.enable = true;
  fonts.packages = with pkgs;
    [ (nerdfonts.override { fonts = [ "Iosevka" ]; }) ];
  homebrew = {
    enable = true;
    caskArgs.no_quarantine = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };
    taps = [ "vladkens/tap" "nikitabobko/tap" ];
    brews = [ "fnm" ];
    casks = [ "cloudflare-warp" "stats" "surfshark" "visual-studio-code" ];
  };
}
