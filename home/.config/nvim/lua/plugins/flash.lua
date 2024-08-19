return {
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      labels = "ntesirlpufywkvmc,xoa;qjg./NTESIRLPUFYWKVMCXOAQJG",
      label = { before = true, after = false },
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
            require("flash").jump({
              search = { mode = "search", max_length = 0 },
              label = { after = { 0, 0 } },
              pattern = "^"
            })
          end,
          desc = "Flash lines",
        },
        {
          "<C-S>",
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
        {
          "gs",
          mode = "n",
          function()
            require("flash").jump({
              action = function(match, state)
                vim.api.nvim_win_call(match.win, function()
                  -- Move cursor to match location
                  vim.api.nvim_win_set_cursor(match.win, match.pos)
                  -- Go to definition under cursor
                  require("telescope.builtin").lsp_definitions({ reuse_win = true })
                end)
              end,
            })
          end,
          desc = "Goto Flash",
        },
      }
    end,
  },
}
