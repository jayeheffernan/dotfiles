vim.cmd('source ~/.vimrc')

vim.g.dap_virtual_text = true

require('dapui').setup()
-- require('telescope').setup()
-- require('telescope').load_extension('dap')
require("nvim-dap-virtual-text").setup()

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = false,
    disable = {},
  },
  ensure_installed = {
    "tsx",
    "javascript",
    "typescript",
    "toml",
    "bash",
    "json",
    "yaml",
    "html",
    "scss"
  },
}
local ft_to_parser = require"nvim-treesitter.parsers".filetype_to_parsername
ft_to_parser.typescriptreact = "tsx"

local dap = require('dap')

dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = {os.getenv('HOME') .. '/.builds/vscode-node-debug2/out/src/nodeDebug.js'},
}

dap.configurations.javascript = {
  {
    type = 'node2',
    request = 'attach',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
  port = 9229,
     smartStep= true,
     skipFiles= {'<node_internals>/**',
       'node_modules/**',
       '${workspaceFolder}/lib/cls/**',
       '${workspaceFolder}/backends/index.js',
       '${workspaceFolder}/backends/*/index.js',
       '${workspaceFolder}/backends/_integrations/*/index.js'
     },
     outFiles= {'${workspaceFolder}/dist/server/**/*.js'},
     sourceMapPathOverrides= {
       [ 'webpack://sleeping-duck/./*' ]= '${workspaceFolder}/*',
       [ 'webpack://sleeping-duck/*' ]= '*'
     }
  },
}

dap.configurations.typescript = dap.configurations.javascript
dap.configurations.typescriptreact = dap.configurations.typescript

-- require'lightspeed'.setup {
--   ignore_case = false,
--   exit_after_idle_msecs = { unlabeled = 1000, labeled = nil },
--   --- s/x ---
--   jump_to_unique_chars = { safety_timeout = 400 },
--   match_only_the_start_of_same_char_seqs = true,
--   force_beacons_into_match_width = false,
--   -- Display characters in a custom way in the highlighted matches.
--   substitute_chars = { ['\r'] = '¬', },
--   -- Leaving the appropriate list empty effectively disables "smart" mode,
--   -- and forces auto-jump to be on or off.
--   -- safe_labels = { . . . },
--   -- labels = { . . . },
--   -- These keys are captured directly by the plugin at runtime.
--   special_keys = {
--     next_match_group = '<space>',
--     prev_match_group = '<tab>',
--   },
--   --- f/t ---
--   limit_ft_matches = 4,
--   repeat_ft_with_target_char = false,
-- }

require('refactoring').setup({})

-- Remaps for the refactoring operations currently offered by the plugin
vim.api.nvim_set_keymap("v", "<localleader>Rf", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]], {noremap = true, silent = true, expr = false})
vim.api.nvim_set_keymap("v", "<localleader>RF", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]], {noremap = true, silent = true, expr = false})
vim.api.nvim_set_keymap("v", "<localleader>Rv", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]], {noremap = true, silent = true, expr = false})
vim.api.nvim_set_keymap("v", "<localleader>Ri", [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]], {noremap = true, silent = true, expr = false})
-- Extract block doesn't need visual mode
vim.api.nvim_set_keymap("n", "<localleader>Rb", [[ <Cmd>lua require('refactoring').refactor('Extract Block')<CR>]], {noremap = true, silent = true, expr = false})
vim.api.nvim_set_keymap("n", "<localleader>RB", [[ <Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>]], {noremap = true, silent = true, expr = false})
-- Inline variable can also pick up the identifier currently under the cursor without visual mode
vim.api.nvim_set_keymap("n", "<localleader>Ri", [[ <Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]], {noremap = true, silent = true, expr = false})

