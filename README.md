# My NixOS Configuration

This repository contains my modular NixOS configuration, leveraging flakes, profiles, overlays, and `agenix` for secrets management.

## 📌 Choosing the Right Version: Stable vs. Unstable

It is strongly recommended to use a stable version for your system. The `main` branch is used for active development and may contain breaking changes.

| Channel  | Recommended for                               | How to Use                                                                                             |
| :------- | :-------------------------------------------- | :----------------------------------------------------------------------------------------------------- |
| 🐲 **Unstable** | Development, testing, and contributions       | `nix flake init -t github:Sander-Mirck/dotfiles`                                                       |
| ✅ **Stable**   | Daily use and reliable setups (Recommended) | See the options below.                                                                                 |

---

### Using a Stable Version

For a dependable experience, please use one of the following methods to initialize your configuration.

#### Option 1: Use a Specific Release (Recommended)

This command targets a named release, such as `laptop`.

```bash
# Initialize your flake from a release template
nix flake init -t github:Sander-Mirck/dotfiles#laptop
```

#### Option 2: Use a Specific Tag

Reference a specific version number for a point-in-time stable configuration.

```bash
# Initialize using a version tag
nix flake init -t github:Sander-Mirck/dotfiles/v0.3.2#laptop
```

#### Option 3: Pin to a Specific Commit

For ultimate stability, pin your configuration to a specific commit hash that you know is working.

```bash
# Initialize from a specific commit
nix flake init -t github:Sander-Mirck/dotfiles/<commit-hash>#laptop
```

## 📂 Repository Structure

The configuration is organized into the following directories:

-   `flake.nix`: The main entry point for the flake.
-   `hosts/`: Contains machine-specific configurations (e.g., `laptop`, `server`).
-   `profiles/`: Reusable sets of configurations for different use cases like "workstation" or "gaming".
-   `modules/`: Custom modules for NixOS and Home Manager.
-   `overlays/`: Overlays to customize or add packages.
-   `secrets/`: Encrypted secrets managed with `agenix`.
-   `templates/`: Pre-defined flake templates for easy setup of new hosts.

## 🚀 Usage

After initializing your configuration from a stable release or tag:

1.  **Navigate to your configuration directory.**
    ```bash
    cd /path/to/your/nixos-config
    ```

2.  **Apply the configuration.**
    Choose the appropriate host from your `flake.nix`.

    ```bash
    # For a laptop configuration
    sudo nixos-rebuild switch --flake .#laptop

    # For a server configuration
    sudo nixos-rebuild switch --flake .#server
    ```

## 릴 Releases

Key stable releases include:

-   **v0.3.2 "Plasma Stable"**: Introduced KDE Plasma 6 and included a major configuration cleanup.
-   **v0.3.1**: The first stable release with the current modular structure.
-   **v0.3.0**: The initial modular configuration.

For a complete list of versions and their changelogs, please visit the [**Releases Page**](https://github.com/Sander-Mirck/dotfiles/releases).
