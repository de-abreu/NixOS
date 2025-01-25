{pkgs, ...}: {
  # TODO: Install the Mullvad browser as well, to replace Firefox
  home.packages = [pkgs.tor-browser];
}
