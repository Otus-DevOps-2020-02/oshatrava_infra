#! /bin/bash
set -e

echo 'Creating reddit instance'
gcloud compute instances create reddit-app-full \
    --zone="europe-west1-b" \
    --boot-disk-size=15GB \
    --image reddit-full-1585006188 \
    --machine-type=f1-micro \
    --tags puma-server \
    --restart-on-failure
