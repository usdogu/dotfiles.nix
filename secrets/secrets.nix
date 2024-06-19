let
  systems = {
    nebula =
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK7ONHC8HZwDelLov+0WrZsJWJ/ZYc+L3wblatse7VX3";
  };
  users = {
    dogu =
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCgyP01oDXt4gx/6sAVNn0liI3XSTxMPCeGPkfxwAud5SmK4hw1sBIE+itBSidyaAHxd/1WYXjwC6X+7OdnaAh7d7ANs8WXO8/AkhxTfxZlhvCDPa0iKE3aM4R4q/CNLpFET+0WO2D6a1czdTrlZchw0FrnzgfH7kL5G4Epn3cE2gHNwKLlWaJa0HkpL5NCTHkkWe7JZCoAMZDeufzgGTZqy2e/w2nSU4rz3Yr6r2bI4vr48s2e8oSduJS0dTo2PC+2hcjj3KpSHS7HNedTLfFV6XyYyDAneGepYWdBP7WEhk7fJvC+rFAlIw/XlfxbraPCt3w4UB6BLd8rI8Y/5dWyQIAsaezM/jUpADlK2gmYn+lLMi1933r/FHg4wkgq3fHs18A48PbGwNo/YcDmKaC8oal3YEFvgICM5p6AA00ofzW3jaBpM97nuBzosLFb8kDi2VLaEvkCeUbVvbpGKgXN00MGUz0PvUjYETyBbqKF59C4KM48vMB6bMcFbkqgfU4HqfmUfwgakM5LDmhuM+1coHBm0HoTSgclMjo5HPFd2fYJEKOI1EEAMhnqWI6g91wOimzGuzZQEu0lICfNinvwjx6vAyWBcFO/xCqSawykQVdH5LB2o/9SEJEaNy/boUHn7WDBLn6JdbFyZYZPAHF2aTcQiMn94bbwMv+wRfTKHw==";
  };
  allUsers = builtins.attrValues users;
  allSystems = builtins.attrValues systems;
in
{ "tailscaleAuthKey.age".publicKeys = allUsers ++ allSystems; }
