vim.diagnostic.config({ virtual_lines = { current_line = true }, virtual_text = true })

WK.add({
  { "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", desc = "go to definition" },
  { "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", desc = "go to declaration" },
})
