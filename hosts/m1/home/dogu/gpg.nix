{ pkgs, ... }: {
  home.file.".gnupg/gpg-agent.conf".text = ''
    enable-ssh-support
    default-cache-ttl 43200
    default-cache-ttl-ssh 43200
    max-cache-ttl 8640000
    max-cache-ttl-ssh 8640000
    pinentry-program ${pkgs.pinentry_mac}/Applications/pinentry-mac.app/Contents/MacOS/pinentry-mac
  '';
}
