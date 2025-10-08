{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    mnw = {
      url = "github:Gerg-L/mnw";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    fff-nvim = {
      url = "github:dmtrKovalenko/fff.nvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
          system,
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
              extraPlugins = pkgs.callPackage ./nix/plugins.nix { } // {
                inherit (inputs.fff-nvim.outputs.packages.${system}) fff-nvim;
              };
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
                        vscode-nvim
                        extraPlugins.sarnai-nvim
                        seoul256-vim
                        extraPlugins.kanso-nvim
                        modus-themes-nvim
                        bamboo-nvim
                      ];
                      git-helpers = [
                        vim-fugitive
                        gitsigns-nvim
                      ];
                      misc = [
                        nvim-colorizer-lua
                        mini-nvim
                        which-key-nvim
                        snacks-nvim
                        orgmode
                      ];
                      rest-nvim = [
                        rest-nvim
                        nvim-nio
                        fidget-nvim
                      ];
                      coding-support = [
                        oil-nvim
                        extraPlugins.fff-nvim
                      ];
                      language-helpers = [
                        lazydev-nvim
                        rustaceanvim
                        haskell-tools-nvim
                      ];
                      lsp = [
                        tiny-inline-diagnostic-nvim
                      ];
                      fundamental = [
                        blink-cmp
                        friendly-snippets
                        nvim-autopairs
                        nvim-ts-autotag
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

              extraLuaPackages = ps: [
                ps.mimetypes
                ps.xml2lua
              ];

              extraBinPath = with pkgs; [
                lua-language-server
                nil
                haskellPackages.haskell-language-server
                rust-analyzer
              ];
            };

          devShells.default = pkgs.mkShellNoCC {
            packages = [ config.packages.default.devMode ];
          };
        };
    });
}
