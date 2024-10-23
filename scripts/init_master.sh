
export SSHPASS=gpadmin 
cat hostfile_exkeys | xargs -I {} sshpass -e ssh-copy-id {}
gpssh-exkeys -f hostfile_exkeys