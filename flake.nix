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
        { config, pkgs, ... }:
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

          packages.default = inputs.mnw.lib.wrap pkgs {
            initLua = ''require("jka")'';

            devExcludedPlugins = [ ./nvim ];

            devPluginPaths = [
              "~/Projects/nvim-flake/nvim"
            ];

            plugins =
              builtins.attrValues {
                inherit (pkgs.vimPlugins)
                  oil-nvim
                  lazydev-nvim
                  mini-nvim
                  blink-cmp
                  which-key-nvim
                  friendly-snippets
                  nvim-autopairs
                  nvim-ts-autotag
                  nvim-lspconfig
                  nvim-treesitter
                  nvim-treesitter-context
                  nvim-treesitter-textobjects
                  vscode-nvim
                  none-ls-nvim
                  lsp-format-nvim
                  rustaceanvim
                  ;
              }
              ++ [
                pkgs.vimPlugins.nvim-treesitter.withAllGrammars
              ];
            extraBinPath = with pkgs; [
              lua-language-server
              vscode-langservers-extracted
              nil
              ocamlPackages.ocaml-lsp
              rust-analyzer
            ];
          };

          devShells.default = pkgs.mkShellNoCC {
            packages = [ config.packages.default.devMode ];
          };
        };
    });
}
