vim.keymap.set("n", " ", "<Nop>", { silent = true, noremap = true })
vim.g.mapleader = " "

require("vscode").setup({ italic_comments = true })
vim.cmd.colorscheme("vscode")

WK = require("which-key")
WK.setup()

require("jka.oil")
require("jka.lsp")
require("jka.lspconfig")
require("jka.completion")
require("jka.mini")
require("jka.autopairs")
require("jka.none-ls")
require("jka.treesitter")
require("jka.zettelkasten")
