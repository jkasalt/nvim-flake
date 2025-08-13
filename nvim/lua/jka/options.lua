vim.opt.scrolloff = 7

WK.add({
  { "L", ":bn<cr>", desc = "next buffer" },
  { "H", ":bp<cr>", desc = "previous buffer" },
  { mode = "t", "<esc><esc>", "<C-\\><C-n>", desc = "exit terminal mode" },
})

-- Set tab width to 4 spaces
vim.opt.tabstop = 4 -- Number of spaces that a <Tab> in the file counts for.
vim.opt.shiftwidth = 4 -- Number of spaces to use for each step of (auto)indent.
vim.opt.expandtab = true -- Use spaces instead of tabs.

vim.opt.softtabstop = 4 -- Number of spaces that a <Tab> counts for while performing editing operations.
