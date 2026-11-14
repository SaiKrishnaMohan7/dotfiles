# Alerts: ntfy (phone push) and Uptime Kuma, in Docker on this Mac.
#   startalerts   start Docker Desktop if needed, then both services
#   stopalerts    stop both
ALERTS_DIR="$HOME/projects/homelab/services/alerts"

startalerts() {
  if ! docker info >/dev/null 2>&1; then
    echo "starting Docker Desktop..."
    open -a Docker
    local i; for i in {1..60}; do docker info >/dev/null 2>&1 && break; sleep 2; done
    docker info >/dev/null 2>&1 || { echo "Docker didn't start"; return 1; }
  fi
  docker compose --project-directory "$ALERTS_DIR" up -d && \
    echo "ntfy: http://localhost:8090   uptime kuma: http://localhost:3001"
}

stopalerts() {
  docker compose --project-directory "$ALERTS_DIR" down
}
