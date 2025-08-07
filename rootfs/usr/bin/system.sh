#!/bin/sh

COMMAND_NAME=$(basename "$0")

if [ "$COMMAND_NAME" = "adduser" ]; then
  if [ "$(id -u)" -ne 0 ]; then
    echo "Only root can create users"
    exit 1
  fi

  echo "Enter new username:"
  read username

  if grep -q "^$username:" /etc/passwd; then
    echo "User '$username' already exists."
    exit 1
  fi

  echo "Enter password for $username:"
  read -s password
  echo "Confirm password:"
  read -s password2

  if [ "$password" != "$password2" ]; then
    echo "Passwords do not match"
    exit 1
  fi

  # Create home directory
  mkdir -p /home/$username
  echo "Created /home/$username"

  # Get next UID
  next_uid=$(expr $(cut -d: -f3 /etc/passwd | sort -n | tail -n 1) + 1)

  # Hash password if possible, fallback to plain text
  if command -v openssl >/dev/null 2>&1; then
    hash=$(openssl passwd -1 "$password")
  elif command -v mkpasswd >/dev/null 2>&1; then
    hash=$(mkpasswd -m sha-512 "$password")
  else
    echo "No hashing tool found — storing password in plain text"
    hash="$password"
  fi

  # Add to passwd and shadow
  echo "$username:x:$next_uid:1000::/home/$username:/bin/sh" >> /etc/passwd
  echo "$username:$hash:0:0:99999:7:::" >> /etc/shadow

  chown $username:$username /home/$username 2>/dev/null || echo "Group doesn't exist yet"
  chmod 700 /home/$username

  echo "User '$username' created successfully"
fi