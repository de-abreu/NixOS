{...}: {
  programs = {
    bat.enable = true;
    fish.shellAbbrs.cat = "bat -pP";
  };

  # INFO: Modify key mappings
  home.file.".lesskey".text = ''
    j invalid
    k forw-line
    l back-line
  '';
}
