inputs @ {
  nixpkgs,
  self,
  systems,
  ...
}:
with builtins; let
  inherit (self) outputs;
  lib = nixpkgs.lib;
  importAll = with lib;
    dir:
      builtins.readDir dir
      |> filterAttrs (name: type:
        type
        == "directory"
        || (hasSuffix ".nix" name && name != "default.nix"))
      |> attrNames
      |> map (name: dir + "/${name}");
  pkgsFor = lib.genAttrs (import systems) (
    system: import nixpkgs {inherit system;}
  );
  experimentalFeatures = ["nix-command" "flakes" "pipe-operators"];
in {
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

  nixosConfigurations.argo = lib.nixosSystem {
    modules = [./hosts/argo];
    specialArgs = {
      inherit inputs outputs importAll experimentalFeatures;
    };
  };
}
