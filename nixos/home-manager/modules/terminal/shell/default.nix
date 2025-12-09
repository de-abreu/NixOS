{
  includeAll,
  pkgs,
  ...
}: {
  imports = includeAll ./modules;

  # General utility programs
  config = {
    home.packages = with pkgs; [
      comma # temporarily install programs to run commands
      gdu # disk usage analyzer
      imagemagick # Image manipulation
      pb_cli # Output to a pastebin
      pdftk # Manipulate pdf files
      ripgrep # search for text within various files

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
