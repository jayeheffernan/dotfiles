return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- disable a keymap
      keys[#keys + 1] = { "gr", false }
      keys[#keys + 1] = { "gd", false }
      keys[#keys + 1] = { "gD", false }
    end,
    ---@class PluginLspOpts
    opts = {
      -- options for vim.lsp.buf.format
      -- `bufnr` and `filter` is handled by the LazyVim formatter,
      -- but can be also overridden when specified
      format = { timeout_ms = 6000 },
      autoformat = true,
      -- Enable this to show formatters used in a notification
      -- Useful for debugging formatter issues
      format_notify = true,
      ---@type lspconfig.options
      servers = {
        -- NB: may require `npm install --global cssmodules-language-server`
        cssmodules_ls = {
          capabilities = {
            -- Disable definiton-provider, prefer implementation-provider, to avoid race-condition
            definitionProvider = false,
          },
        },
        -- NB: may require `npm install --global vscode-langservers-extracted`
        cssls = {
          capabilities = {
            definitionProvider = false,
          },
        },
        -- efm = {
        --   mason = false,
        --   capabilities = {
        --     documentFormattingProvider = true,
        --     documentRangeFormattingProvider = true,
        --   }
        -- },
        tsserver = {
          capabilities = {
            documentFormattingProvider = false,
            documentRangeFormattingProvider = false,
          }
        },

      },
      -- setup = {
      --   efm = function(_, opts)
      --     require("lspconfig").efm.setup({
      --       filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
      --       cmd = { "efm-langserver", "-c", "/Users/jaye.heffernan/.config/efm-langserver/config.yaml" },
      --       init_options = { documentFormatting = true, documentRangeFormatting = true },
      --     })
      --     return true
      --   end,
      -- Specify * to use this function as a fallback for any server
      -- ["*"] = function(server, opts) end,
      -- },
    },
  },
  {
    "ldelossa/litee-calltree.nvim",
    config = function()
      require('litee.calltree').setup({})
    end,
    dependencies = {
      {
        'ldelossa/litee.nvim',
        config = function()
          require('litee.lib').setup({
            tree = {
              icon_set = "codicons"
            },
            panel = {
              orientation = "left",
              panel_size  = 100
            }
          })
        end
      }
    }
  }
}
