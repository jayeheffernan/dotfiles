return {
  {
    -- TODO: if we switch back to leap, enable tree-sitter mapping: https://github.com/ggandor/leap-ast.nvim
    "ggandor/leap.nvim",
    enabled = false,
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      labels = "ntesirlpufywkvmc,xoa;qjg./NTESIRLPUFYWKVMCXOAQJG",
      modes = {
        search = {
          enabled = false,
        },
        char = {
          enabled = false,
        },
        treesitter = {
          labels = "ntesirlpufywkvmc,xoa;qjg./NTESIRLPUFYWKVMCXOAQJG",
        },
      },
    },
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          -- default options: exact mode, multi window, all directions, with a backdrop
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "o" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
    },
  },
  -- ee13
  -- ee14
  -- ee15
  -- ee16
  -- ee17
  -- ee18
  -- ee19
  -- ee20
  -- ee21
  -- ee22
  -- ee23
  -- ee24
  -- ee25
  -- ee26
  -- ee27
  -- ee28
  -- ee29
  -- ee30
  -- ee31
  -- ee32
  -- ee33
  -- ee34
  -- ee35
  -- ee36
  -- ee37
  -- ee38
  -- ee39
  -- ee40
  -- ee41
  -- ee42
  -- ee43
  -- ee44
  -- ee45
  -- {
  --   "ggandor/leap.nvim",
  --   keys = {
  --     { "x", mode = { "x", "o" }, desc = "Leap forward to" },
  --     { "X", mode = { "x", "o" }, desc = "Leap backward to" },
  --   },
  --   opts = {
  --     highlight_unlabeled_phase_one_targets = true,
  --     safe_labels = {},
  --     labels = {
  --       "n",
  --       "t",
  --       "e",
  --       "s",
  --       "i",
  --       "r",
  --       "l",
  --       "p",
  --
  --       "u",
  --       "f",
  --       "y",
  --       "w",
  --       "k",
  --       "v",
  --       "m",
  --       "c",
  --       ",",
  --       "x",
  --       "o",
  --       "a",
  --       ";",
  --       "q",
  --       "j",
  --       "g",
  --       ".",
  --       "/",
  --
  --       "N",
  --       "T",
  --       "E",
  --       "S",
  --       "I",
  --       "R",
  --       "L",
  --       "P",
  --       "U",
  --       "F",
  --       "Y",
  --       "W",
  --       "K",
  --       "V",
  --       "M",
  --       "C",
  --       "X",
  --       "O",
  --       "A",
  --       "Q",
  --       "J",
  --       "G",
  --     },
  --   },
  --   config = function(_, opts)
  --     local leap = require("leap")
  --     for k, v in pairs(opts) do
  --       leap.opts[k] = v
  --     end
  --
  --     leap.add_default_mappings(false) -- false = no-force
  --
  --     -- Visual-mode mapping for S can prefer surround, but expose leap mappings under x/X (and also "s")
  --     vim.keymap.set("x", "S", "<Plug>VSurround")
  --     vim.keymap.set({ "x", "o" }, "x", "<Plug>(leap-forward-to)")
  --     vim.keymap.set({ "x", "o" }, "X", "<Plug>(leap-backward-to)")
  --   end,
  -- },
}
