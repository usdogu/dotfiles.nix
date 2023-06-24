{ lib, config, pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [ epkgs.vterm ];
  };
  services.emacs.enable = true;
  xdg.configFile."doom" = {
    source = ./configs/.doom.d;
    recursive = true;
  };

  # install doomemacs on activation of generation
  home.activation = {
    DoomEmacsAction = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      if [[ ! -d "${config.xdg.configHome}"/emacs ]]; then
        $DRY_RUN_CMD ${pkgs.git}/bin/git clone $VERBOSE_ARG --depth=1 --single-branch https://github.com/doomemacs/doomemacs.git "${config.xdg.configHome}"/emacs
        PATH=${pkgs.git}/bin:$PATH EMACS="${config.programs.emacs.finalPackage}"/bin/emacs $DRY_RUN_CMD "${config.xdg.configHome}"/emacs/bin/doom sync
      fi
    '';
  };

  programs.helix = {
    enable = true;
    settings = {
      theme = "gruvbox_dark_hard";
      editor = {
        lsp = {
          goto-reference-include-declaration = false;
          display-inlay-hints = true;
        };

        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };

        file-picker.hidden = false;
      };
      keys = {
        normal = {
          "0" = "goto_line_start";
          "$" = "goto_line_end";
          G = "goto_last_line";
          g = { G = "goto_last_line"; };
        };
        select = {
          "$" = "goto_line_end";
          G = "goto_last_line";
        };
      };
    };
  };

}
