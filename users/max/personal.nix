{ config, pkgs, lib, ... }:
let
  home-manager = builtins.fetchGit {
    url = "https://github.com/rycee/home-manager.git";
    rev = "2aa20ae969f2597c4df10a094440a66e9d7f8c86";
    ref = "release-20.09";
  };
  pluginGit = ref: repo: pkgs.vimUtils.buildVimPlugin {
    name = "${lib.strings.sanitizeDerivationName repo}";
    version = ref;
    src = builtins.fetchGit {
      url = "https://github.com/${repo}.git";
      ref = ref;
    };
  };
  plugin = pluginGit "HEAD";
in {
  imports = [
    (import "${home-manager}/nixos")
  ];

  users.extraUsers.max = {
    isNormalUser = true;
    extraGroups = lib.mkDefault [
      "wheel"
    ];
  };

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;

    users.max = { pkgs, ... }: {
      programs = {

        firefox = {
          enable = true;
        };

        fzf = {
          enable = true;
          enableZshIntegration = true;
        };

        git = {
          enable = true;
          userName = "Max Stanley";
          userEmail = "git@maxstanley.uk";
          extraConfig = {
            url = { "ssh://git@github.com" = { insteadOf = "https://github.com"; }; };
          };
        };

        neovim = {
          enable = true;

          viAlias = true;
          vimAlias = true;
          withPython3 = true;
		  withNodeJs = true;

          extraConfig = builtins.readFile ./neovim.vim;

          plugins = with pkgs.vimPlugins; [
            # coc Intellisense
            # (plugin "neoclide/coc.nvim")
            coc-nvim
            coc-spell-checker
            # coc-swagger
            coc-yaml
            coc-yank

            # C/C++
            (plugin "bfrg/vim-cpp-modern")
             # coc-clangd

            # cmake
            (plugin "pboettch/vim-cmake-syntax")
             # coc-cmake

            # Dockerfile
            # (plugin "ekalinin/Dockerfile.vim")

            # Go
            # (plugin "fatih/vim-go")
            vim-go
            coc-go

            # JavaScript
            # (plugin "pangloss/vim-javascript")
            vim-javascript
            vim-javascript-syntax
            coc-css
            coc-emmet
            coc-html

            # JSX
            # (plugin "maxmellon/vim-jsx-pretty")
            vim-jsx-pretty
            vim-jsx-typescript

            # Markdown
            (plugin "godlygeek/tabular")
            # (plugin "plasticboy/vim-markdown")
            vim-markdown
            coc-markdownlint

            # NGINX
            (plugin "chr4/nginx.vim")

            # Protobuf
            # (plugin "uarun/vim-protobuf")
            vim-protobuf

            # Python
            (plugin "vim-python/python-syntax")
            coc-python
            # coc-pydocstring

            # Rust
            (plugin "rust-lang/rust.vim")
            coc-rls
            coc-rust-analyzer

            # sh
            (plugin "arzg/vim-sh")
            # coc-sh

            # TypeScript
            (plugin "leafgarland/typescript-vim")
            coc-tsserver

            # Fuzzy Matching
            # (plugin "junegunn/fzf")
            # (plugin "junegunn/fzf.vim")
            fzf-vim
            coc-fzf

            # Markdown Preview
            (plugin "iamcco/markdown-preview.nvim")

            # Debugging
            # (plugin "puremourning/vimspector")
            vimspector
            (plugin "szw/vim-maximizer")

            # Background tasks
            (plugin "skywind3000/asyncrun.vim")

            # Colour Scheme
            # (plugin "chriskempson/base16-vim")
            base16-vim

          ];
        };

        ssh = {
          enable = true;
        };

        tmux = {
          enable = true;
          historyLimit = 10000;
          extraConfig = builtins.readFile ./tmux.conf;
        };

        zsh = {
          enable = true;

          autocd = false;
          enableCompletion = true;
          enableAutosuggestions = true;

          history = {
              size = 1000;
              save = 1000;
              path = "$HOME/.zsh_history";
              share = true;
              extended = false;
          };

          shellAliases = {
            ls = "ls -lh --color=auto";
            ll = "ls -lhA --color=auto";
          };

        };
      };
    };
  };
}
