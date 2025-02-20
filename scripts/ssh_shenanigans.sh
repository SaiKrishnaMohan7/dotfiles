#!/bin/bash

# Prompt user for email addresses
echo "🔹 Enter your PERSONAL GitHub email:"
read PERSONAL_EMAIL

echo "🔹 Enter your WORK GitHub email:"
read WORK_EMAIL

# Define paths for SSH keys
PERSONAL_SSH_DIR="$HOME/.ssh/personal"
WORK_SSH_DIR="$HOME/.ssh/work"

PERSONAL_KEY="$PERSONAL_SSH_DIR/id_ed25519"
WORK_KEY="$WORK_SSH_DIR/id_ed25519"

GITHUB_PERSONAL_ALIAS="gitp"
GITHUB_WORK_ALIAS="gitw"

# Ensure SSH directories exist
mkdir -p "$PERSONAL_SSH_DIR" "$WORK_SSH_DIR"

# Check if personal SSH key exists, generate if missing
if [[ ! -f "$PERSONAL_KEY" ]]; then
  echo "🔹 Generating a new personal SSH key..."
  ssh-keygen -t ed25519 -C "$PERSONAL_EMAIL" -f "$PERSONAL_KEY" -N ""
  echo "✅ Personal SSH key created: $PERSONAL_KEY"
fi

# Check if work SSH key exists, generate if missing
if [[ ! -f "$WORK_KEY" ]]; then
  echo "🔹 Generating a new work SSH key..."
  ssh-keygen -t ed25519 -C "$WORK_EMAIL" -f "$WORK_KEY" -N ""
  echo "✅ Work SSH key created: $WORK_KEY"
fi

# Ensure correct permissions
chmod 600 "$PERSONAL_KEY" "$WORK_KEY"         # only owner can read/write
chmod 644 "$PERSONAL_KEY.pub" "$WORK_KEY.pub" # owner can read/write, others can read

# Start SSH agent and add keys
echo "🔹 Starting SSH agent..."
eval "$(ssh-agent -s)"
ssh-add -D # Remove all keys from agent
ssh-add "$PERSONAL_KEY"
ssh-add "$WORK_KEY"

# Check SSH connection to GitHub
echo "🔹 Testing personal GitHub SSH connection..."
ssh -i "$PERSONAL_KEY" -T git@github.com 2>&1 | tee personal_ssh_test.log

echo "🔹 Testing work GitHub SSH connection..."
ssh -i "$WORK_KEY" -T git@github.com 2>&1 | tee work_ssh_test.log

# Check outputs
if grep -q "successfully authenticated" personal_ssh_test.log; then
  echo "✅ Personal SSH authentication to GitHub succeeded!"
else
  echo "❌ ERROR: Personal SSH authentication failed! Check ~/.ssh/config."
fi

if grep -q "successfully authenticated" work_ssh_test.log; then
  echo "✅ Work SSH authentication to GitHub succeeded!"
else
  echo "❌ ERROR: Work SSH authentication failed! Check ~/.ssh/config."
fi

# Ensure SSH config is properly set
SSH_CONFIG="$HOME/.ssh/config"

if ! grep -q "$GITHUB_PERSONAL_ALIAS" "$SSH_CONFIG"; then
  echo "🔹 Adding personal GitHub alias to SSH config..."
  cat <<EOL >>"$SSH_CONFIG"

Host $GITHUB_PERSONAL_ALIAS
    HostName github.com
    User git
    IdentityFile $PERSONAL_KEY
EOL
  echo "✅ Added $GITHUB_PERSONAL_ALIAS alias to SSH config."
fi

if ! grep -q "$GITHUB_WORK_ALIAS" "$SSH_CONFIG"; then
  echo "🔹 Adding work GitHub alias to SSH config..."
  cat <<EOL >>"$SSH_CONFIG"

Host $GITHUB_WORK_ALIAS
    HostName github.com
    User git
    IdentityFile $WORK_KEY
EOL
  echo "✅ Added $GITHUB_WORK_ALIAS alias to SSH config."
fi

# Final checks
echo "🔹 Final checks:"
echo "🔹 List of loaded SSH keys:"
ssh-add -l

echo "🔹 Checking Git remotes:"
git remote -v

echo "✅ Setup complete! Use the following commands to test SSH connections manually:"
echo "   ssh -T $GITHUB_PERSONAL_ALIAS"
echo "   ssh -T $GITHUB_WORK_ALIAS"
