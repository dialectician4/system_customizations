{ pkgs }:

with pkgs; [
  # aspell
  # aspellDicts.en
  # BASIC terminal utilities
  bash-completion
  zip
  wget
  bat
  lsd
  fzf
  fd
  ripgrep

  # CUSTOM terminal workflow
  watchexec
  hyfetch
  zellij
  yazi
  mask
  just
  bottom
  iftop
  # coreutils
  # killall
  # openssh
  # sqlite

  # Media-related packages
  dejavu_fonts # ffmpeg
  font-awesome
  hack-font
  noto-fonts
  noto-fonts-emoji
  meslo-lgs-nf
  nerd-fonts.ubuntu
  nerd-fonts.jetbrains-mono
  jetbrains-mono

  # Language tools
  rustup
  uv
  deno
  go
  fnm
  nodejs
  pnpm
  typescript

  # Text and terminal utilities
  # hunspell
  # jq
  # tree
  # unrar

  # Encryption and security tools
  # age
  # age-plugin-yubikey
  # gnupg
  # libfido2

  # Cloud-related tools and SDKs
  # docker
  # docker-compose

]
