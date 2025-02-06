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
    userPrefs = {
      username = "user"; # As seen in the path "/home/<user>"
      git = {
        userName = "Abreu";
        userEmail = "87032834+de-abreu@users.noreply.github.com";
        signingkey = "0xB655CB8F410F55B6";
      };
      keyboard = {
        layout = "br";
        variant = "";
      };
      locale = {
        default = "en_US.UTF-8";
        extraSettings = {
          LC_ADDRESS = "pt_BR.UTF-8";
          LC_IDENTIFICATION = "pt_BR.UTF-8";
          LC_MEASUREMENT = "pt_BR.UTF-8";
          LC_MONETARY = "pt_BR.UTF-8";
          LC_NAME = "pt_BR.UTF-8";
          LC_NUMERIC = "pt_BR.UTF-8";
          LC_PAPER = "pt_BR.UTF-8";
          LC_TELEPHONE = "pt_BR.UTF-8";
          LC_TIME = "en_US.UTF-8";
        };
      };
      flakePath = "/home/user/.config/NixOS";
    };
    filter = with nixpkgs.lib;
        folder: fileset.fileFilter (file: hasSuffix "nix" file.name) folder |> fileset.toList;
  in {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = {inherit inputs userPrefs filter;};
        modules = [
          ./nixos/system/configuration.nix
          stylix.nixosModules.stylix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              verbose = true;
              users.user = import ./nixos/home-manager/home.nix;
              extraSpecialArgs = specialArgs;
            };
          }
        ];
      };
    };
  };
}
