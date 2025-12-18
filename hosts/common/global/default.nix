{lib, ...}: {
  imports = with lib;
    fileset.fileFilter (
      file:
        hasSuffix "nix" file.name
        && file.name != "default.nix"
    )
    ./.
    |> fileset.toList;
}
