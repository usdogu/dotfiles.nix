# configuration.nix

{ config, pkgs, lib, ... }:

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
      grub.version = 2;
      grub.device = "/dev/sdc";
      grub.useOSProber = true;
    };
  };

  networking = {
    hostName = "nebula";
    networkmanager.enable = true;
    interfaces.enp3s0.useDHCP = true;
    interfaces.wlp0s29f7u1.useDHCP = true;
  };

  # Set your time zone.
  time.timeZone = "Europe/Istanbul";

  nix.settings.trusted-users = [ "dogu" ];

  console = {
    font = "Lat2-Terminus16";
    keyMap = "trq";
  };

  environment.systemPackages = with pkgs; [
    neovim
    git
  ];


  # List services that you want to enable:
  services = {
    gnome.gnome-keyring.enable = true;
  };

  # Enable sound.
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

  programs.dconf.enable = true;
  programs.fish = {
    enable = true;
  };

  environment.variables.EDITOR = "nvim";

}
