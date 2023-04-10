#!/bin/bash

# Define variables
github_user="404invalid-user"
ssh_file_path="$HOME/.ssh"
ssh_file_name="authorized_keys"

ssh_keys=$(curl -sSL "https://github.com/$github_user.keys")

if [ -n "$ssh_keys" ]; then
  if ! cmp -s <(echo "$ssh_keys") "$ssh_file_path/$ssh_file_name"; then
    echo "$ssh_keys" > "$ssh_file_path/$ssh_file_name"
    chmod 600 "$ssh_file_path/$ssh_file_name"
    echo "Keys updated pushed to file."
  fi
else
  echo "Failed to download SSH keys from GitHub not updating file."
fi
