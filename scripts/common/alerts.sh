# Alerts: ntfy (phone push) and Uptime Kuma, in Docker on this Mac via OrbStack.
#   startalerts   start OrbStack if needed, then both services
#   stopalerts    stop both
ALERTS_DIR="$HOME/projects/homelab/services/alerts"

startalerts() {
  if ! docker --context orbstack info >/dev/null 2>&1; then
    echo "starting OrbStack..."
    orb start || { echo "OrbStack didn't start"; return 1; }
  fi
  docker --context orbstack compose --project-directory "$ALERTS_DIR" up -d && \
    echo "ntfy: http://localhost:8090   uptime kuma: http://localhost:3001"
}

stopalerts() {
  docker --context orbstack compose --project-directory "$ALERTS_DIR" down
}
