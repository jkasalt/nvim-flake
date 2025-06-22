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

vim.diagnostic.config({ virtual_lines = { current_line = true }, virtual_text = true })

local document_highlight = vim.api.nvim_create_augroup("DocumentHighlight", { clear = true })

vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  group = document_highlight,
  callback = b.document_highlight,
})

vim.api.nvim_create_autocmd({ "CursorMoved" }, {
  group = document_highlight,
  callback = b.clear_references,
})
