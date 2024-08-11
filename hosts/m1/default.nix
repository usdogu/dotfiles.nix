{ pkgs, ... }:

{
  imports = [ ./home ];
  networking = {
    hostName = "dou-mek";
    computerName = "Dou's Air";
    dns = [ "1.1.1.1" "1.0.0.1" "2606:4700:4700::1111" "2606:4700:4700::1001" ];
    knownNetworkServices = [ "Wi-Fi" "Thunderbolt Bridge" ];
  };
  security.pam.enableSudoTouchIdAuth = true;
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
    casks = [ "cloudflare-warp" "stats" "surfshark" "alt-tab" "appcleaner" "iina" "iterm2" "obs" "orbstack" "orion" "playcover-community" "proxyman" "raycast" "rider" "shottr" "telegram" "swiftformat-for-xcode" ];
    masApps = {
      Xcode = 497799835;
      Flow = 1423210932;
    };
  };
}
