{ ... }:

{
  programs.fish = {
    enable = true;
    shellAliases = {
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
        "s nix-collect-garbage -d --delete-older-than 1d; nix-collect-garbage -d; s nix-store --optimize; s nix-store --gc";
    };
    shellAbbrs = { sv = "sudo -e"; };
    shellInit = ''
      set -gx COLORTERM truecolor
      set -U fish_greeting
      starship init fish | source
      zoxide init --cmd cd fish | source
      # use GPG for SSH auth
      gpg-connect-agent /bye
      set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
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

  programs.atuin = {
    enable = true;
    flags = [ "--disable-up-arrow" ];
  };

  programs.tmux = {
    enable = true;
    tmuxinator.enable = true;
  };

  home.file.".tmux.conf".source = ./configs/tmux/.tmux.conf;
  home.file.".tmux.conf.local".source = ./configs/tmux/.tmux.conf.local;

}
