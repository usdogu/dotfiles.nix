{ ... }: {
  home-manager.users.dogu = {
    home.stateVersion = "23.05";
    services.vscode-server.enable = true;
  };
}
