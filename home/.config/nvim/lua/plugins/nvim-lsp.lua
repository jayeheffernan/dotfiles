vim.lsp.set_log_level("debug")
local lspconfig = require("lspconfig")
local util = require("lspconfig.util")
local configs = require("lspconfig.configs")

-- Check if it's already defined for when reloading this file.
-- print(vim.inspect(configs))
if not configs.emmet_language_server then
  configs.emmet_language_server = {
    -- capabilities = vim.lsp.protocol.make_client_capabilities(),
    default_config = {
      cmd = { "emmet-language-server", "--stdio" },
      root_dir = util.find_git_ancestor,
      -- autostart = true,
      -- single_file_support = true,
      -- name = "emmet_language_server",
      filetypes = {
        "astro",
        "css",
        "eruby",
        "html",
        "htmldjango",
        "javascript",
        "javascriptreact",
        "less",
        "pug",
        "sass",
        "scss",
        "svelte",
        "typescript",
        "typescriptreact",
        "vue",
      },
      init_options = {
        --- @type table<string, any> https://docs.emmet.io/customization/preferences/
        preferences = {},
        --- @type "always" | "never" Defaults to `"always"`
        showExpandedAbbreviation = "always",
        --- @type boolean Defaults to `true`
        showAbbreviationSuggestions = true,
        --- @type boolean Defaults to `false`
        showSuggestionsAsSnippets = true,
        --- @type table<string, any> https://docs.emmet.io/customization/syntax-profiles/
        syntaxProfiles = {},
        --- @type table<string, string> https://docs.emmet.io/customization/snippets/#variables
        variables = {},
        --- @type string[]
        excludeLanguages = {},
      },
    },
  }
end

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
        -- NB: may npm i -g @olrtg/emmet-language-server
        emmet_language_server = {},
      },
    },
  },
}
