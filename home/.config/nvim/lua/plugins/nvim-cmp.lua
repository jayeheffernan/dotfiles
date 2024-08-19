local keymap = vim.keymap.set

return {
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
    opts = {
      -- required to make snippets work from visual mode
      store_selection_keys = "<C-Space>"
    },
    config = function(_, opts)
      local cmp_window = require "cmp.config.window"
      local window = {
        completion = cmp_window.bordered(),
        documentation = cmp_window.bordered(),
      }
      opts.window = window;

      if opts then require("luasnip").config.setup(opts) end

      -- friendly-snippets - enable standardized comments snippets
      require("luasnip").filetype_extend("typescript",
        { "tsdoc", "javascript", "typescript" })
      require("luasnip").filetype_extend("typescriptreact",
        { "tsdoc", "typescripreact", "react-ts", "javascript", "javascriptreact", "react", "react-es7", "typescript" })
      require("luasnip").filetype_extend("javascript", { "jsdoc", "javascript" })
      require("luasnip").filetype_extend("javascriptreact",
        { "jsdoc", "javascriptreact", "react", "react-es7", "javascript" })
      require("luasnip").filetype_extend("lua", { "luadoc" })
      require("luasnip").filetype_extend("rust", { "rustdoc" })
      require("luasnip").filetype_extend("sh", { "shelldoc" })

      keymap({ "i", "s" }, "<C-Space>", function()
        require("luasnip").expand_or_jump()
      end, { desc = "LuaSnip expand/forward jump" })

      keymap({ "i", "s" }, "<C-h>", function()
        require("luasnip").jump(-1)
      end, { desc = "LuaSnip backward jump" })

      -- Higher priority number will be preferred
      require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/LuaSnip/", default_priority = 2 })
      require("luasnip.loaders.from_vscode").lazy_load({ default_priority = 1 });
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        'rcarriga/cmp-dap'
      },
      {
        'LiadOz/nvim-dap-repl-highlights',
        config = function()
          require('nvim-dap-repl-highlights').setup()
        end
      }
    },
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.mapping = cmp.mapping.preset.insert({
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<S-CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      })
      opts.preselect = cmp.PreselectMode.None
      opts.completion = {
        completeopt = "noselect",
      }
      opts.enabled = function()
        return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
            or require("cmp_dap").is_dap_buffer()
      end
      return opts
    end,
    config = function(_, opts)
      require("cmp").setup(opts);
      require("cmp").setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
        sources = {
          { name = "dap" },
        },
      })
    end
  },
}
