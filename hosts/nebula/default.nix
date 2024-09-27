{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./home
  ];

  boot = {
    tmp.cleanOnBoot = true;
    kernelPackages = pkgs.linuxPackages_latest;
    extraModprobeConfig = ''
      options kvm_intel nested=1
      options kvm_intel emulate_invalid_guest_state=0
      options kvm ignore_msrs=1
    '';
    initrd.kernelModules = [ "8821cu" ];
    extraModulePackages = [ config.boot.kernelPackages.rtl8821cu ];
    loader = {
      grub = {
        enable = true;
        device = "/dev/sdb";
        useOSProber = true;
        default = "2";
      };

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

  fonts.packages = with pkgs; [ (nerdfonts.override { fonts = [ "Iosevka" ]; }) ];

  networking = {
    hostName = "nebula";
    networkmanager.enable = true;
    networkmanager.dns = "none";
    nameservers = [
      "127.0.0.1"
      "::1"
    ];
  };
  systemd.services = {
    NetworkManager-wait-online.enable = false;
    dnscrypt-proxy2.serviceConfig.StateDirectory = "dnscrypt-proxy";
  };
  services = {
    dnscrypt-proxy2 = {
      enable = true;
      settings = {
        bootstrap_resolvers = [
          "1.1.1.1:53"
          "8.8.8.8:53"
        ];
        server_names = [ "cloudflare" ];
        sources.public-resolvers = {
          urls = [
            "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
            "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
          ];
          minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
          cache_file = "public-resolvers.md";

        };
      };
    };

    printing = {
      enable = true;
      drivers = with pkgs; [ brgenml1cupswrapper ];
    };

    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
    };

    getty.autologinUser = "dogu";
  };

  nix.settings.trusted-users = [ "dogu" ];

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  virtualisation = {
    libvirtd.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  security = {
    doas = {
      enable = true;
      extraRules = [
        {
          users = [ "dogu" ];
          noPass = true;
          keepEnv = true;
        }
      ];
    };
    sudo.wheelNeedsPassword = false;
  };

  users.users.dogu = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "audio"
      "libvirtd"
      "podman"
    ];
    shell = pkgs.fish;
  };
  programs = {
    fish.enable = true;
    dconf.enable = true;
  };
  services.dbus.packages = [ pkgs.gcr ];
  services.fstrim.enable = true;
  # allow swaylock to unlock session
  security.pam.services.swaylock = { };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "*";
  };

  environment = {
    variables.EDITOR = "hx";
    loginShellInit = ''
      [[ "$(tty)" == /dev/tty1 ]] && sway
    '';
    systemPackages = with pkgs; [
      helix
      git
      qt5.qtwayland
      virt-manager
    ];
  };
  system.stateVersion = "24.05";
}
