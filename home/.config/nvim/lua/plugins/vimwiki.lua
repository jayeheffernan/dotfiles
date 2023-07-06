return {
  {
    "iamcco/markdown-preview.nvim",
    build = function()
      vim.cmd("call mkdp#util#install()")
    end,
  },
  {
    "jakewvincent/mkdnflow.nvim",
    opts = {
      modules = {
        conceal = true,
        maps = false,
      },
      mappings = {},
      perspective = {
        priority = "root",
        root_tell = ".wikiroot",
      },
      links = {
        style = "wiki",
        name_is_source = true,
        context = 1, -- support links broken over 2 lines
        implicit_extension = "md",
        -- transform_explicit = function(text)
        --   -- To create a filename stub, just lowercase the link-text
        --   return string.lower(text)
        -- end,
      },
      new_file_template = {
        use_template = true,
      },
    },
    config = function(_, opts)
      require("mkdnflow").setup(opts)

      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "markdown", "md" },
        desc = "markdown mappings",
        callback = function(opts)
          vim.keymap.set({ "n", "v" }, "<CR>", function()
            vim.cmd("MkdnEnter")
          end, { buffer = true })
        end,
        group = vim.api.nvim_create_augroup("jaye_markdown_mappings", { clear = true }),
      })
    end,
  },
  -- {
  --   "vimwiki/vimwiki",
  --   init = function()
  --     vim.g.vimwiki_list = { { path = "~/.vimwiki/", syntax = "markdown", ext = ".md" } }
  --     vim.g.vimwiki_global_ext = 0
  --     vim.g.vimwiki_ext2syntax = vim.empty_dict()
  --   end,
  -- },
}
