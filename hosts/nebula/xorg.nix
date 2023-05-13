{ inputs, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    layout = "tr";
    displayManager.lightdm.enable = false;
    displayManager.startx.enable = true;
    displayManager.sessionPackages =
      [ inputs.hyprland.packages.${pkgs.hostPlatform.system}.default ];
  };
}
