{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
    shellAliases = {
      cd = "z";
      cls = "clear";
      s = "doas";
      ls = "lsd";
      la = "lsd -A";
      ll = "lsd -l";
      l = "lsd -Al";
      saat = "date '+%H:%M'";
      cat = "bat";
      rm = "rip";
      v = "nvim";
      gc = "git clone";
      nix-cleanup =
        "home-manager expire-generations '-1 day'; s nix-collect-garbage -d; nix-collect-garbage -d; s nix-store --optimize";
      man = "batman";
      devmux = "zellij --layout dev";
    };
    shellAbbrs = { sv = "sudo -e"; };
    shellInit = ''
      set -gx COLORTERM truecolor
      set -U fish_greeting
    '';
    functions = {
      cd = {
        description = "cd into a directory and ls";
        body = "builtin cd $argv && ls";
      };
      gp = {
        description = "git {add,commit,push}";
        body = ''
          git add .
          git commit -m $argv
          git push
        '';
      };
    };
    plugins = with pkgs.fishPlugins; [
      {
        name = "puffer"; # github:nickeb96/puffer-fish
        src = puffer.src;
      }
      {
        name = "fzf.fish"; # github:PatrickF1/fzf.fish
        src = fzf-fish.src;
      }
    ];
  };

  home.sessionPath =
    [ "$HOME/.cargo/bin" "$HOME/bin" "$HOME/bin/zig" "$HOME/.local/bin" ];

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      character = { error_symbol = "[✗](bold red) "; };
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

  programs.zellij = {
    enable = true;
    settings = {
      on_force_close = "quit";
      mouse_mode = false;
      copy_on_select = false;
      pane_frames = false;
      default_layout = "compact";
    };
  };

  xdg.configFile."zellij/layouts/dev.kdl".text = ''
    layout {
      tab name="edit" {
        pane command="hx"
        pane size=1 borderless=true {
          plugin location="zellij:compact-bar"
        }
      }
      tab name="run" {
        pane
        pane size=1 borderless=true {
          plugin location="zellij:compact-bar"
        }
      }
    }
  '';

  programs.alacritty = {
    enable = true;
    settings = {
      # gruvbox_dark
      colors = {
        primary = {
          background = "0x282828";
          foreground = "0xebdbb2";
        };
        normal = {
          black = "0x282828";
          red = "0xcc241d";
          green = "0x98971a";
          yellow = "0xd79921";
          blue = "0x458588";
          magenta = "0xb16286";
          cyan = "0x689d6a";
          white = "0xa89984";
        };
        bright = {
          black = "0x928374";
          red = "0xfb4934";
          green = "0xb8bb26";
          yellow = "0xfabd2f";
          blue = "0x83a598";
          magenta = "0xd3869b";
          cyan = "0x8ec07c";
          white = "0xebdbb2";
        };
      };

      font = {
        normal = {
          family = "Iosevka Nerd Font";
          style = "Regular";
        };
        bold = {
          family = "Iosevka Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "Iosevka Nerd Font";
          style = "Italic";
        };
        bold_italic = {
          family = "Iosevka Nerd Font";
          style = "Bold Italic";
        };
        size = 13;
      };
    };
  };

  programs.zoxide.enable = true;

  xdg.enable = true;
}
