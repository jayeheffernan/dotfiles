return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        marksman = {
          filetypes = {
            "markdown",
          },
        },
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
      },
    },
  },
}
