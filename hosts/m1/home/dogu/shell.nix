{
  programs.fish.interactiveShellInit = ''
    eval (/opt/homebrew/bin/brew shellenv)
  '';
}
