return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    plugins = { spelling = true },
    defaults = {
      mode = { "n", "v" },
      ["g"] = { name = "+goto" },
      ["]"] = { name = "+next" },
      ["["] = { name = "+prev" },
      ["<leader>n"] = { name = "+next" },
      ["<leader>N"] = { name = "+prev" },
      -- ["<leader><tab>"] = { name = "+tabs" },
      ["<leader>b"] = { name = "+buffer" },
      ["<leader>c"] = { name = "+code" },
      ["<leader>f"] = { name = "+file/find" },
      ["<leader>s"] = { name = "+search" },
      -- FZF variants (not telescope), WIP
      ["<localleader>b"] = { name = "+buffer" },
      ["<localleader>c"] = { name = "+code" },
      ["<localleader>f"] = { name = "+file/find" },
      ["<localleader>s"] = { name = "+search" },

      ["<leader>g"] = { name = "+git" },
      ["<leader>gh"] = { name = "+hunks" },
      ["<leader>gt"] = { name = "+toggle" },
      ["<leader>q"] = { name = "+quit/session" },
      ["<leader>u"] = { name = "+ui" },
      ["<leader>ug"] = { name = "+git" },
      ["<leader>w"] = { name = "+windows" },
      ["<leader>x"] = { name = "+diagnostics/quickfix" },

      ["<leader>y"] = { name = "+clipboard" },
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    wk.register(opts.defaults)
  end,
}
