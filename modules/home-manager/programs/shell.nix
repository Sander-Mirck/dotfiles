# /modules/home-manager/programs/shell.nix
{
  config,
  pkgs,
  lib,
  ...
}:
{
  # Enable Starship and tell it to automatically configure Zsh.
  # This is all you need for the prompt.
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  # Configure the Zsh shell itself.
  programs.zsh = {
    enable = true;
    initExtra = ''
      export PATH="$HOME/.local/bin:$PATH"
    '';

    # The old 'initContent' block that loaded 'agnoster' has been completely removed.
    # Starship's integration replaces it.

    shellAliases = {
      gsync = ''
        ( \
          set -e; \
          MAIN_BRANCH="stable"; \
          CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD); \
          if [[ "$CURRENT_BRANCH" == "$MAIN_BRANCH" ]]; then \
            echo "Already on main branch. Pulling..."; \
            git pull origin "$MAIN_BRANCH"; \
          else \
            echo "Syncing '$CURRENT_BRANCH' with '$MAIN_BRANCH'..."; \
            git checkout "$MAIN_BRANCH"; \
            git pull origin "$MAIN_BRANCH"; \
            git branch -D "$CURRENT_BRANCH"; \
            git checkout -b "$CURRENT_BRANCH"; \
            git push -u origin "$CURRENT_BRANCH" --force; \
          fi; \
          echo "✅ Sync complete."; \
        )
      '';
    };

    # These plugins are still great to have!
    plugins = [
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.zsh-syntax-highlighting;
      }
      {
        name = "zsh-autosuggestions";
        src = pkgs.zsh-autosuggestions;
      }
    ];
  };

  # These tools integrate well with the shell.
  programs.fzf.enable = true;
  programs.bat.enable = true;
}
