# Agent bridge: lets Claude on another machine reach this Mac's vault and
# 1Password (Touch ID per secret). See homelab/agent-tools/bridge/README.md.
#   startwork [host] [user]   bring up the bridge daemon and the SSH tunnel
#   stopwork                  take both down
#   workstatus                show what's running and whether the far side sees it

AGENT_BRIDGE_DIR="$HOME/.agent-bridge"
AGENT_HOST_DEFAULT="samsung"
AGENT_USER_DEFAULT="claude"

startwork() {
  local host="${1:-$AGENT_HOST_DEFAULT}" user="${2:-$AGENT_USER_DEFAULT}"
  local dir="$AGENT_BRIDGE_DIR"

  # 1. The daemon, unless it's already up.
  if _agent_alive daemon; then
    echo "bridge: already running (pid $(<"$dir/daemon.pid"))"
  else
    nohup "$dir/bin/bridge" serve >>"$dir/daemon.log" 2>&1 &
    echo $! >"$dir/daemon.pid"
    # Wait up to 5s for the socket to appear.
    local i
    for i in {1..10}; do [[ -S "$dir/bridge.sock" ]] && break; sleep 0.5; done
    [[ -S "$dir/bridge.sock" ]] || { echo "bridge: didn't start, see $dir/daemon.log"; return 1; }
    echo "bridge: up"
  fi

  # 2. The tunnel to the agent machine.
  if _agent_alive tunnel; then
    echo "tunnel: already up (pid $(<"$dir/tunnel.pid"))"
  else
    nohup "$dir/bin/tunnel.sh" "$host" "$user" >>"$dir/tunnel.log" 2>&1 &
    echo $! >"$dir/tunnel.pid"
    sleep 2
    _agent_alive tunnel || { echo "tunnel: didn't come up, see $dir/tunnel.log"; return 1; }
    echo "tunnel: up to $user@$host"
  fi

  # 3. Proof from the far side.
  if ssh -o ConnectTimeout=5 "$user@$host" '~/.local/bin/bridge ping' >/dev/null 2>&1; then
    echo "ready: $user@$host can reach the bridge"
    echo "connect: ssh -t $user@$host 'cd ~/projects/ardan-labs && bash -lc claude'"
  else
    echo "warning: $user@$host can't reach the bridge yet; try workstatus in a moment"
  fi
}

stopwork() {
  local name
  for name in tunnel daemon; do
    if _agent_alive "$name"; then
      kill "$(<"$AGENT_BRIDGE_DIR/$name.pid")" && echo "$name: stopped"
    else
      echo "$name: wasn't running"
    fi
    rm -f "$AGENT_BRIDGE_DIR/$name.pid"
  done
}

workstatus() {
  local host="${1:-$AGENT_HOST_DEFAULT}" user="${2:-$AGENT_USER_DEFAULT}" name
  for name in daemon tunnel; do
    if _agent_alive "$name"; then echo "$name: up (pid $(<"$AGENT_BRIDGE_DIR/$name.pid"))"
    else echo "$name: down"; fi
  done
  ssh -o ConnectTimeout=5 "$user@$host" '~/.local/bin/bridge ping' >/dev/null 2>&1 \
    && echo "$user@$host: reaches the bridge" || echo "$user@$host: can't reach the bridge"
}

# True if the process in $AGENT_BRIDGE_DIR/<name>.pid is still running.
_agent_alive() {
  local pidfile="$AGENT_BRIDGE_DIR/$1.pid"
  [[ -f "$pidfile" ]] && kill -0 "$(<"$pidfile")" 2>/dev/null
}
