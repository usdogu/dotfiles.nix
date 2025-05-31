{
  pkgs,
  lib,
  inputs,
  config,
  ...
}:
let
  cfg = config.dogu.editors;
in
{
  options.dogu.editors = {
    enable = lib.mkEnableOption "editors";
  };

  config = lib.mkIf cfg.enable {
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
          normal.space.o = "file_picker_in_current_buffer_directory";
          select = {
            "$" = "goto_line_end";
            G = "goto_last_line";
          };
        };
      };
      languages = {
        language-server = {
          vtsls = {
            command = lib.getExe pkgs.vtsls;
            args = [ "--stdio" ];
          };
          nixd = {
            command = lib.getExe pkgs.nixd;
            config.nixd =
              let
                flake = ''(builtins.getFlake "${inputs.self}")'';
              in
              {
                nixpkgs.expr = "import ${flake}.inputs.nixpkgs { }";
                options = rec {
                  flake-parts.expr = "${flake}.debug.options";
                  nixos.expr = "${flake}.nixosConfigurations.nebula.options";
                  nix-darwin.expr = "${flake}.darwinConfigurations.dou-mek.options";
                  home-manager.expr = "${nixos.expr}.home-manager.users.type.getSubOptions [ ]";
                };
              };
          };
          wakatime.command = lib.getExe (
            inputs.wakatime-ls.packages.${pkgs.system}.default.override {
              wakatime = pkgs.wakatime.overrideAttrs (_: {
                doCheck = false;
              });
            }
          );
          biome = {
            command = lib.getExe pkgs.biome;
            args = [ "lsp-proxy" ];
          };
          vscode-json-language-server = {
            command = lib.getExe' pkgs.vscode-langservers-extracted "vscode-json-language-server";
            args = [ "--stdio" ];
          };
          tailwindcss-ls = {
            command = lib.getExe pkgs.tailwindcss-language-server;
            args = [ "--stdio" ];
          };
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
            auto-format = true;
            language-servers = [
              {
                name = "vtsls";
                except-features = [ "format" ];
              }
              "biome"
              "wakatime"
            ];
          }
          {
            name = "javascript";
            auto-format = true;
            language-servers = [
              {
                name = "vtsls";
                except-features = [ "format" ];
              }
              "biome"
              "wakatime"
            ];
          }
          {
            name = "tsx";
            auto-format = true;
            language-servers = [
              {
                name = "vtsls";
                except-features = [ "format" ];
              }
              "biome"
              "tailwindcss-ls"
              "wakatime"
            ];
          }
          {
            name = "jsx";
            auto-format = true;
            language-servers = [
              {
                name = "vtsls";
                except-features = [ "format" ];
              }
              "biome"
              "tailwindcss-ls"
              "wakatime"
            ];
          }
          {
            name = "json";
            language-servers = [
              {
                name = "vscode-json-language-server";
                except-features = [ "format" ];
              }
              "biome"
            ];
          }
        ];
      };
    };
  };
}
