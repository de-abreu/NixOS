# INFO: Hydenix desktop environment
{
  hydenix.hm = {
    enable = true;

    # Overrides to default values.
    editors = {
      vim = false;
      neovim = false;
      vscode.enable = false;
      default = "nvim";
    };
    fastfetch.enable = false;
    firefox.enable = false;
    git.enable = false;
    shell = {
      zsh.enable = false;
      bash.enable = true;
      fish.enable = true;
    };
    social.enable = false;
    spotify.enable = false;
    terminals.enable = false;
  };
}
