{ lib, pkgs, ... }:

{
  programs.helix = {
    enable = true;
    defaultEditor = true;
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
    languages = {
      language = with pkgs; [
        {
          name = "nix";
          language-server.command = lib.getExe' nixd "nixd";
          formatter.command = lib.getExe nixfmt;
        }
        {
          name = "rust";
          language-server.command = lib.getExe rust-analyzer;
          formatter.command = lib.getExe' rustfmt "rustfmt";
        }
        {
          name = "c";
          language-server = {
            command = lib.getExe' clang-tools "clangd";
            clangd.fallbackFlags = [ "-std=c++2b" ];
          };
        }
      ];
    };
  };

}
