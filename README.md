# Nix Home Manager Setup for Ubuntu

This repository contains a Nix flake for setting up a development environment using Home Manager on Ubuntu.

## Prerequisites

1. Install Nix on your Ubuntu system:

```bash
sh <(curl -L https://nixos.org/nix/install) --daemon
```

2. Enable flakes by creating or adding to `~/.config/nix/nix.conf`:

```
experimental-features = nix-command flakes
```

3. Restart the Nix daemon:

```bash
sudo systemctl restart nix-daemon
```

## Installation

1. Clone this repository or create the `flake.nix` file in your desired directory:

```bash
mkdir -p ~/nix-config
cd ~/nix-config
# Copy the flake.nix file here
```

2. Edit the `flake.nix` file:
   - Replace `YOUR_USERNAME` with your actual username
   - Update Git name/email
   - Uncomment Zsh configuration if you use Zsh instead of Bash

3. Install Home Manager:

```bash
nix run home-manager/master -- init --switch
```

4. Apply the configuration:

```bash
nix build .#homeConfigurations.YOUR_USERNAME.activationPackage
./result/activate
```

Or, if you've added the suggested aliases in the flake.nix:

```bash
home-manager switch --flake .#
```

## Updating

To update your packages to the latest versions:

```bash
nix flake update
home-manager switch --flake .#
```

## Adding More Packages

To add more packages, edit the `home.packages` list in the `flake.nix` file. You can find available packages by searching the [Nixpkgs repository](https://search.nixos.org/packages).

## Troubleshooting

- If you get errors about missing packages, try updating your flake inputs:
  ```bash
  nix flake update
  ```

- If you encounter permission issues, ensure that Nix is properly installed and that your user has the correct permissions.

- For Ubuntu-specific issues, you might need to add your user to the `nix-users` group:
  ```bash
  sudo usermod -aG nix-users $USER
  ```

## Resources

- [Home Manager Manual](https://nix-community.github.io/home-manager/)
- [Nix Package Search](https://search.nixos.org/packages)
- [Nixpkgs Manual](https://nixos.org/manual/nixpkgs/stable/)
- [Nix Pills](https://nixos.org/guides/nix-pills/) - A tutorial series for Nix
