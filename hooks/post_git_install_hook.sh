#!/usr/bin/env bash
mkdir -p /home/jappe/.ssh
file=/home/jappe/.ssh/config
if ! [ -e "$file" ]; then
  touch "$file"
fi

cat > "$file" << EOF 
Host github.com
  AddKeystoAgent yes
  IdentitiesOnly yes
  IdentityFile /home/jappe/.ssh/github-ssh-key 
EOF

su - jappe -c 'git config --global merge.tool nvimdiff'
su - jappe -c 'git config --global diff.tool nvimdiff'
