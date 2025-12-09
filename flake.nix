{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix/release-25.05";
  };

  outputs = inputs @ {
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    sops-nix,
    stylix,
    ...
  }:
    with nixpkgs.lib; let
      userPrefs = {
        username = "user"; # As in the path "/home/user"
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
          extraSettings =
            map (elem: "LC_" + elem) [
              "ADDRESS"
              "IDENTIFICATION"
              "MEASUREMENT"
              "MONETARY"
              "NAME"
              "NUMERIC"
              "PAPER"
              "TELEPHONE"
              "TIME"
            ]
            |> foldl (acc: elem: {${elem} = "pt_BR.UTF-8";} // acc)
            {LC_TIME = "en_US.UTF-8";};
        };
        flakePath = "/home/user/.config/NixOS";
      };
      system = "x86_64-linux";
      includeAll = folder:
        fileset.fileFilter (file: hasSuffix "nix" file.name) folder
        |> fileset.toList;
      inheritance = {inherit inputs userPrefs includeAll;};
    in {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          pkgs = import nixpkgs {
            inherit system;
            overlays = [
              /*
              INFO: The following overlay allows for installing packages from
              the unstable branch by prefixing the name of the package with
              "unstable". i.e.: to install the unstable version of kanata, use:
              pkgs.unstable.kanata
              */
              (final: prev: {
                unstable = import nixpkgs-unstable {
                  system = prev.system;
                };
              })
            ];
          };
          specialArgs = inheritance;
          modules = [
            ./nixos/system/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                extraSpecialArgs = inheritance;
                useGlobalPkgs = true;
                useUserPackages = true;
                users.user = import ./nixos/home-manager/home.nix;
                verbose = true;
              };
            }
            sops-nix.nixosModules.sops
            stylix.nixosModules.stylix
          ];
        };
      };
    };
}
