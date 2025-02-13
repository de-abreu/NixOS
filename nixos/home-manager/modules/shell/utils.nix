# INFO: A bunch of useful terminal applications
{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      bottom # Process monitor
      comma # Run commands without having them installed, by prefixing it with a comma. A wrapper for nix shell -c and nix-index
      imagemagick # Image manipulation
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
  programs.fish.shellAbbrs.bottom = "btm";
}
