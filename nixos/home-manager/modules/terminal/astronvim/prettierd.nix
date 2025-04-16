{...}: {
  home = {
    sessionVariables.PRETTIERD_DEFAULT_CONFIG = "~/.prettierrc.toml";
    file.".prettierrc.toml".text =
      # toml
      ''
        proseWrap = "always"
      '';
  };
}
