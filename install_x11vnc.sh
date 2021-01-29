#!/bin/bash

# run this script as root (use sudo, Luke) 
# sudo ./install_x11vnc.sh yourpasswordhere

yes | apt-get install x11vnc
x11vnc -storepasswd "$1" /home/user/.vnc/passwd

echo """[Unit]
Description="x11vnc"
Requires=display-manager.service
After=display-manager.service

[Service)
Execstart=/usr/bin/x11vnc -xkb -noxrecord -noxfixes -noxdamage -display :0 -auth guess -fbauth /home/user/.vnc/passwd
Execstop=/usr/bin/killall x11vnc
Restart=on-failure
Restart-sec=2

[Install]
WantedBy=multi-user.target""" > /etc/systemd/system/x11vnc.service

systemctl daemon-reload
systemctl enable x11vnc.service
systemctl start x11vnc.service
