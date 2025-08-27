local b = vim.lsp.buf

WK.add({
  { "gd", b.definition, desc = "go to definition" },
  { "gD", b.declaration, desc = "go to declaration" },
  { "gr", b.references, desc = "list references" },
  { "ga", b.code_action, desc = "code action" },
  { "<leader>rn", b.rename, desc = "rename symbol" },
})

require("tiny-inline-diagnostic").setup()
vim.diagnostic.config({ virtual_text = false })
