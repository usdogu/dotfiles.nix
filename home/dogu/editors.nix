{ ... }:

{
    programs.emacs = {
    enable = true;
    extraPackages = epkgs: [ epkgs.vterm ];
  };
  services.emacs.enable = true;
  # home.file = {
  #   doomd = {
  #     source = configs/.doom.d;
  #     target = "/home/dogu/.doom.d";
  #     recursive = true;
  #   };
  # };
  home.file.".doom.d" = {
    source = ./configs/.doom.d;
    recursive = true;
  };
  programs.helix = {
    enable = true;
    settings = {
      theme = "gruvbox_dark_hard";
      editor = {
        lsp.display-inlay-hints = true;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
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
