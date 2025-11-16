# modules/home-manager/programs/shell.nix
{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs.zsh = {
    enable = true;

    # Add your new alias here
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

    initContent = ''
      autoload -Uz promptinit
      promptinit
      prompt agnoster
    '';

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

  programs.fzf.enable = true;
  programs.bat.enable = true;
}
