return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      {
        "<leader>fs",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd(), reveal = true })
        end,
        desc = "Sidebar NeoTree (cwd)",
      },
      {
        "<leader>fS",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = require("lazyvim.util").get_root() })
        end,
        desc = "Sidebar NeoTree (root dir)",
      },
    },
    opts = {
      sources = { "filesystem" },
      filesystem = {
        -- Let Oil.nvim do this instead
        hijack_netrw_behavior = "disabled",
        window = {
          mappings = {
            -- disable fuzzy finder
            ["/"] = "noop",
          },
        },
      },
    },
  },
}
