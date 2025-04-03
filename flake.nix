{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    stylix.url = "github:danth/stylix/release-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprpanel = {
      url = "github:Jas-SinghFSU/HyprPanel";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
    system = "x86_64-linux";
    includeAll = with nixpkgs.lib; folder:
        fileset.fileFilter (file: hasSuffix "nix" file.name) folder
        |> fileset.toList;
    inheritance = {inherit inputs userPrefs includeAll;};
  in {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            inputs.hyprpanel.overlay
          ];
        };
        specialArgs = inheritance;
        modules = [
          ./nixos/system/configuration.nix
          stylix.nixosModules.stylix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              extraSpecialArgs = inheritance;
              sharedModules = with inputs; [
                  hyprpanel.homeManagerModules.hyprpanel
                  inputs.sops-nix.homeManagerModules.sops
              ];
              useGlobalPkgs = true;
              useUserPackages = true;
              users.user = import ./nixos/home-manager/home.nix;
              verbose = true;
            };
          }
        ];
      };
    };
  };
}
