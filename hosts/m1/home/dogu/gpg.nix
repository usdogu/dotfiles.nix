{ pkgs, lib, ... }: {
  home.file = {
    ".gnupg/gpg-agent.conf".text = ''
      enable-ssh-support
      default-cache-ttl 43200
      default-cache-ttl-ssh 43200
      max-cache-ttl 8640000
      max-cache-ttl-ssh 8640000
      pinentry-program ${lib.getExe pkgs.pinentry_mac}
    '';
    ".gnupg/sshcontrol".text = ''
      310A8B8E991418079ABC4E97900A617A81B0121F
    '';
  };
  home.sessionVariablesExtra = ''
    export SSH_AUTH_SOCK="$(${pkgs.gnupg}/bin/gpgconf --list-dirs agent-ssh-socket)"
  '';
  programs.fish.interactiveShellInit = ''
    set -gx GPG_TTY (tty)
    ${pkgs.gnupg}/bin/gpg-connect-agent updatestartuptty /bye > /dev/null 2>&1
  '';
}
