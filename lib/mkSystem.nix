{ self, ... } @ inputs: name: system: inputs.nixpkgs.lib.nixosSystem (
  {
    inherit system;
    specialArgs = { inherit inputs self; };
    modules = [
      "${self}/hosts/${name}"
      "${self}/modules"
      "${self}/home"
      inputs.home-manager.nixosModule
    ];
  }
)
