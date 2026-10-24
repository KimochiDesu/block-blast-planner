#!/usr/bin/env bash
# Installs or updates Block Blast Planner on an Ubuntu server using nginx.
# Usage: ./deploy/install-ubuntu.sh            (serves on port 8080)
#        PORT=80 ./deploy/install-ubuntu.sh    (pick another port)
set -euo pipefail

PORT="${PORT:-8080}"
SITE="block-blast-planner"
ROOT="/var/www/$SITE"
cd "$(dirname "$0")/.."

if ! command -v nginx >/dev/null; then
  sudo apt-get update
  sudo apt-get install -y nginx
fi

sudo mkdir -p "$ROOT"
sudo cp index.html "$ROOT/"

sudo tee "/etc/nginx/sites-available/$SITE" >/dev/null <<CONF
server {
    listen $PORT;
    listen [::]:$PORT;
    root $ROOT;
    index index.html;
    location / {
        try_files \$uri \$uri/ =404;
    }
}
CONF
sudo ln -sf "/etc/nginx/sites-available/$SITE" "/etc/nginx/sites-enabled/$SITE"
sudo nginx -t
sudo systemctl enable --now nginx
sudo systemctl reload nginx

if command -v ufw >/dev/null && sudo ufw status | grep -q "Status: active"; then
  sudo ufw allow "$PORT/tcp"
fi

echo "Block Blast Planner is up: http://$(hostname -I | awk '{print $1}'):$PORT"
