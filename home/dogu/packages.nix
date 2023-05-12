{ pkgs, inputs, ... }:

let
  my-python-packages = python-packages:
    with python-packages; [
      requests
      beautifulsoup4
    ];
  python-with-my-packages = pkgs.python3.withPackages my-python-packages;
in {

  home.packages = with pkgs; [
    (dwm.overrideAttrs (oldAttrs: {
      src = pkgs.fetchFromGitHub {
        owner = "usdogu";
        repo = "dwm-dots";
        rev = "884e651663a75f26089a602720ca2802fa08cf5f";
        sha256 = "eVTXbDimzv2JMPXCyYhiQ5uWGW7tgkJtgsxgReE+Dcs=";
      };
    }))
    (st.overrideAttrs (oldAttrs: {
      src = pkgs.fetchFromGitea {
        domain = "codeberg.org";
        owner = "usdogu";
        repo = "st";
        rev = "f98f48b1d0ca2108bd7f9454e166a4fc325a32b3";
        sha256 = "07sac27j674w7ksvjigsj9zz92v1h5laviy776csa74rqg3pqd6n";
      };
      buildInputs = oldAttrs.buildInputs ++ (with super; [ harfbuzz glib gd ]);
    }))
    (dmenu.overrideAttrs (oldAttrs: {
      src = pkgs.fetchFromGitLab {
        owner = "dwt1";
        repo = "dmenu-distrotube";
        rev = "0ae13dbffc8d575ff14c6f1b312848ce9af64100";
        sha256 = "07ih21fk5hinjl9i6q45ikhiqldva9lqxzczasfk23aqg0538n4a";
      };
    }))
    ripgrep
    fd
    wget
    clang

    nil

    rustup
    lsd
    rm-improved
    zoxide
    gtk-engine-murrine
    spotify
    tealdeer
    gnutls
    gnumake

    #clojure things
    babashka

    #elixir things
    elixir
    elixir_ls
    rebar3
    inotify-tools

    python-with-my-packages
    inputs.self.packages."${pkgs.system}".nimblocks
    obs-studio
    flameshot
    file
    ps_mem
    killall
    pavucontrol
    mpv
    htop-vim
    xclip
    skim
    telegram-desktop
  ];
}
