# INFO: A bunch of useful terminal applications without any configuration
{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      bottom # Process monitor
      # temporarily install programs to run their commands, by prefixing the
      # commands with a comma.  A wrapper for nix shell -c and nix-index.
      comma
      imagemagick # Image manipulation
      playerctl # Command-line utility to control media players
      ripgrep # search for text within various files
      tig # Visual interface for git

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
