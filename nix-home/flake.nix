{
  description = "Home Manager & System Graphics configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    system-manager = {
      url = "github:numtide/system-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-system-graphics = {
      url = "github:soupglasses/nix-system-graphics";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, home-manager, system-manager, nix-system-graphics, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in

    {
      systemConfigs.default = system-manager.lib.makeSystemConfig {
        modules = [
          nix-system-graphics.systemModules.default
          ({ config, ... }: {
            nixpkgs.hostPlatform = system;
            system-manager.allowAnyDistro = true;
            system-graphics.enable = true;
            system-graphics.enable32Bit = true;
          })
        ];
      };

      homeConfigurations."lampis-home" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
            modules = [
            ./home.nix
            ];
      };
    };
}
