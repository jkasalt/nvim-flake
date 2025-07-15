vim.keymap.set("n", " ", "<Nop>", { silent = true, noremap = true })
vim.g.mapleader = " "

vim.cmd.colorscheme("kanso")

WK = require("which-key")
WK.setup()

require("jka.oil")
require("jka.options")
require("jka.lsp")
require("jka.git")
require("jka.lspconfig")
require("jka.completion")
require("jka.mini")
require("jka.autopairs")
require("jka.none-ls")
require("jka.treesitter")
require("jka.zettelkasten")

require("colorizer").setup()
