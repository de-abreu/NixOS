{...}: {
  sops = {
    age.keyFile = "$XDG_CONFIG_HOME/sops/age/keys.txt";
    defaultSopsFile = ./sops.yaml;
  };
  systemd.user.services.mbsync.Unit.After = ["sops-nix.service"];
}
