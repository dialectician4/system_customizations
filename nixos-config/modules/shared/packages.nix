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
  zstd
  gnupg
  hyperfine
  pre-commit
  difftastic

  # CUSTOM terminal workflow
  watchexec
  hyfetch
  zellij
  yazi
  mask
  just
  bottom
  iftop
  w3m
  eget
  btop
  coreutils
  # killall
  # openssh
  # sqlite

  # Media-related packages
  dejavu_fonts # ffmpeg
  font-awesome
  hack-font
  noto-fonts
  noto-fonts-color-emoji
  meslo-lgs-nf
  nerd-fonts.ubuntu
  nerd-fonts.jetbrains-mono
  jetbrains-mono

  # Language tools
  cmake
  clang-tools
  rustup
  bacon
  erlang
  rebar3
  gleam
  uv
  deno
  # bun
  go
  fnm
  # nodejs
  nodejs_26
  pnpm
  typescript
  tailwindcss_4
  # zig

  lazygit

  opencode
  gemini-cli
  claude-code
  mermaid-cli
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
