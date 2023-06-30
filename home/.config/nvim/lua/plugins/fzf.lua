-- This script directory
local sdir = vim.fn.expand("<sfile>:p:h") .. "/lua/plugins/"

return {
  {
    "junegunn/fzf",
    init = function()
      vim.cmd({ cmd = "source", args = { sdir .. "./fzf.init.vim" } })
      vim.g.fzf_layout = { window = { width = 0.9, height = 0.9 } }
    end,
    keys = function()
      local Util = require("lazyvim.util")
      return {
        { "<C-p>", ":Files<CR>", { desc = "Find files" } },
        { "<localleader>ss", ":Rg ", desc = "Search (rg, cwd)" },
        { "<localleader>sS", ":PRg ", desc = "Search (rg, dir)" },
        { "<localleader>sw", ":Rg <C-r><C-w>", desc = "Word (cwd)" },
        { "<localleader>sW", ":PRg <C-r><C-w>", desc = "Word word (root dir)" },
        -- -- find
        {
          "<localleader>fb",
          function()
            vim.cmd("Buffers")
          end,
          desc = "Buffers",
        },
        {
          "<localleader>ff",
          function()
            vim.cmd("Files")
          end,
          desc = "Find Files (cwd)",
        },
        {
          "<localleader>fF",
          function()
            vim.cmd({ cmd = "Files", args = { Util.get_root() }, bang = true })
          end,
          desc = "Find Files (root dir)",
        },
        {
          "<localleader>fr",
          function()
            vim.cmd("History")
          end,
          desc = "Recent",
        },
        -- { "<localleader>fR", Util.telescope("oldfiles", { cwd = vim.loop.cwd() }), desc = "Recent (cwd)" },
        -- -- git
        {
          "<localleader>sgc",
          function()
            vim.cmd("Commits")
          end,
          desc = "commits",
        },
        {
          "<localleader>sgs",
          function()
            vim.cmd("GFiles?")
          end,
          desc = "status",
        },
        -- -- search
        -- { "<localleader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
        {
          "<localleader>sb",
          function()
            vim.cmd("BLines")
          end,
          desc = "Buffer",
        },
        {
          "<localleader>sc",
          function()
            vim.cmd("History:")
          end,
          desc = "Command History",
        },
        {
          "<localleader>sC",
          function()
            vim.cmd("Commands")
          end,
          desc = "Commands",
        },
        {
          "<localleader>sf",
          function()
            vim.cmd("RG")
          end,
          desc = "Find/Grep (cwd)",
        },
        {
          "<localleader>sF",
          function()
            vim.cmd("PRG")
          end,
          desc = "Find/Grep (root dir)",
        },

        -- Left-over mappings, not ported from LazyVim's Telescope equivalents
        -- { "<localleader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document diagnostics" },
        -- { "<localleader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
        -- { "<localleader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
        -- { "<localleader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
        -- { "<localleader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
        -- { "<localleader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
        -- { "<localleader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
        -- { "<localleader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
        -- { "<localleader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
        -- {
        --   "<localleader>uC",
        --   Util.telescope("colorscheme", { enable_preview = true }),
        --   desc = "Colorscheme with preview",
        -- },
        -- {
        --   "<localleader>ss",
        --   Util.telescope("lsp_document_symbols", {
        --     symbols = {
        --       "Class",
        --       "Function",
        --       "Method",
        --       "Constructor",
        --       "Interface",
        --       "Module",
        --       "Struct",
        --       "Trait",
        --       "Field",
        --       "Property",
        --     },
        --   }),
        --   desc = "Goto Symbol",
        -- },
        -- {
        --   "<localleader>sS",
        --   Util.telescope("lsp_dynamic_workspace_symbols", {
        --     symbols = {
        --       "Class",
        --       "Function",
        --       "Method",
        --       "Constructor",
        --       "Interface",
        --       "Module",
        --       "Struct",
        --       "Trait",
        --       "Field",
        --       "Property",
        --     },
        --   }),
        --   desc = "Goto Symbol (Workspace)",
        -- },
      }
    end,
  },
  { "junegunn/fzf.vim" },
  { "gfanto/fzf-lsp.nvim" },
}
