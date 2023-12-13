local Util = require("lazyvim.util")

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
    keys = {
      -- Override search for "symbols"
      { "<leader>ss", function() Util.telescope("grep_string", { use_regex = true, search = vim.fn.input("search") })() end, desc = "Grep (root dir)" },
      {
        "<leader>sS",
        function()
          Util.telescope("grep_string",
            { cwd = false, use_regex = true, search = vim.fn.input("search") })()
        end,
        desc = "Grep (cwd)"
      },
      {
        "<leader>sls",
        function()
          require("telescope.builtin").lsp_document_symbols({
            symbols = require("lazyvim.config").get_kind_filter(),
          })
        end,
        desc = "Goto LSP Symbol",
      },
      -- Restore these on different mappings
      {
        "<leader>slS",
        function()
          require("telescope.builtin").lsp_dynamic_workspace_symbols({
            symbols = require("lazyvim.config").get_kind_filter(),
          })
        end,
        desc = "Goto LSP Symbol (Workspace)",
      },
    },
    opts = {
      defaults = {
        layout_strategy = "flex",
        layout_config = {
          flip_columns = 160,
          height = { padding = 0 },
          width = { padding = 0 },
          horizontal = {
            preview_width = 0.35,
          },
          vertical = {
            preview_height = 0.3,
          },
        },
        prompt_prefix = " ",
        selection_caret = " ",
        mappings = {
          i = {
            ["<c-q>"] = function(...)
              local actions = require("telescope.actions")
              actions.smart_send_to_qflist(...)
              actions.open_qflist(...)
              vim.cmd("cc") -- show first quickfix error
            end,
            ["<c-t>"] = function(...)
              return require("trouble.providers.telescope").open_with_trouble(...)
            end,
            ["<a-t>"] = function(...)
              return require("trouble.providers.telescope").open_selected_with_trouble(...)
            end,
            ["<a-i>"] = function()
              local action_state = require("telescope.actions.state")
              local line = action_state.get_current_line()
              Util.telescope("find_files", { no_ignore = true, default_text = line })()
            end,
            ["<a-h>"] = function()
              local action_state = require("telescope.actions.state")
              local line = action_state.get_current_line()
              Util.telescope("find_files", { hidden = true, default_text = line })()
            end,
            ["<C-Down>"] = function(...)
              return require("telescope.actions").cycle_history_next(...)
            end,
            ["<C-Up>"] = function(...)
              return require("telescope.actions").cycle_history_prev(...)
            end,
            ["<C-f>"] = function(...)
              return require("telescope.actions").preview_scrolling_down(...)
            end,
            ["<C-b>"] = function(...)
              return require("telescope.actions").preview_scrolling_up(...)
            end,
            ["<C-c>"] = function(...)
              return require("telescope.actions").close(...)
            end,
            ["Esc"] = function(...)
              return require("telescope.actions").close(...)
            end,
          },
          n = {
            ["q"] = function(...)
              return require("telescope.actions").close(...)
            end,
          },
        },
      },
    },
  },
}
