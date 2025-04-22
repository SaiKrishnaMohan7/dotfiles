#!/bin/zsh

manuallyPullYadm() {
  local yadm_repo="$HOME/.local/share/yadm/repo.git"
  if [[ -d "$yadm_repo" ]]; then
    cd "$yadm_repo" && git pull && cd ~
    echo "✅ yadm pulled successfully"
  else
    echo "❌ yadm repo not found at $yadm_repo"
  fi
}