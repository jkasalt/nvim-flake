require("mini.ai").setup()
require("mini.animate").setup()
require("mini.basics").setup()
require("mini.bracketed").setup()
require("mini.cursorword").setup()
require("mini.extra").setup()
require("mini.indentscope").setup()
require("mini.jump2d").setup()
require("mini.move").setup()
require("mini.notify").setup()
-- require("mini.operators").setup()
require("mini.pick").setup()
require("mini.sessions").setup({ autoread = true })
require("mini.starter").setup()
require("mini.statusline").setup()
require("mini.surround").setup()
require("mini.tabline").setup()
require("mini.trailspace").setup()
require("mini.visits").setup()

-- mini.bufremove
WK.add({
  {
    "<leader>bd",
    function()
      require("mini.bufremove").delete()
    end,
    desc = "delete buffer",
  },
})

-- mini.pick
-- TODO add extra pickers from mini.extras
WK.add({
  { "<leader>f", group = "find" },
  { "<leader>ff", "<CMD>:Pick files<CR>", desc = "find files" },
  { "<leader>fg", "<CMD>:Pick grep_live<CR>", desc = "find grep" },
  { "<leader>fh", "<CMD>:Pick help<CR>", desc = "find help" },
  { "<leader>fb", "<CMD>:Pick buffers<CR>", desc = "find buffers" },
  {
    "<leader>fr",
    function()
      require("mini.pick").start({ source = { items = require("mini.visits").list_paths() } })
    end,
    desc = "find recent",
  },
})
