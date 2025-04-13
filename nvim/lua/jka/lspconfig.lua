local servers = {
  lua_ls = {
    on_init = function(client)
      if client.workspace_folders then
        local path = client.workspace_folders[1].name
        if
          path ~= vim.fn.stdpath("config")
          and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
        then
          return
        end
      end

      client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
        runtime = {
          version = "LuaJIT",
        },
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME,
            "${3rd}/luv/library",
            "${3rd}/busted/library",
          },
        },
      })
    end,
    settings = {
      Lua = {},
    },
  },
  jsonls = {},
  nil_ls = {},
}

local capabilities = require("blink.cmp").get_lsp_capabilities()
local lspconfig = require("lspconfig")

for server, config in pairs(servers) do
  config.capabilities = capabilities
  lspconfig[server].setup(config)
end
