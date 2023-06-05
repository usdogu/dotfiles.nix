# configuration.nix

{ pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./xorg.nix
  ];

  # Use the systemd-boot
  boot = {
    loader = {
      grub.enable = true;
      grub.device = "/dev/sdb";
      grub.useOSProber = true;
    };
    supportedFilesystems = [ "ntfs" ];
  };

  time = {
    hardwareClockInLocalTime = true;
    timeZone = "Europe/Istanbul";
  };

  fonts.fonts = with pkgs; [ (nerdfonts.override { fonts = [ "Iosevka" ]; }) ];

  networking = {
    hostName = "nebula";
    networkmanager.enable = true;
    # useDHCP = true;
    # useDHCP = false;
    # dhcpcd.enable = false;
    # useNetworkd = true;
    # wireless.enable = true;
    # wireless.userControlled.enable = true;
    # wireless.networks."EFiberHGW_ZTNK5Z_2.4GHz".pskRaw =
    #   "62828b83575cc01632b63d486ea89ce495f241923dfa9a7f2e03ba538eca5ebe";
    # wireless.networks."USPRO2.4_Extended".pskRaw =
    #   "55a176bb330c57c275c1591ee578c6f2796eb16899d58798dd9325cf9c1f0f1c";
  };
  # systemd.network.enable = true;
  # systemd.network.wait-online.enable = false;
  # systemd.network.networks = let
  #   networkConfig = {
  #     DHCP = "yes";
  #     DNSSEC = "yes";
  #     DNSOverTLS = "yes";
  #     DNS = [ "1.1.1.1" "1.0.0.1" ];
  #   };
  # in {
  #   # Config for all useful interfaces
  #   "40-wired" = {
  #     enable = true;
  #     name = "en*";
  #     inherit networkConfig;
  #   };
  #   "40-wireless" = {
  #     enable = true;
  #     name = "wl*";
  #     inherit networkConfig;
  #   };
  # };

  # systemd.services.restartWifiDongle = {
  #   wantedBy = [ "multi-user.target" ];
  #   after = [ "network.target" ];
  #   description = "Restart the wifi dongle driver";
  #   serviceConfig = {
  #     ExecStart =
  #       "${pkgs.fish}/bin/fish -c '/run/current-system/sw/bin/rmmod ath9k_htc && /run/current-system/sw/bin/modprobe ath9k_htc'";
  #   };
  # };

  nix.settings.trusted-users = [ "dogu" ];

  console = {
    font = "Lat2-Terminus16";
    keyMap = "trq";
  };

  environment.systemPackages = with pkgs; [ neovim git qt5.qtwayland ];

  # List services that you want to enable:
  services = {
    # gnome.gnome-keyring.enable = true;
    openssh.enable = true;
  };

  security.polkit.enable = true;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };

  # enable OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  virtualisation.docker.enable = true;
  virtualisation.docker.enableOnBoot = true;

  swapDevices = [{
    device = "/var/swapfile";
    size = 2048;
  }];

  security.doas.enable = true;
  security.doas.extraRules = [{
    users = [ "dogu" ];
    noPass = true;
    keepEnv = true;
  }];

  users.users.dogu = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "audio" "docker" ];
    shell = pkgs.fish;
  };
  programs.fish = { enable = true; };

  programs.dconf.enable = true;
  services.dbus.packages = [ pkgs.gcr ];
  services.fstrim.enable = true;
  # allow swaylock to unlock session
  security.pam.services.swaylock = { };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  environment.variables.EDITOR = "nvim";
  system.stateVersion = "23.05";
}
