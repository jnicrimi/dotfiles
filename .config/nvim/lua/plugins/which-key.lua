return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {},
  config = function()
    local wk = require("which-key")
    wk.setup({})
    wk.add({
      { "<leader>b", group = "buffer" },
      { "<leader>f", group = "find" },
      { "<leader>g", group = "git" },
      { "<leader>x", group = "trouble/diagnostics" },
    })
  end,
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
