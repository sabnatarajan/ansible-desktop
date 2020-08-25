#!/bin/sh

main() {
  detect_os
  if [[ $OS == "Unknown" ]]; then
    echo "Cannot detect OS"
    exit 1
  fi

  case $OS in 
    "Arch Linux")
      install_arch;;
    Debian)
      install_debian;;
  esac
}

detect_os() {
  if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$NAME
  elif type lsb_release > /dev/null 2>&1; then
    OS=$(lsb_release -si)
  elif [ -f /etc/debian_version ]; then
    OS=Debian
  else 
    echo "Unknown"
  fi
}

install_arch() {
  sudo pacman -Syy
  sudo pacman -S \
    git \
    curl \
    ansible
}

install_debian() {
  sudo apt update
  sudo apt install \
    git \
    curl \
    software-properties-common
  sudo apt-add-repository --yes --update ppa:ansible/ansible
  sudo apt install ansible
}

main "$@"
