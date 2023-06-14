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

  fonts.fonts = with pkgs; [ (nerdfonts.override { fonts = [ "Iosevka" ]; }) ];

  networking = {
    hostName = "nebula";
    networkmanager.enable = true;
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
    neovim
    git
    qt5.qtwayland
    virt-manager
  ];

  services = { openssh.enable = true; };

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

  zramSwap.enable = true;

  security.doas.enable = true;
  security.doas.extraRules = [{
    users = [ "dogu" ];
    noPass = true;
    keepEnv = true;
  }];

  users.users.dogu = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "audio" "libvirtd" ];
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
