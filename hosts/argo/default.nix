{inputs, config, ...}: {
  imports = [
    inputs.sops-nix.nixosModules.sops
    ./configuration.nix
    ../common
  ];

  sops = {
    defaultSopsFormat = "yaml";
    defaultSopsFile = "${inputs.self}/secrets/hosts/argo.yaml";
    secrets.root_password = { neededForUsers = true; };
  };

  users.users.root.hashedPasswordFile = config.sops.secrets.root_password.path;
}
