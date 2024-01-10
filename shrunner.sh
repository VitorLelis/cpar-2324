#!/bin/bash

#Set username and password as variables
username="pg54273"
password="dof7Ga1Z"

#Set the destination folder on the remote server
destination_folder="entrega3"

#Clear the contents of the destination folder on the remote server
sshpass -p "$password" ssh "$username"@s7edu.di.uminho.pt "rm -rf ~/$destination_folder/*"

#Copy the contents of the current folder to the remote server
rsync -avz -e "sshpass -p '$password' ssh" ./ "$username"@s7edu.di.uminho.pt:~/$destination_folder/

#SSH into the remote server and execute the desired commands
sshpass -p "$password" ssh "$username"@s7edu.di.uminho.pt << EOF
cd ~/$destination_folder/
make clean
make
sbatch --partition=cpar --cpus-per-task=40 -W runner.sh
EOF

ssh pg4..
cd ..