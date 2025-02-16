{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.dogu.shell;
in
{
  options.dogu.shell = {
    enable = lib.mkEnableOption "shell";
  };

  config = lib.mkIf cfg.enable {
    programs = {
      fish = {
        enable = true;
        shellAliases = {
          cls = "clear";
          ls = "lsd";
          la = "lsd -A";
          ll = "lsd -l";
          l = "lsd -Al";
          cat = "bat";
          rm = "rip";
          gc = "git clone";
          nix-cleanup = "home-manager expire-generations '-1 day'; s nix-collect-garbage -d; nix-collect-garbage -d; s nix-store --optimize";
          man = "batman";
          s = if pkgs.stdenv.isLinux then "doas" else "sudo";
        };
        shellAbbrs = {
          sv = "sudo -e";
        };
        shellInit = ''
          set -gx COLORTERM truecolor
          set -U fish_greeting
          source ~/.config/fish/functions/ls_on_cd.fish
          set ZELLIJ_AUTO_EXIT true
        '';
        functions = {
          gp = {
            description = "git {add,commit,push}";
            body = ''
              git add .
              git commit -m $argv
              git push
            '';
          };
          ls_on_cd = {
            description = "run ls on cd";
            onVariable = "PWD";
            body = ''
              ls
            '';
          };
        };
        plugins = with pkgs.fishPlugins; [
          {
            name = "puffer"; # github:nickeb96/puffer-fish
            inherit (puffer) src;
          }
          {
            name = "fzf.fish"; # github:PatrickF1/fzf.fish
            inherit (fzf-fish) src;
          }
          {
            name = "autopair"; # github:jorgebucaran/autopair.fish
            inherit (autopair) src;
          }
        ];
      };
      starship = {
        enable = true;
        settings = {
          add_newline = false;
          character = {
            error_symbol = "[✗](bold red) ";
          };
          package.disabled = true;
          git_branch = {
            symbol = "🌱 ";
            truncation_length = 4;
            truncation_symbol = "";
          };
          git_commit = {
            commit_hash_length = 4;
            tag_symbol = "🔖 ";
          };
          git_state = {
            format = "[($state( $progress_current of $progress_total))]($style) ";
            cherry_pick = "[🍒 PICKING](bold red)";
          };
          git_status = {
            conflicted = "🏳";
            ahead = "🏎💨";
            behind = "😰";
            diverged = "😵";
            untracked = "🤷";
            stashed = "📦";
            modified = "📝";
            staged = "[++($count)](green)";
            renamed = "👅";
            deleted = "🗑";
          };
          hostname = {
            ssh_only = true;
            format = "on [$hostname](bold red) ";
            trim_at = ".companyname.com";
            disabled = false;
          };
          line_break.disabled = false;
          memory_usage.disabled = true;
          time.disabled = true;
          username = {
            style_user = "white bold";
            style_root = "black bold";
            format = "[dogu]($style) ";
            disabled = false;
            show_always = true;
          };
          directory = {
            home_symbol = " ";
            read_only = "  ";
            style = "bold blue";
            truncation_length = 2;
            truncation_symbol = "./";
          };
        };

      };

      zellij = {
        enable = true;
        enableBashIntegration = false;
        enableZshIntegration = false;
        settings = {
          on_force_close = "quit";
          mouse_mode = false;
          copy_on_select = false;
          pane_frames = false;
          default_layout = "compact";
        };
      };

      zoxide = {
        enable = true;
        options = [ "--cmd cd" ];
      };

      direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
    };

    home.sessionPath = [
      "$HOME/.cargo/bin"
      "$HOME/bin"
      "$HOME/bin/zig"
      "$HOME/.local/bin"
    ];
  };
}
