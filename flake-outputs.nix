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
  overlays = import ./overlays {inherit inputs;};
  devShells =
    import systems
    |> lib.foldl' (
      acc: system:
        acc
        // {
          ${system} = import ./shell.nix {pkgs = pkgsFor.${system};};
        }
    ) {};

  nixosConfigurations.argo = with lib;
    nixosSystem {
      pkgs = pkgsFor.x86_64-linux;
      modules = [./hosts/argo];
      specialArgs = {
        inherit inputs outputs experimentalFeatures;
      };
    };
}
