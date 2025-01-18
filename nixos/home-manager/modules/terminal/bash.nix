{ ... }: {
  programs.bash = {
    enable = true;

    # INFO: Start the tty with bash but, upon detecting it is and interactive login shell, switch to fish. This allows for /etc/profile and /etc/profile.d to be properly sourced. Nore information in: https://wiki.archlinux.org/title/Fish
    bashrcExtra =
      # bash
      ''
        if [[ $(ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]; then
          shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION='''
          exec fish $LOGIN_OPTION
        fi
      '';
  };
}
