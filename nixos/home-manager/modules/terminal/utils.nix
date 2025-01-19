# INFO: A bunch of useful terminal applications
{pkgs, ...}: {
  home.packages = with pkgs; [
    tree
    trashy
    bottom # Process monitor
    curl
    wl-clipboard # Clipboard access
    neovim-remote # Prevent the recursive creation of nvim sessions

    # Requirements to fetch and uncompress files
    curl
    gnutar
    gzip
    unzip
  ];
}
