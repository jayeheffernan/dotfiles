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
    end,
  },
}
