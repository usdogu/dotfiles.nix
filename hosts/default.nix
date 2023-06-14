{ inputs, ... }:

{
  flake.nixosConfigurations = {
    nebula = inputs.self.lib.mkSystem {
      hostname = "nebula";
      system = "x86_64-linux";
      extraSpecialArgs.headless = false;
      home-manager = true;
      extraModules = [
        inputs.agenix.nixosModules.age
        inputs.grub2-themes.nixosModules.default
      ];
    };
  };

}
