{ config, lib, pkgs, ... }:

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
      tmux = "zellij";
    };
    shellAbbrs = { sv = "sudo -e"; };
    shellInit = ''
      set -gx PATH $PATH ~/.cargo/bin ~/bin/ ~/bin/zig ~/bin/zls ~/.local/bin ~/go/bin ~/.dotnet/tools ~/.nimble/bin
      set -U fish_greeting
      starship init fish | source
      zoxide init --cmd cd fish | source
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
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      character = {
        success_symbol =
          "[](bold green)[](bold yellow)[](bold red)[](bold purple)";
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
        ssh_only = false;
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

}
