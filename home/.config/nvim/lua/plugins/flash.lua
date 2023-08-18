return {
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
    keys = function()
      return {
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
      }
    end,
  },
}
