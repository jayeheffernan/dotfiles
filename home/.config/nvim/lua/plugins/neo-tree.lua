return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = function()
      return {
        {
          "<leader>fs",
          function()
            require("neo-tree.command").execute({ toggle = true, dir = require("lazyvim.util").get_root() })
          end,
          desc = "Sidebar explorer (root dir)",
        },
        {
          "<leader>fS",
          function()
            require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
          end,
          desc = "Sidebar explorer (cwd)",
        },
      }
    end,
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
