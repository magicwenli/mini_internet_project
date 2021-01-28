#!/bin/bash
passwd=$(awk '$1 == "2" { print $0 }' /root/mini_internet_project/platform/groups/ssh_passwords.txt | cut -f 2 -d ' ')
readarray -t lines < $1
username=${lines[0]}
password=${lines[1]}
if [ "$username" == "group2" ] && [ "$password" == "$passwd" ]; then
exit 0
else
exit 1
fi
