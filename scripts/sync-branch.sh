#!/usr/bin/env bash

# A script to safely sync the current feature branch with the main branch
# after a squash-and-merge on GitHub.

set -e # Exit immediately if a command fails

MAIN_BRANCH="stable"
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

echo ">>> Syncing repository..."

# --- SAFETY CHECKS ---
if [[ -n $(git status --porcelain) ]]; then
  echo "❌ Error: Your working directory is not clean. Please commit or stash your changes."
  exit 1
fi

if [[ "$CURRENT_BRANCH" == "$MAIN_BRANCH" ]]; then
  echo ">>> Already on the main branch. Pulling latest changes..."
  git pull origin "$MAIN_BRANCH"
  echo "✅ Main branch '$MAIN_BRANCH' is up to date."
  exit 0
fi

# --- THE SYNC LOGIC ---
echo "1. Switching to '$MAIN_BRANCH' branch..."
git checkout "$MAIN_BRANCH"

echo "2. Pulling latest changes for '$MAIN_BRANCH'..."
git pull origin "$MAIN_BRANCH"

echo "3. Deleting old local feature branch '$CURRENT_BRANCH'..."
git branch -D "$CURRENT_BRANCH"

echo "4. Creating a fresh feature branch '$CURRENT_BRANCH' from '$MAIN_BRANCH'..."
git checkout -b "$CURRENT_BRANCH"

echo "5. Force-pushing to update remote feature branch..."
git push -u origin "$CURRENT_BRANCH" --force

echo "✅ Success! Your branch '$CURRENT_BRANCH' is now perfectly in sync with '$MAIN_BRANCH'."
