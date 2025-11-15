#!/usr/bin/env bash
set -e

echo "🔍 Running NixOS configuration health check..."

# Check formatting
echo "📝 Checking formatting..."
nix run .#formatter.x86_64-linux -- --check .

# Check for common issues
echo "🔧 Running statix..."
nix run github:nerdypepper/statix -- check .

# Find unused code
echo "🧹 Finding unused code..."
nix run github:astro/deadnix -- --fail .

# Evaluate configurations
echo "⚙️ Evaluating configurations..."
nix flake check --show-trace

# Build check
echo "🏗️ Testing builds..."
nix build .#nixosConfigurations.laptop.config.system.build.toplevel --no-link
nix build .#homeConfigurations.sander.activationPackage --no-link

echo "✅ All checks passed!"