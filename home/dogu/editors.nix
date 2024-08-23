{ pkgs, lib, ... }:
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
      language-server = {
        typescript-language-server = with pkgs.nodePackages; {
          command = lib.getExe typescript-language-server;
          args = [ "--stdio" ];
        };
        nixd.command = lib.getExe pkgs.nixd;
      };
      language = [
        {
          name = "nix";
          formatter.command = lib.getExe pkgs.nixpkgs-fmt;
          language-servers = [ "nixd" ];
        }
      ];
    };
  };

}
