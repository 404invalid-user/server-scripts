#!/bin/bash

# Define variables
github_users=("404invalid-user" "404invalid-user")

ssh_file_path="$HOME/.ssh"
ssh_file_name="authorized_keys"


# do not edit
keys=""

for github_user in "${github_users[@]}"; do
  user_ssh_keys=$(curl -sSL "https://github.com/$github_user.keys")

  if [ -n "$user_ssh_keys" ]; then
    keys="$keys\n\n# $github_user\n$user_ssh_keys"
  else
    echo "Failed to download SSH keys from GitHub for user $github_user."
  fi
done

[ -f "$ssh_file_path/$ssh_file_name" ] && rm "$ssh_file_path/$ssh_file_name"
printf "$keys" >"$ssh_file_path/$ssh_file_name"
