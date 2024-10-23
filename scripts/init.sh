#!/bin/bash
sudo chown -R gpadmin:gpadmin /home/gpadmin/.ssh
sudo chown -R gpadmin:gpadmin /data
chmod -R 700 /home/gpadmin/.ssh
touch /home/gpadmin/.ssh/authorized_keys
chmod -R 600 /home/gpadmin/.ssh/authorized_keys
if [ ! -f /home/gpadmin/.ssh/id_rsa ]; then 
    ssh-keygen -t rsa -b 4096 -f /home/gpadmin/.ssh/id_rsa -N ""
fi
echo -e "Host *\n\tStrictHostKeyChecking no" > .ssh/config
sudo /usr/sbin/sshd -D -e
