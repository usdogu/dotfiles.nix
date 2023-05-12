inputs:

{
  nebula = inputs.self.lib.mkSystem {
    hostname = "nebula";
    system = "x86_64-linux";
    extraSpecialArgs.headless = false;
    home-manager = true;
  };

}
