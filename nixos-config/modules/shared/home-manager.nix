{ config, pkgs, lib, ... }:

let name = "Edwin Santos";
    user = "edwinsantos";
    email = "edwin.santos.kov@gmail.com"; in
{

  git = {
    enable = true;
    ignores = [ "*.swp" ];
    userName = name;
    userEmail = email;
    lfs = {
      enable = true;
    };
    extraConfig = {
      init.defaultBranch = "main";
      core = {
	    editor = "vim";
        autocrlf = "input";
      };
      pull.rebase = true;
      rebase.autoStash = true;
    };
  };

  neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    plugins = with pkgs.vimPlugins; [];
  };
  
  zellij = {
    enable = true;
  };
  
  zoxide = {
    enable = true;
    enableBashIntegration = true;
  };
  
  starship = {
    enable = true;
  };

  bash = {
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

ln -sf ~/.config/sys_config/nvim ~/.config/nvim

export PATH=$PATH:/home/edwin/.cargo/bin
export P=~/projects
export N=~/.config/nix

eval "$(zoxide init bash)"
eval "$(fnm env --use-on-cd --shell bash)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

if [[ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]]; then
. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
. /nix/var/nix/profiles/default/etc/profile.d/nix.sh
fi

# Remove history data we don't want to see
export HISTIGNORE="pwd:ls:cd"

export EDITOR="neovim"
export ALTERNATE_EDITOR=""
# export VISUAL="emacsclient -c -a emacs"

# e () {
# emacsclient -t "$@"
# }

# nix shortcuts
shell () {
nix-shell '<nixpkgs>' -A "$1"
}

              '';
            };

  vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [ vim-airline vim-airline-themes vim-startify vim-tmux-navigator ];
    settings = { ignorecase = true; };
    extraConfig = ''
      "" General
      set number
      set history=1000
      set nocompatible
      set modelines=0
      set encoding=utf-8
      set scrolloff=3
      set showmode
      set showcmd
      set hidden
      set wildmenu
      set wildmode=list:longest
      set cursorline
      set ttyfast
      set nowrap
      set ruler
      set backspace=indent,eol,start
      set laststatus=2
      set clipboard=autoselect

      " Dir stuff
      set nobackup
      set nowritebackup
      set noswapfile
      set backupdir=~/.config/vim/backups
      set directory=~/.config/vim/swap

      " Relative line numbers for easy movement
      set relativenumber
      set rnu

      "" Whitespace rules
      set tabstop=8
      set shiftwidth=2
      set softtabstop=2
      set expandtab

      "" Searching
      set incsearch
      set gdefault

      "" Statusbar
      set nocompatible " Disable vi-compatibility
      set laststatus=2 " Always show the statusline
      let g:airline_theme='bubblegum'
      let g:airline_powerline_fonts = 1

      "" Local keys and such
      let mapleader=","
      let maplocalleader=" "

      "" Change cursor on mode
      :autocmd InsertEnter * set cul
      :autocmd InsertLeave * set nocul

      "" File-type highlighting and configuration
      syntax on
      filetype on
      filetype plugin on
      filetype indent on

      "" Paste from clipboard
      nnoremap <Leader>, "+gP

      "" Copy from clipboard
      xnoremap <Leader>. "+y

      "" Move cursor by display lines when wrapping
      nnoremap j gj
      nnoremap k gk

      "" Map leader-q to quit out of window
      nnoremap <leader>q :q<cr>

      "" Move around split
      nnoremap <C-h> <C-w>h
      nnoremap <C-j> <C-w>j
      nnoremap <C-k> <C-w>k
      nnoremap <C-l> <C-w>l

      "" Easier to yank entire line
      nnoremap Y y$

      "" Move buffers
      nnoremap <tab> :bnext<cr>
      nnoremap <S-tab> :bprev<cr>

      "" Like a boss, sudo AFTER opening the file to write
      cmap w!! w !sudo tee % >/dev/null

      let g:startify_lists = [
        \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
        \ { 'type': 'sessions',  'header': ['   Sessions']       },
        \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      }
        \ ]

      let g:startify_bookmarks = [
        \ '~/Projects',
        \ '~/Documents',
        \ ]

      let g:airline_theme='bubblegum'
      let g:airline_powerline_fonts = 1
      '';
     };

  zsh = {
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
      g1 = "git log --oneline";
      ga = "git add";
      gau = "git add -u";
      gco = "git checkout";
      gc = "git commit -m";
      gsm = "git stash push -m";
      zz = "slumber";
      watch = "watchexec";
      sys-rebuild = "cd ~/.config/sys_config/nixos-config/ && nix run .#build-switch";
};
    autocd = false;
    # plugins = [
    #   {
    #     name = "powerlevel10k";
    #     src = pkgs.zsh-powerlevel10k;
    #     file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    #   }
    #   {
    #     name = "powerlevel10k-config";
    #     src = lib.cleanSource ./config;
    #     file = "p10k.zsh";
    #   }
    # ];

    initExtraFirst = ''
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

	ln -sf ~/.config/sys_config/nvim ~/.config/nvim
	ln -sf ~/.config/sys_config/wezterm/ ~/.config/wezterm
	ln -sf ~/.config/sys_config/zj_config.kdl ~/.config/zellij/config.kdl

	export PATH=$PATH:/home/edwin/.cargo/bin
	export P=~/projects
	export N=~/.config/nix

	eval "$(zoxide init zsh)"
	eval "$(fnm env --use-on-cd --shell zsh)"
	# eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
	source "$HOME/.sdkman/bin/sdkman-init.sh"

	if [[ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]]; then
	. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
	. /nix/var/nix/profiles/default/etc/profile.d/nix.sh
	fi

	# Define variables for directories
	export PATH=$HOME/.pnpm-packages/bin:$HOME/.pnpm-packages:$PATH
	export PATH=$HOME/.npm-packages/bin:$HOME/bin:$PATH
	export PATH=$HOME/.local/share/bin:$PATH

	# Remove history data we don't want to see
	export HISTIGNORE="pwd:ls:cd"

	# Emacs is my editor
	export ALTERNATE_EDITOR=""
	export EDITOR="nvim"
	# export VISUAL="emacsclient -c -a emacs"

	# e() {
	#   emacsclient -t "$@"
	# }

	# nix shortcuts
	shell() {
	  nix-shell '<nixpkgs>' -A "$1"
	}

	# Use difftastic, syntax-aware diffing
	alias diff=difft

	# Always color ls and group directories
	# alias ls='ls --color=auto'
    '';
  };

  # ssh = {
  #   enable = true;
  #   includes = [
  #     (lib.mkIf pkgs.stdenv.hostPlatform.isLinux
  #       "/home/${user}/.ssh/config_external"
  #     )
  #     (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin
  #       "/Users/${user}/.ssh/config_external"
  #     )
  #   ];
  # };

}
