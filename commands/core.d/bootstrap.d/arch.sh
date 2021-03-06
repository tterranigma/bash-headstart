#!/usr/bin/env bash

distro_pacman="${distro_pacman:-sudo pacman -S --noconfirm}"

distro_packages+=(
  "python"
  "python-pip"
  "awk"
  'sed'
  'bash-completion'
)

pip_packages+=(
  # 'python-gilt'
  'git+git://github.com/nkakouros-forks/gilt@all'
)

info "checking required tools and libraries..."

$distro_pacman "${distro_packages[@]}"

info "installing Python 3 dependencies..."

sudo pip3 install "${pip_packages[@]}"
