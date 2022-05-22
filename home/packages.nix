{ config, pkgs, inputs, ... }:

let
  my-python-packages = python-packages:
    with python-packages; [
      requests
      beautifulsoup4
    ];
  python-with-my-packages = pkgs.python3.withPackages my-python-packages;

in
{

  home.packages = with pkgs; [
    (dwm.overrideAttrs (oldAttrs: rec {
      src = fetchTarball {
        url = "https://github.com/usdogu/dwm-dots/archive/main.tar.gz";
        sha256 = "1965f93xhr8ql7p0p63m6hp6ca3585w7jlhzkbq8sahqvn1xvqi5";
      };
    }))
    (st.overrideAttrs (oldAttrs: rec {
      src = fetchTarball {
        url = "https://github.com/siduck/st/archive/main.tar.gz";
        sha256 = "0qp17h2i0b4wcfvciayacfnbazsm2jfpq4d3qw4kxlhgl77201rc";
      };
      buildInputs = oldAttrs.buildInputs ++ (with super; [ harfbuzz ]);
    }))
    (dmenu.overrideAttrs (oldAttrs: rec {
      src = fetchTarball {
        url =
          "https://gitlab.com/dwt1/dmenu-distrotube/-/archive/master/dmenu-distrotube-master.tar.gz";
        sha256 = "07ih21fk5hinjl9i6q45ikhiqldva9lqxzczasfk23aqg0538n4a";
      };
    }))
    neovim
    ripgrep
    coreutils
    fd
    wget
    clang
    nixfmt
    rustup
    go
    nim
    zig
    lsd
    rm-improved
    bat
    zellij
    sqlite
    zoxide
    lxappearance
    gruvbox-dark-gtk
    capitaine-cursors
    gtk-engine-murrine
    discord
    pkg-config
    vscode
    spotify
    gnumake
    tealdeer
    gnutls
    nodePackages.bash-language-server
    gopls
    gnumake
    rust-analyzer
    zathura
    #clojure things
    leiningen
    clojure-lsp
    clj-kondo
    babashka
    adoptopenjdk-bin

    #elixir things
    elixir
    elixir_ls
    rebar3
    inotify-tools

    python-with-my-packages
    nodejs-16_x
    pcmanfm
    mu
    isync
    rnix-lsp
    (callPackage ./nimblocks.nix { })
    scrot
  ];
}
