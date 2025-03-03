{
  filter,
  pkgs,
  ...
}: {
  imports = filter ./modules;

  # General utility programs
  config = {
    home.packages = with pkgs; [
      comma # temporarily install programs to run commands
      imagemagick # Image manipulation
      lynx # terminal based browser
      pb_cli # Output to a pastebin
      renameutils # Batch file renaming utility
      ripgrep # search for text within various files
      sqlite

      # Requirements to fetch, compress, and uncompress files
      wget
      curl
      gnutar
      gzip
      unzip
      zip
    ];
  };
}
