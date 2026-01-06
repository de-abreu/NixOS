{
  importAll,
  pkgs,
  ...
}: {
  imports = importAll ./.;

  config.home.packages = with pkgs; [anki];
}
