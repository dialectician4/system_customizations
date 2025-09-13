{
  description = "Home Manager configuration";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixgl.url = "github:nix-community/nixGL";
  };

  outputs = { nixpkgs, home-manager, nixgl, ... }:
    let
      system = "x86_64-linux";  # Architecture for Ubuntu desktop
      pkgs = import nixpkgs {
        system = "x86_64-linux";
	config = {
	  allowUnfree = true;
	  allowUnfreePredicate = _: true;
        };
      };
      #nixpkgs.legacyPackages.${system};
      username = "edwin";  # Replace with your actual username
      overlays = [nixgl.overlay];
    in {
      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        
        # Specify path to your home configuration
        modules = [
          {
	    nixpkgs.config.allowUnfreePredicate = (pkg: true);
            home = {
              username = username;
              homeDirectory = "/home/${username}";
              stateVersion = "23.11";  # Update if needed to match your nixpkgs version
              sessionVariables = {
                CAT = "Mia";
              };
              
              # Packages to install
              packages = with pkgs; [
                # CORE
                git
                curl
                openssh
                wget
                htop
		unixtools.nettools
		nerd-fonts.ubuntu
		nerd-fonts.jetbrains-mono
		ocs-url
		# gnumake
		gcc
		unzip
		xclip
                ripgrep

                # Terminal Custom
                lsd
                bat
                fzf
                jq
		yazi
                just
                mask
		hyfetch
		bottom
                zellij
                slumber
                
                # Languages
                rustup
		# cargo
                fnm
                uv
		go
                deno
                nodejs
                rusty-man
                typescript
                # typescript-language-server

		# Desktop Packages
		# plasma5Packages.kdeconnect-kde
		obsidian
		spotify
		# flatpak
		syncthing
		syncthingtray
                vlc
		# google-chrome-stable
                # vscode
		nixgl

                # work - testing
                autoconf
                automake
                # libtool
                pkg-config
                gawk
              ];
            };
            
            # Enable Home Manager    git push --set-upstream origin restructure
            programs.home-manager.enable = true;

	    # Configs
	    xdg.configFile."wezterm".source = (builtins.path { path = ./wezterm; name = "wezterm"; });
	    xdg.configFile."wezterm".recursive = true;
	    # xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink (builtins.toPath ./nvim); #(builtins.path { path = ./nvim; name = "nvim"; });
	    # xdg.configFile."nvim".recursive = true;

	    # allowUnfree = true;
	    fonts.fontconfig.enable = true;

            # Neovim configuration
            programs.neovim = {
              enable = true;
              defaultEditor = true;
              viAlias = true;
              vimAlias = true;
              plugins = with pkgs.vimPlugins; [
                #vim-nix
                #nvim-treesitter
                #telescope-nvim
                #lualine-nvim
                #which-key-nvim
              ];
            };
            
            # Git configuration
            programs.git = {
              enable = true;
              userName = "dialectician4";  # Replace with your name
              userEmail = "edwin.santos.kov@gmail.com";  # Replace with your email
              extraConfig = {
                init.defaultBranch = "main";
                pull.rebase = false;
              };
            };
            
            # Zellij configuration
            programs.zellij = {
              enable = true;
              # enableZshIntegration = true;  # If you use zsh
            };

	    # programs.wezterm = {
	    #   enable = true;
	    # };
	    
	    programs.zoxide = {
	      enable = true;
              enableBashIntegration = true;
	    };


	    programs.starship = {
	      enable = true;
	    };
            
            # Shell configuration (assuming bash, uncomment if you use zsh)
            programs.bash = {
              enable = true;
              enableCompletion = true;
              sessionVariables = {
                CAT = "Mia";
              };
              shellAliases = {
                ll = "lsd -l";
		cd = "z";
                update = "nix flake update";
                hm-switch = "home-manager switch --flake ~/.config/nix";
		hm-nvim = "nvim ~/.config/nix/flake.nix";
		hm-vi = "nvim ~/.config/nix/flake.nix";
                vi-config = "nvim ~/.config/nix/nvim/init.lua";
		zj = "zellij";
		yz = "yazi";
                gs = "git status";
                zz = "slumber";
              };
              initExtra = ''
                # include .profile if it exists
                [[ -f ~/.profile ]] && . ~/.profile

                # Functions
		lcd () {
                  local target="."
                  if [ -n "$1" ]; then
                    target="$1"
                  fi
		  z "$target" && lsd -1A
		}
		llcd () {
                  local target="."
                  if [ -n "$1" ]; then
                    target="$1"
                  fi
		  z "$target" && lsd -1lA;
		}
                gucp () {
                  git add -u && git commit -m "$1" && git push
                }

                gacp () {
                  git add . && git commit -m "$1" && git push
                }

		ln -sf ~/.config/nix/nvim ~/.config/nvim

                export PATH=$PATH:/home/edwin/.cargo/bin
                export P=~/projects
                export N=~/.config/nix

                # eval "$(zoxide init bash)"
                eval "$(fnm env --use-on-cd --shell bash)"
                eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
              '';
            };
            
            # SSH configuration
            programs.ssh = {
              enable = true;
              # matchBlocks = {
              #   # Example SSH configuration
              #   # "example-host" = {
              #   #   hostname = "example.com";
              #   #   user = "username";
              #   #   port = 22;
              #   # };
              # };
            };
	   # ISSUE: Currently can't find a way to setup kdeconnect on non-Nix system with home-manager
	   # services.kdeconnect = {
	   #   enable = true;
	   #   package = pkgs.plasma5Packages.kdeconnect-kde;
	   #   indicator = true;
	   # };
	  #  networking.firewall = {
	  #    enable = true;
	  #    allowedTCPPortRanges = [{ from = 1714; to = 1764; }];
	  #    allowedUDPPortRanges = [{ from = 1714; to = 1764; }];
	  # };
          }
        ];
      };
    };
}
