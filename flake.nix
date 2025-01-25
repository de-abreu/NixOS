{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:danth/stylix/release-24.11";
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    stylix,
    ...
  }: let
    username = "user";
    filter = with nixpkgs.lib;
      folder:
        fileset.toList (fileset.fileFilter
          (file:
            hasSuffix "nix"
            file.name)
          folder);
  in {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./nixos/system/configuration.nix
          stylix.nixosModules.stylix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.verbose = true;
            home-manager.users.user = import ./nixos/home-manager/home.nix;
            home-manager.extraSpecialArgs = {inherit inputs filter username;};
          }
        ];
        specialArgs = {inherit inputs filter username;};
      };
    };
  };
}
