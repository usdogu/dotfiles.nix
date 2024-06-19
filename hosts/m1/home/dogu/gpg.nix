{ pkgs, ... }: {
  home.file = {
    ".gnupg/gpg-agent.conf".text = ''
      enable-ssh-support
      default-cache-ttl 43200
      default-cache-ttl-ssh 43200
      max-cache-ttl 8640000
      max-cache-ttl-ssh 8640000
      pinentry-program ${pkgs.pinentry_mac}/Applications/pinentry-mac.app/Contents/MacOS/pinentry-mac
    '';
    ".gnupg/sshcontrol".text = ''
      310A8B8E991418079ABC4E97900A617A81B0121F
    '';
  };
  home.sessionVariablesExtra = ''
    if [[ -z "$SSH_AUTH_SOCK" ]]; then
      export SSH_AUTH_SOCK="$(${pkgs.gnupg}/bin/gpgconf --list-dirs agent-ssh-socket)"
    fi
  '';
}
