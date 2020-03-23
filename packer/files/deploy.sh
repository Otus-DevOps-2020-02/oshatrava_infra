#! /bin/bash
set -e

# Deploy Reddit app
git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install
