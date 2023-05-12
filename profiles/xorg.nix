{
  services.xserver = {
    enable = true;
    layout = "tr";
    displayManager.lightdm.enable = false;
    displayManager.startx.enable = true;
  };
}
