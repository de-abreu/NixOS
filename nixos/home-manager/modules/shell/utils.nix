# INFO: A bunch of useful terminal applications
{pkgs, ...}: {
  home.packages = with pkgs; [
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
}
