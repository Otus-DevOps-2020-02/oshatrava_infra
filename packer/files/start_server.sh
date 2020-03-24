#! /bin/bash
set -e

echo 'Added systemd config'
cat <<EOF > /etc/systemd/system/puma.service
[Unit]
Description=Puma HTTP server
After=network.target mongod.service

[Service]
User=olegshatrava
WorkingDirectory=/home/olegshatrava/reddit
ExecStart=/usr/local/bin/puma -d
RemainAfterExit=yes
Restart=always

[Install]
WantedBy=multi-user.target
EOF

echo 'Start puma service'
systemctl daemon-reload
systemctl enable puma.service
