# INFO: A bunch of useful terminal applications
{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      comma # Run commands without having them installed, by prefixing it with a comma. A wrapper for nix shell -c and nix-index
      imagemagick # Image manipulation
      bottom # Process monitor
      tig # Visual interface for git
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
  programs.fish.shellAbbrs.bottom = "btm";
}
