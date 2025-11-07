# Security Policy

## Security Considerations for this Configuration

This NixOS configuration repository is designed with security in mind, but there are important considerations when using or adapting it:

### Security Features Enabled

- System firewall is enabled by default
- GNOME Keyring for secure credential storage
- GPG agent with security-focused preferences
- Automatic security updates (recommended but not enforced by default)
- Screen locking after inactivity
- Improved system entropy with haveged

### Information in this Repository

This repository contains:
- System configuration (packages, services, settings)
- User environment configuration
- Public system settings (no secrets, passwords, or API keys)

This repository does NOT contain:
- Passwords or authentication credentials
- API keys or tokens
- SSH private keys
- GPG private keys
- Personal financial information
- Private network information (beyond general VPN configuration)

### System-specific Information

The `hosts/nixos/hardware-configuration.nix` file contains system-specific information:
- Disk UUIDs
- Hardware-specific kernel modules
- Network interface names

This information is not sensitive in itself but is specific to the original hardware setup.

### Recommended Security Practices

1. **Before using this configuration on your own system:**
   - Change all personal information (name, email) to your own
   - Update any SSH/GPG keys that might be configured
   - Review and adjust firewall rules as needed

2. **For your own deployment:**
   - Use tools like sops-nix or agenix for managing secrets
   - Set strong passwords after first boot
   - Regularly update the system with security patches
   - Consider enabling automatic security updates

### Responsible Disclosure

If you believe you've found a security vulnerability in this configuration that affects the general approach or common use cases, please open an issue. However, keep in mind that this is a personal configuration that may not be appropriate for all use cases.

### Contact

For security-related questions about this configuration, please open an issue in the repository.