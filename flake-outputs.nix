inputs @ {
  home-manager,
  nixpkgs,
  self,
  systems,
  ...
}:
with builtins; let
  inherit (self) outputs;
  lib = nixpkgs.lib // home-manager.lib;

  pkgsFor = lib.genAttrs (import systems) (
    system: import nixpkgs {inherit system;}
  );

  experimentalFeatures = ["nix-command" "flakes" "pipe-operators"];
in {
  inherit lib;
  nixosModules = import ./modules/nixos;
  overlays = import ./overlays {inherit inputs;};
  packages =
    import systems
    |> lib.foldl' (
      acc: system:
        acc
        // {
          ${system} = import ./shell.nix {pkgs = pkgsFor.${system};};
        }
    ) {};

  nixosConfigurations = with lib;
  with builtins;
    readDir ./hosts
    |> filterAttrs (key: value: key != "common" && value == "directory")
    |> attrNames
    |> foldl' (
      acc: hostname:
        acc
        // {
          "${hostname}" = nixosSystem {
            modules = [(./hosts + "/${hostname}")];
            specialArgs = {
              inherit inputs outputs experimentalFeatures;
            };
          };
        }
    ) {};

  homeConfigurations = {
    "user@nixos" = lib.homeManagerConfiguration {
      modules = [./home/user/nixos.nix];
      pkgs = pkgsFor.x86_64-linux;
      extraSpecialArgs = {
        inherit inputs outputs experimentalFeatures;
      };
    };
  };
}
