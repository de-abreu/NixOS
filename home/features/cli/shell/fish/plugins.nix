{pkgs, ...}: {
  programs.fish.plugins =
    (map
      (plugin: {
        name = "${plugin}";
        inherit (pkgs.fishPlugins."${plugin}") src;
      }) [
        "autopair"
        "bang-bang"
        "colored-man-pages"
        "done"
        "fish-bd"
        "fish-you-should-use"
        "fzf-fish" # TODO: List fzf keybindings into a cheatsheet solution for the terminal
        "sponge"
      ])
    ++ [
      {
        name = "fish-ssh-agent";
        src = pkgs.fetchFromGitHub {
          owner = "danhper";
          repo = "fish-ssh-agent";
          rev = "f10d95775352931796fd17f54e6bf2f910163d1b";
          hash = "sha256-cFroQ7PSBZ5BhXzZEKTKHnEAuEu8W9rFrGZAb8vTgIE=";
        };
      }
    ];
}
