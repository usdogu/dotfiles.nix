{
  inputs,
  # config,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./disko.nix
    inputs.disko.nixosModules.disko
    (inputs.self + /users/dogu)
    inputs.self.nixosModules.dogu
    # ./home
  ];
  networking.hostName = "oberon";
  networking.firewall.allowedTCPPorts = [ 22 ];
  boot = {
    kernelParams = [ "net.ifnames=0" ];
    tmp.cleanOnBoot = true;
    loader = {
      systemd-boot.enable = true;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };
    initrd.systemd.enable = true;
    kernelPackages = pkgs.linuxPackages_latest;
  };

  time = {
    timeZone = "Europe/Istanbul";
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

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  environment = {
    variables.EDITOR = "hx";
    systemPackages = with pkgs; [
      helix
      git
      virt-manager
    ];
  };

  dogu = {
    nixSettings.enable = true;
    tailscale.enable = true;
    network.enable = true;
    agenix.enable = true;
  };
  system.stateVersion = "25.05";
}
