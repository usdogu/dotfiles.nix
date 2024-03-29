{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ./home ];

  boot = {
    tmp.cleanOnBoot = true;
    extraModprobeConfig = ''
      options kvm_intel nested=1
      options kvm_intel emulate_invalid_guest_state=0
      options kvm ignore_msrs=1
    '';
    initrd.kernelModules = [ "8821cu" ];
    extraModulePackages = [ config.boot.kernelPackages.rtl8821cu ];
    loader = {
      grub.enable = true;
      grub.device = "/dev/sdb";
      grub.useOSProber = true;

      grub2-theme = {
        enable = true;
        theme = "vimix";
      };
    };
    supportedFilesystems = [ "ntfs" ];
  };

  time = {
    hardwareClockInLocalTime = true;
    timeZone = "Europe/Istanbul";
  };

  fonts.packages = with pkgs;
    [ (nerdfonts.override { fonts = [ "Iosevka" ]; }) ];

  networking = {
    hostName = "nebula";
    networkmanager.enable = true;
    networkmanager.dns = "none";
    nameservers = [ "127.0.0.1" "::1" ];
  };
  systemd.services.NetworkManager-wait-online.enable = false;

  services.dnscrypt-proxy2 = {
    enable = true;
    settings = {
      bootstrap_resolvers = [ "1.1.1.1:53" "8.8.8.8:53" ];
      server_names = [ "cloudflare" ];
      sources.public-resolvers = {
        urls = [
          "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
          "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
        ];
        minisign_key =
          "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
      };
    };
  };
  systemd.services.dnscrypt-proxy2.serviceConfig = {
    StateDirectory = "dnscrypt-proxy";
  };

  services.printing = {
    enable = true;
    drivers = with pkgs; [ brgenml1cupswrapper ];
  };

  nix.settings.trusted-users = [ "dogu" ];

  console = {
    font = "Lat2-Terminus16";
    keyMap = "trq";
  };

  environment.systemPackages = with pkgs; [
    helix
    git
    qt5.qtwayland
    virt-manager
  ];

  security.polkit.enable = true;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  virtualisation.libvirtd.enable = true;
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  security.doas.enable = true;
  security.doas.extraRules = [{
    users = [ "dogu" ];
    noPass = true;
    keepEnv = true;
  }];
  security.sudo.wheelNeedsPassword = false;

  users.users.dogu = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "audio" "libvirtd" ];
    shell = pkgs.fish;
  };
  services.getty.autologinUser = "dogu";
  environment.loginShellInit = ''
    [[ "$(tty)" == /dev/tty1 ]] && sway
  '';
  programs.fish.enable = true;

  programs.dconf.enable = true;
  services.dbus.packages = [ pkgs.gcr ];
  services.fstrim.enable = true;
  # allow swaylock to unlock session
  security.pam.services.swaylock = { };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  environment.variables.EDITOR = "hx";
  system.stateVersion = "23.05";
}
