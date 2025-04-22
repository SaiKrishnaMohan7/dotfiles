#!/bin/zsh

function sshhhhMeDaddy() {
  echo "USAGE: sshhhhMeDaddy user ip_address; sshhhhMeDaddy papa_kancha 609.069.690.69"

  ssh "$1"@"$2"

  echo "Taking you there ;)"
}

function setupGitHubSSH() {
  local email="$1"
  local label="${2:-$(hostname)}"  # optional label for GitHub UI

  if [[ -z "$email" ]]; then
    echo "❌ Usage: setupGitHubSSH <email> [label]"
    echo "ex: setupGitHubSSH you@example.com 'Work Laptop'"
    return 1
  fi

  local key_path="$HOME/.ssh/id_ed25519_github"

  echo "🔐 Generating SSH key for GitHub at $key_path"
  ssh-keygen -t ed25519 -C "$email" -f "$key_path" -N ""

  echo "➕ Adding key to ssh-agent..."
  eval "$(ssh-agent -s)"
  ssh-add "$key_path"

  echo "📋 Here's your public key (copy this to GitHub):"
  echo ""
  cat "${key_path}.pub"
  echo ""

  echo "🌐 Opening GitHub SSH key settings..."
  open "https://github.com/settings/keys"

  echo "✅ Done! Name it: $label"
}
