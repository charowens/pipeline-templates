# Create user

sudo echo "user:x:$UID_TO_SET:$UID_TO_SET::/home/user:" >> /etc/passwd
sudo echo "user:!:$(($(date +%s) / 60 / 60 / 24)):0:99999:7:::" >> /etc/shadow
sudo echo "user:x:$UID_TO_SET:" >> /etc/group
sudo mkdir /home/user && chown user: /home/user