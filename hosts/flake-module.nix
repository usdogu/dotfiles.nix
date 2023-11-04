{ inputs, ... }:

let
  commonProfiles = with inputs.self.nixosModules; [
    nix-nixpkgs
    ssh
    tailscale
    upgrade-diff
  ];

  commonHome = [
    inputs.home-manager.nixosModule
    {
      home-manager = {
        useGlobalPkgs = true;
        extraSpecialArgs = { inherit inputs; };
        users.dogu = import ../home/dogu;
      };
    }
  ];
  nixosSystemWithDefaults = args:
    (inputs.nixpkgs.lib.nixosSystem ((builtins.removeAttrs args [ "hostName" ])
      // ({
        specialArgs = { inherit inputs; } // args.specialArgs or { };
        modules = [
          ./${args.hostName}
          { networking = { inherit (args) hostName; }; }
        ] ++ commonProfiles ++ (args.modules or [ ]);
      })));

in {
  flake.nixosConfigurations = {
    nebula = nixosSystemWithDefaults {
      system = "x86_64-linux";
      hostName = "nebula";
      modules = commonHome ++ [
        inputs.ragenix.nixosModules.age
        inputs.grub2-themes.nixosModules.default
        inputs.self.nixosModules.xorg
      ];
    };
  };
}
