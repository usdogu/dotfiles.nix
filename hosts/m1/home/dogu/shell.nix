{
  programs.fish.interactiveShellInit = ''
    eval (/opt/homebrew/bin/brew shellenv)
  '';
  xdg.configFile."alacritty/alacritty.toml".text = ''
    [window]
    startup_mode = "Maximized"
    option_as_alt = "OnlyLeft"
    decorations = "Buttonless"

    [font]
    normal = { family = "Iosevka Nerd Font", style = "Regular"}
    size = 13
  '';
}
