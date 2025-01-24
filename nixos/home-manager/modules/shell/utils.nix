# INFO: A bunch of useful terminal applications
{pkgs, ...}: {
  home.packages = with pkgs; [
    tree
    bottom # Process monitor
    curl

    # Requirements to fetch and uncompress files
    curl
    gnutar
    gzip
    unzip
  ];
}
