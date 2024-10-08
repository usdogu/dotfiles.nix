{
  pkgs,
  lib,
  inputs,
  ...
}:
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
          g = {
            G = "goto_last_line";
          };
        };
        select = {
          "$" = "goto_line_end";
          G = "goto_last_line";
        };
      };
    };
    languages = {
      language-server = {
        vtsls = {
          command = lib.getExe inputs.self.packages.${pkgs.system}.vtsls;
          args = [ "--stdio" ];
        };
        nixd.command = lib.getExe pkgs.nixd;
        wakatime.command = lib.getExe inputs.wakatime-lsp.packages.${pkgs.system}.default;
      };
      language = [
        {
          name = "nix";
          auto-format = true;
          formatter = {
            command = lib.getExe pkgs.nixfmt-rfc-style;
            args = [ "-" ];
          };
          language-servers = [
            "nixd"
            "wakatime"
          ];
        }
        {
          name = "typescript";
          language-servers = [
            "vtsls"
            "wakatime"
          ];
        }
      ];
    };
  };

}
