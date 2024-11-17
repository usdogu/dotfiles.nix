let
  systems = {
    nebula = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICg/G9iJ21vn8GpT+outepNOT79BGeRbcylspHG2dyF9";
    dou-mek = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMQ0TJzEK58B5Kc2DUmZqePp9vSFiEwNsSJx8I6S5Fpi";
  };
  users = {
    dogu = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL5IDmLOymXdnfTTPcYw8vrU3AeqCJeWGlP/mRmXNoA0";
  };
  allUsers = builtins.attrValues users;
  allSystems = builtins.attrValues systems;
in
{
  "tailscale-key.age".publicKeys = allSystems ++ allUsers;
}
