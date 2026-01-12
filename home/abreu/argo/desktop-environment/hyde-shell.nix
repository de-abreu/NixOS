# FIX: Uses interactive bash rather than the default-for-scripts minimal bash to
# launch hyde-shell with access to the compgen command
{
  pkgs,
  lib,
  ...
}: {
  home.file.".local/bin/hyde-shell" = lib.mkForce {
    source = with pkgs;
      writeShellScript "hyde-shell" ''
        export PYTHONPATH="${python-pyamdgpuinfo}/${python3.sitePackages}:$PYTHONPATH"
        exec ${bashInteractive}/bin/bash "${hyde}/Configs/.local/bin/hyde-shell" "$@"
      '';
    executable = true;
  };
}
