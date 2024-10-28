{ lib, config, ... }:
let
  cfg = config.dogu.zathura;
in
{
  options.dogu.zathura = {
    enable = lib.mkEnableOption "zathura";
  };

  config = lib.mkIf cfg.enable {
    programs = {
      zathura = {
        enable = true;
        extraConfig = ''
          set selection-clipboard clipboard
          set window-title-home-tilde true
          set statusbar-home-tilde true
          set page-padding 1

          set font "monospace normal 16"
          set window-height 1024
          set window-width 768
          set render-loading false
          set adjust-open "best-fit"
          # Fix following links(!)
          set sandbox none

          # Navigation
          map u scroll half-up
          map d scroll half-down
          map D toggle_page_mode
          map <C-u> navigate previous
          map <C-d> navigate next

          map r reload
          map R rotate
          map i recolor
          map p print

          map K zoom in
          map J zoom out

          # stop at page boundaries
          set scroll-page-aware true
          set scroll-full-overlap 0.01
          set scroll-step 50
          set incremental-search true
          set guioptions ""
          map b toggle_statusbar

          map [normal] ZZ quit
          map [normal] ZQ quit

          set recolor      true
          set recolor-keephue    true

          # Base16 Gruvbox
          set notification-error-bg       "#282828" # bg
          set notification-error-fg       "#fb4934" # bright:red
          set notification-warning-bg     "#282828" # bg
          set notification-warning-fg     "#fabd2f" # bright:yellow
          set notification-bg             "#282828" # bg
          set notification-fg             "#b8bb26" # bright:green

          set completion-bg               "#504945" # bg2
          set completion-fg               "#ebdbb2" # fg
          set completion-group-bg         "#3c3836" # bg1
          set completion-group-fg         "#928374" # gray
          set completion-highlight-bg     "#83a598" # bright:blue
          set completion-highlight-fg     "#504945" # bg2

          # Define the color in index mode
          set index-bg                    "#504945" # bg2
          set index-fg                    "#ebdbb2" # fg
          set index-active-bg             "#83a598" # bright:blue
          set index-active-fg             "#504945" # bg2

          set inputbar-bg                 "#282828" # bg
          set inputbar-fg                 "#ebdbb2" # fg

          set statusbar-bg                "#504945" # bg2
          set statusbar-fg                "#ebdbb2" # fg

          set highlight-color             "#fabd2f" # bright:yellow
          set highlight-active-color      "#fe8019" # bright:orange

          # set default-bg                  "#282828" # bg
          set default-bg             rgba(40,40,40,0.7) # bg
          set default-fg                  "#ebdbb2" # fg
          set render-loading              true
          set render-loading-bg           "#282828" # bg
          set render-loading-fg           "#ebdbb2" # fg
          # Recolor book content's color
          # set recolor-lightcolor          "#282828" # bg
          set recolor-lightcolor    rgba(40,40,40,0.0) # bg(transparent)
          set recolor-darkcolor           "#ebdbb2" # fg
        '';
      };
    };
  };
}
