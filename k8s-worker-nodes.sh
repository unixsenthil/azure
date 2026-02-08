Prepare Kubernetes Worker nodes

#!/bin/bash

set -e

if [ -z "$ENVIRONMENT" ]; then
  echo "ERROR: ENVIRONMENT variable not set."
  echo "Usage: export ENVIRONMENT=dev"
  exit 1
fi

BASE="/mnt/sloopstash/${ENVIRONMENT}/aia"

echo "Creating persistent volume directories..."

sudo mkdir -p $BASE/redis/0/{data,log}
sudo mkdir -p $BASE/chroma/0/{data,log}
sudo mkdir -p $BASE/ollama/0/{model,data,log}
sudo mkdir -p $BASE/app/log
sudo mkdir -p $BASE/nginx/log

echo "Setting permissions..."
sudo chmod -R ugo+rwx /mnt/sloopstash

APP_PATH="/opt/sloopstash-aia-app"

if [ ! -d "$APP_PATH" ]; then
  echo "Cloning repository..."
  sudo git clone https://github.com/sloopstash/sloopstash-aia-app.git "$APP_PATH"
else
  echo "Repository already exists. Skipping clone."
fi

echo "Fixing permissions..."
sudo chown -R $USER:$USER "$APP_PATH"

echo "Setup completed successfully!"
