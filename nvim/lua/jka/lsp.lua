local b = vim.lsp.buf

local function toggle_virtual_lines()
  local curr = vim.diagnostic.config().virtual_lines.current_line
  vim.diagnostic.config({ virtual_lines = { current_line = not curr } })
end

WK.add({
  { "gd", b.definition, desc = "go to definition" },
  { "gD", b.declaration, desc = "go to declaration" },
  { "gr", b.references, desc = "list references" },
  { "ga", b.code_action, desc = "code action" },
  { "<leader>rn", b.rename, desc = "rename symbol" },
  { "<leader>tl", toggle_virtual_lines, desc = "toggle virtual line diagnostics" },
})

require("tiny-inline-diagnostic").setup()
vim.diagnostic.config({ virtual_text = false })
