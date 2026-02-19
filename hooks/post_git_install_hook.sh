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

git config --global merge.tool nvimdiff
git config --global diff.tool nvimdiff
