{ config, modulesPath, ... }: {
  imports = [ "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix" ];
  boot = {
    initrd.kernelModules = [ "8821cu" ];
    extraModulePackages = [ config.boot.kernelPackages.rtl8821cu ];
  };
}
