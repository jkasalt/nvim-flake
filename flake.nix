{
  inputs = {
    nixpkgs.url = "nixpkgs";
    mnw.url = "github:Gerg-L/mnw";
    flake-parts.url = "github:hercules-ci/flake-parts";
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } (_: {
      systems = [ "x86_64-linux" ];

      imports = [ inputs.treefmt-nix.flakeModule ];

      perSystem =
        {
          config,
          pkgs,
          ...
        }:
        {
          treefmt.programs = {
            nixfmt.enable = true;
            statix.enable = true;
            deadnix.enable = true;
            stylua = {
              enable = true;
              settings = {
                indent_type = "Spaces";
                indent_width = 2;
                sort_requires.enabled = true;
              };
            };
          };

          checks = {
            buildsPackage = config.packages.default;
          };

          packages.default =
            let
              extraPlugins = pkgs.callPackage ./nix/plugins.nix { };
            in
            inputs.mnw.lib.wrap pkgs {
              initLua = ''require("jka")'';

              plugins = {
                dev.jka = {
                  pure = ./nvim;
                  impure = "~/nvim-flake/nvim";
                };

                start =
                  let
                    categories = with pkgs.vimPlugins; {
                      colorschemes = [
                        everforest
                        zenbones-nvim
                        lush-nvim
                        tokyonight-nvim
                        vscode-nvim
                        extraPlugins.sarnai-nvim
                        seoul256-vim
                        extraPlugins.kanso-nvim
                      ];
                      git-helpers = [
                        neogit
                        gitsigns-nvim
                      ];
                      misc = [
                        nvim-colorizer-lua
                        mini-nvim
                        which-key-nvim
                        snacks-nvim
                      ];
                      exploration = [
                        oil-nvim
                      ];
                      language-helpers = [
                        lazydev-nvim
                        rustaceanvim
                        haskell-tools-nvim
                        zk-nvim
                      ];
                      lsp-helpers = [
                        tiny-inline-diagnostic-nvim
                      ];
                      fundamental = [
                        blink-cmp
                        friendly-snippets
                        nvim-autopairs
                        nvim-ts-autotag
                        nvim-lspconfig
                        nvim-treesitter
                        nvim-treesitter-context
                        nvim-treesitter-textobjects
                        none-ls-nvim
                        lsp-format-nvim
                        nvim-treesitter.withAllGrammars
                      ];
                    };
                  in
                  builtins.concatLists (builtins.attrValues categories);

              };

              extraBinPath = with pkgs; [
                lua-language-server
                vscode-langservers-extracted
                nil
                haskellPackages.haskell-language-server
                beancount-language-server
                beancount
                rust-analyzer
                vtsls
              ];
            };

          devShells.default = pkgs.mkShellNoCC {
            packages = [ config.packages.default.devMode ];
          };
        };
    });
}
