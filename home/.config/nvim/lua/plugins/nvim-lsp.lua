return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      format = { timeout_ms = 6000 },
      autoformat = true,
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
        efm = {
          mason = false,
          capabilities = {
            documentFormattingProvider = true,
            documentRangeFormattingProvider = true,
          }
        },
        tsserver = {
          capabilities = {
            documentFormattingProvider = false,
            documentRangeFormattingProvider = false,
          }
        }
      },
      setup = {
        efm = function(_, opts)
          require("lspconfig").efm.setup({
            filetypes = { "javascript", "typescript" },
            cmd = { "efm-langserver", "-c", "/Users/jaye.heffernan/.config/efm-langserver/config.yaml" },
          })
          return true
        end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },
  },
}
