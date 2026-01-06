{
  inputs,
  config,
  ...
}: {
  imports = [
    ../../features
    ./desktop-environment
    ./git.nix
    inputs.hydenix.homeModules.default
    inputs.sops-nix.homeManagerModules.sops
    inputs.stylix.homeModules.stylix
  ];

  home = {
    username = "abreu";
    homeDirectory = "/home/${config.home.username}";
  };

  sops = {
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
    defaultSopsFile = "${inputs.self}/secrets/users/abreu.yaml";
    secrets = {
      "api-keys/deepseek" = {};
      "api-keys/tavily" = {};
    };
  };
}
