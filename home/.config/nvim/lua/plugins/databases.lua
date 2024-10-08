return {
  {
    "tpope/vim-dadbod",
    dependencies = {
      {
        "kristijanhusak/vim-dadbod-completion",
        -- Completion must be loaded first, then dadbod completion can add to
        -- it, otherwise vim-dadbod-completion messes up normal completion
        -- somehow
        dependencies = { { "hrsh7th/nvim-cmp" } },
      },
    },
    init = function()
      -- todo Redis DB
      vim.g.db = "postgresql://postgres:@localhost:5432/ludwig"
      vim.g.omni_sql_no_default_maps = 1 -- https://www.reddit.com/r/vim/comments/2om1ib/how_to_disable_sql_dynamic_completion/cmop4zh/

      -- Mappings
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "sql", "mysql", "plsql", "redis" },
        callback = function()
          local cmp = require("cmp")
          cmp.setup.buffer({ sources = { { name = "vim-dadbod-completion" } } })

          vim.keymap.set("n", "<leader>rR", function()
            vim.cmd("vert %DB")
          end, { desc = "Run file as query" })
          vim.keymap.set("x", "<leader>rr", ":tab '<,'>DB<CR>", { desc = "Run selection as query" })
          vim.keymap.set("n", "<leader>rr", "db#op_exec()", { desc = "Run as query", expr = true })
          vim.keymap.set("n", "<leader>rn", "vap:tab '<,'>DB<CR>", { desc = "Run query" })
        end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "redis" },
        callback = function()
          vim.b.db = "redis:///"
        end,
      })
    end,
  },
  {
    "junegunn/vim-redis",
  },
}
