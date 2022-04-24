{ self, ... } @ inputs: {
  nebula = self.lib.mkSystem "nebula" "x86_64-linux";
}
