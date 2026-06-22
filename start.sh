#!/usr/bin/env bash
# favico × Bitwarden — guided launcher (macOS / Linux). Installs Node if needed.
cd "$(dirname "$0")" || exit 1

install_node() {
  if command -v brew    >/dev/null 2>&1; then echo "Installing Node via Homebrew…";  brew install node; return $?; fi
  if command -v apt-get >/dev/null 2>&1; then echo "Installing Node via apt…";       sudo apt-get update && sudo apt-get install -y nodejs npm; return $?; fi
  if command -v dnf     >/dev/null 2>&1; then echo "Installing Node via dnf…";        sudo dnf install -y nodejs npm; return $?; fi
  if command -v pacman  >/dev/null 2>&1; then echo "Installing Node via pacman…";     sudo pacman -S --noconfirm nodejs npm; return $?; fi
  return 1
}

if ! command -v node >/dev/null 2>&1; then
  echo "Node.js is required but was not found."
  printf "Install Node.js now? [y/N] "
  read -r ans
  case "$ans" in
    y|Y)
      if ! install_node; then
        echo "No supported package manager found. Install Node.js from https://nodejs.org then run this again."
        exit 1
      fi
      ;;
    *)
      echo "Install Node.js from https://nodejs.org then run this again."
      exit 1
      ;;
  esac
fi

if ! command -v node >/dev/null 2>&1; then
  echo "Node still isn't on your PATH — open a new terminal and run ./start.sh again."
  exit 1
fi

exec node start.mjs "$@"
