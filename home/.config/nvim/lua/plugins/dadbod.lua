return {
  "tpope/vim-dadbod",
  dependencies = {
    {
      "kristijanhusak/vim-dadbod-completion",
    },
  },
  init = function()
    vim.g.db = "postgresql://postgres:@localhost:5432/ludwig"
    vim.g.omni_sql_no_default_maps = 1 -- https://www.reddit.com/r/vim/comments/2om1ib/how_to_disable_sql_dynamic_completion/cmop4zh/
  end,
}
