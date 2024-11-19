{
  inputs,
  config,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    (inputs.self + /users/dogu)
    ./home
  ];
  networking.hostName = "nebula";

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
    supportedFilesystems = [ "ntfs" ];
  };

  time = {
    hardwareClockInLocalTime = true;
    timeZone = "Europe/Istanbul";
  };

  fonts.packages = with pkgs; [ (nerdfonts.override { fonts = [ "Iosevka" ]; }) ];

  services = {
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

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  security = {
    polkit = {
      enable = true;
      extraConfig = ''
          polkit.addRule(function(action, subject) {
          if (
            subject.isInGroup("users")
              && (
                action.id == "org.freedesktop.login1.reboot" ||
                action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
                action.id == "org.freedesktop.login1.power-off" ||
                action.id == "org.freedesktop.login1.power-off-multiple-sessions"
              )
            )
          {
            return polkit.Result.YES;
          }
        });      
      '';
    };
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

  programs.dconf.enable = true;
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

  dogu = {
    nixSettings.enable = true;
    tailscale.enable = true;
    network.enable = true;
    agenix.enable = true;
    grub = {
      enable = true;
      device = "/dev/sdb";
      useOSProber = true;
      default = "2";
      theme = "vimix";
    };
  };
  system.stateVersion = "25.05";
}
