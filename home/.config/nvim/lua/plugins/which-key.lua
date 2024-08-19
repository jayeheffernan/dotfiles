return {
  "folke/which-key.nvim",
  opts = {
    plugins = { spelling = true },
    defaults = {
      mode = { "n", "v" },
      ["g"] = { name = "+goto" },
      ["]"] = { name = "+next" },
      ["["] = { name = "+prev" },

      -- ["<leader><tab>"] = { name = "+tabs" },
      ["<leader>b"] = { name = "+buffer" },
      ["<leader>c"] = { name = "+code" },
      ["<leader>f"] = { name = "+file/find" },
      ["<leader>s"] = { name = "+search" },
      ["<leader>sg"] = { name = "+git" },

      -- Telescope variants (not FZF)
      ["<localleader>b"] = { name = "+buffer" },
      ["<localleader>c"] = { name = "+code" },
      ["<localleader>f"] = { name = "+file/find" },
      ["<localleader>s"] = { name = "+search" },
      ["<localleader>sg"] = { name = "+git" },

      ["<leader>g"] = { name = "+git" },
      ["<leader>gh"] = { name = "+hunks" },
      ["<leader>q"] = { name = "+quit/session" },
      ["<leader>u"] = { name = "+ui" },
      ["<leader>w"] = { name = "+windows" },
      ["<leader>x"] = { name = "+diagnostics/quickfix" },

      ["<leader>y"] = { name = "Use clipboard" },
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    wk.register(opts.defaults)
  end,
}
