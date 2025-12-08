#!/usr/bin/bash

set -ouex pipefail

# Workaround: Rename just's CN readme to README.zh-cn.md
mv '/usr/share/doc/just/README.中文.md' '/usr/share/doc/just/README.zh-cn.md'

# Remove dnf5 versionlocks
dnf5 versionlock clear

# Fix cjk fonts
ln -s "/usr/share/fonts/google-noto-sans-cjk-fonts" "/usr/share/fonts/noto-cjk"

# Remove coprs
dnf5 -y copr remove ublue-os/staging
dnf5 -y copr remove ublue-os/packages

# Disable Negativo17 Fedora Multimedia
# This needs to be a whole organiztion change
# dnf5 config-manager setopt fedora-multimedia.enabled=0
