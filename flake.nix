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
              
              # Packages to install
              packages = with pkgs; [
                # Basic utilities
                git
                curl
                wget
                ripgrep
                lsd  # Modern ls replacement
                bat  # Modern cat replacement
                htop
                fzf
                jq
		unixtools.nettools
		nixgl
		nerd-fonts.ubuntu
		nerd-fonts.jetbrains-mono
		gnumake
		gcc
		unzip
		xclip
		# neovim
                
                # The packages you specifically mentioned
                #neovim
                rustup
		# cargo
                fnm
                openssh
                zellij
		ocs-url
		yazi
		hyfetch
		bottom
		go

		# General apps
		# plasma5Packages.kdeconnect-kde
		# Desktop Packages
		# obsidian
		spotify
		flatpak
		syncthing
		syncthingtray
		# google-chrome-stable
                # vscode
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
	    };


	    programs.starship = {
	      enable = true;
	    };
            
            # Shell configuration (assuming bash, uncomment if you use zsh)
            programs.bash = {
              enable = true;
              shellAliases = {
                ll = "ls -la";
		#cd = "zoxide";
                update = "nix flake update";
                hm-switch = "home-manager switch --flake ~/.config/nix";
		hm-nvim = "nvim ~/.config/nix/flake.nix";
		zj = "zellij";
		yz = "yazi";
              };
              initExtra = ''
                # Add your custom bash configuration here
		lcd () {
		  z "$1" && lsd -1A;
		}

		ln -sf ~/.config/nix/nvim ~/.config/nvim

                eval "$(fnm env --use-on-cd --shell bash)"
                export PATH=$PATH:/home/edwin/.cargo/bin
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
