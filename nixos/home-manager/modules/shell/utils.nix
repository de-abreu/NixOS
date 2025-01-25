# INFO: A bunch of useful terminal applications
{pkgs, ...}: {
  home.packages = with pkgs; [
    bottom # Process monitor

    # Requirements to fetch and uncompress files
    curl
    gnutar
    gzip
    unzip
  ];
}
