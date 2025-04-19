#!/usr/bin/env bash 

this_file_path() {
    echo $(dirname $(realpath -s $0))
}

define() { 
    IFS=$'\n' read -r -d '' ${1} || true; 
}

# Function definition for installing packages if they are missing or outdated
# Usage: install_if_missing <package1> [package2] ...
install_if_missing() {
  # Check if any package names were provided
  if [ $# -eq 0 ]; then
    echo "Usage: install_if_missing <package1> [package2] ..." >&2
    echo "Installs specified packages from official repositories only if they are not already installed and up-to-date." >&2
    return 1 # Return error code if no arguments given
  fi

  # List packages to be checked/installed
  echo "==> Checking/installing packages (if needed): $@"

  # Use pacman with '--needed' flag
  # --needed: Do not reinstall targets that are already up-to-date.
  # "$@": Expands arguments correctly, even if they contain spaces (though package names usually don't).
  # sudo: Required for installing packages system-wide.
  if sudo pacman -S --needed "$@"; then
    echo "==> Package check/installation process finished successfully."
    return 0 # Return success
  else
    local status=$?
    echo "==> Package check/installation process failed or was aborted (status: $status)." >&2
    return $status # Return the error code from pacman
  fi
}
