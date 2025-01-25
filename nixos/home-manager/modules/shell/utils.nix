# INFO: A bunch of useful terminal applications
{pkgs, ...}: {
  home.packages = with pkgs; [
    bottom # Process monitor
    tig # Visual interface for git

    # Requirements to fetch, compress, and uncompress files
    curl
    gnutar
    gzip
    unzip
    zip
  ];
}
