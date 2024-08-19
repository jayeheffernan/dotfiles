return {
  {
    "tpope/vim-fugitive",
  },
  {
    "tpope/vim-rhubarb",
  },
  {
    "sindrets/diffview.nvim",
    opts = {
      keymaps = {
        file_panel = {
          -- Disable staging mappings, prefer to jump around with default `s` binding
          { "n", "s", false },
          { "n", "S", false },
        },
      },
      default_args = { -- Default args prepended to the arg-list for the listed commands
        DiffviewOpen = { "-uno" },
      },
    },
  },
  -- {
  --   "ldelossa/gh.nvim",
  --   dependencies = {
  --     {
  --       "ldelossa/litee.nvim",
  --       config = function()
  --         require("litee.lib").setup()
  --       end,
  --     },
  --   },
  --   config = function()
  --     require("litee.gh").setup()
  --   end,
  -- },
  {
    'pwntester/octo.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      -- OR 'ibhagwan/fzf-lua',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require "octo".setup({
        use_local_fs = true,
        suppress_missing_scope = {
          projects_v2 = true,
        }
      })
    end
  }
  -- {
  --   "iberianpig/tig-explorer.vim",
  --   dependencies = { "mason.nvim" },
  -- },
}
