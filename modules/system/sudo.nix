# System-wide sudo configuration
{...}: {
  # Allow user sander to run all commands without password
  # Note: this is convenient but insecure; keep only if you accept the risk.
  security.sudo.extraRules = [
    {
      users = ["sander"];
      commands = [
        {
          command = "ALL";
          options = ["NOPASSWD"];
        }
      ];
    }
  ];
}
