{
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = [pkgs.kanata];

  # Enable the uinput module
  boot.kernelModules = ["uinput"];

  # Enable uinput
  hardware.uinput.enable = true;

  # Set up udev rules for uinput
  services.udev.extraRules = ''
    KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
  '';

  # Ensure the uinput group exists
  users.groups.uinput = {};

  # Add the Kanata service user to necessary groups
  systemd.services.kanata-internalKeyboard.serviceConfig = {
    SupplementaryGroups = [
      "input"
      "uinput"
    ];
  };

  services.kanata = {
    enable = true;
    keyboards = {
      internalKeyboard = {
        devices = [
          # Replace the paths below with the appropriate device paths for your setup.
          # Use `ls /dev/input/by-path/` to find your keyboard devices.
          "/dev/input/by-path/platform-i8042-serio-0-event-kbd"
        ];
        extraDefCfg = "process-unmapped-keys yes";
        config = with lib; let
          # Disable numkeys
          numkeys =
            range 0 9
            |> foldl (acc: elem: acc + "kp${toString elem} XX\n") "";
        in
          # commonlisp
          ''
            (deflocalkeys-linux
             ç 39
            )

            (defsrc
             esc caps tab j k l ç
            )

            (defvar
             tap-timeout 200
             hold-timeout 200
             tt $tap-timeout
             ht $hold-timeout
            )

            (defalias
             esctrl (tap-hold $tt $ht esc lctl)
             tab (tap-hold $tt $ht tab (layer-toggle nav))
            )

            (deflayermap (base)
              esc caps
              caps @esctrl
              tab @tab
              ${numkeys}
            )

            (deflayermap (nav) ;; Navigation
              j left
              k down
              l up
              ç right
              u pgup
              d pgdn
              g home
              b end ;; "bottom"
            )
          '';
      };
    };
  };
}
