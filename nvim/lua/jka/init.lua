vim.keymap.set("n", " ", "<Nop>", { silent = true, noremap = true })
vim.g.mapleader = " "

vim.cmd.colorscheme("kanso")

WK = require("which-key")
WK.setup()

require("jka.autopairs")
require("jka.completion")
require("jka.git")
require("jka.indentscope")
require("jka.lsp")
require("jka.lspconfig")
require("jka.mini")
require("jka.none-ls")
require("jka.oil")
require("jka.options")
require("jka.treesitter")
require("jka.zettelkasten")

require("colorizer").setup()
