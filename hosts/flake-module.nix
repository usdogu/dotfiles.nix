{ inputs, config, ... }:

let
  commonProfiles = with config.flake.nixosModules; [
    inputs.nix-monitored.nixosModules.default
    nix-nixpkgs
    ssh
    tailscale
    {
      programs.command-not-found.enable = false;
    }
  ];

  commonHome = [
    {
      home-manager = {
        useGlobalPkgs = true;
        extraSpecialArgs = {
          inherit inputs;
        };
        users.dogu = import ../home/dogu;
      };
    }
  ];
  nixosSystemWithDefaults =
    args:
    (inputs.nixpkgs.lib.nixosSystem (
      (builtins.removeAttrs args [ "hostName" ])
      // {
        specialArgs = {
          inherit inputs;
        } // args.specialArgs or { };
        modules = [

          ./${args.hostName}
          {
            networking = {
              inherit (args) hostName;
            };
          }
        ] ++ commonProfiles ++ (args.modules or [ ]);
      }
    ));

in
{
  flake.nixosConfigurations = {
    nebula = nixosSystemWithDefaults {
      system = "x86_64-linux";
      hostName = "nebula";
      modules = commonHome ++ [
        inputs.home-manager.nixosModule
        inputs.ragenix.nixosModules.age
        inputs.grub2-themes.nixosModules.default
        config.flake.nixosModules.xorg
        config.flake.nixosModules.netdata
      ];
    };
  };

  flake.darwinConfigurations = {
    dou-mek = inputs.darwin.lib.darwinSystem {
      specialArgs = {
        inherit inputs;
      };
      system = "aarch64-darwin";
      modules = commonHome ++ [
        inputs.home-manager.darwinModules.home-manager
        config.flake.nixosModules.nix-nixpkgs
        inputs.nix-monitored.darwinModules.default
        ./m1
      ];
    };

  };
}
