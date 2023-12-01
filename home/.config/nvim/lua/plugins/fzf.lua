-- This script directory
local sdir = vim.fn.expand("<sfile>:p:h") .. "/lua/plugins/"

return {
  {
    "junegunn/fzf",
    init = function()
      vim.cmd({ cmd = "source", args = { sdir .. "./fzf.init.vim" } })
      vim.g.fzf_layout = { window = { width = 0.7, height = 0.9 } }
    end,
    keys = function()
      local Util = require("lazyvim.util")

      local isFullscreen = false
      local toggleIsFullscreen = function()
        isFullscreen = not isFullscreen
      end
      -- fzf.vim commands use bang to activate as full-screen
      local getBang = function()
        if isFullscreen then
          return "!"
        end
        return ""
      end

      return {
        {
          "<leader>uF",
          desc = "FZF",
        },
        {
          "<leader>uFf",
          toggleIsFullscreen,
          desc = "Fullscreen",
        },
        {
          "<localleader>ss",
          function()
            vim.fn.feedkeys(":Rg" .. getBang() .. " ")
          end,
          desc = "Search (rg, cwd)",
        },
        {
          "<localleader>sS",
          function()
            vim.fn.feedkeys(":PRg" .. getBang() .. " ")
          end,
          desc = "Search (rg, dir)",
        },
        {
          "<localleader>sw",
          function()
            vim.fn.feedkeys(":Rg" .. getBang() .. " \\b" .. vim.fn.expand("<cword>") .. "\\b")
          end,
          desc = "Word (cwd)",
        },
        {
          "<localleader>fw",
          function()
            local search = "" .. vim.fn.expand("<cword>") .. " "
            vim.cmd({ cmd = "Files", bang = isFullscreen })
            vim.fn.feedkeys(search)
          end,
          desc = "Find Files by word (cwd)",
        },
        {
          "<localleader>fW",
          function()
            local search = "" .. vim.fn.expand("<cword>") .. " "
            vim.cmd({ cmd = "Files", args = { Util.get_root() }, bang = isFullscreen })
            vim.fn.feedkeys(search)
          end,
          desc = "Find Files by word (root dir)",
        },
        {
          "<localleader>sW",
          function()
            vim.fn.feedkeys(":PRg" .. getBang() .. " \\b" .. vim.fn.expand("<cword>") .. "\\b")
          end,
          desc = "Word (root dir)",
        },
        {
          -- analogous to "g*" - don't include word boundaries in search
          "<localleader>sgw",
          function()
            vim.fn.feedkeys(":Rg" .. getBang() .. " " .. vim.fn.expand("<cword>"))
          end,
          desc = "Word (cwd)",
        },
        {
          "<localleader>sgW",
          function()
            vim.fn.feedkeys(":PRg" .. getBang() .. " " .. vim.fn.expand("<cword>"))
          end,
          desc = "Word (root dir)",
        },
        -- -- find
        {
          "<localleader>fb",
          function()
            vim.cmd({ cmd = "Buffers", bang = isFullscreen })
          end,
          desc = "Buffers",
        },
        -- {
        --   "<C-p>",
        --   function()
        --     vim.cmd({ cmd = "Files", bang = isFullscreen })
        --   end,
        --   desc = "Find Files (cwd)",
        -- },
        {
          "<localleader>fc",
          function()
            vim.cmd({ cmd = "Files", args = { "~/.config/nvim/lua/" }, bang = isFullscreen })
          end,
          desc = "Find config (plugin) files",
        },
        {
          "<localleader>fd",
          function()
            vim.cmd({ cmd = "Files", args = { "~/.dotfiles" }, bang = isFullscreen })
          end,
          desc = "Find dotfiles",
        },
        {
          "<localleader>ff",
          function()
            vim.cmd({ cmd = "Files", bang = isFullscreen })
          end,
          desc = "Find Files (cwd)",
        },
        {
          "<localleader>fF",
          function()
            vim.cmd({ cmd = "Files", args = { Util.get_root() }, bang = isFullscreen })
          end,
          desc = "Find Files (root dir)",
        },
        {
          "<localleader>fr",
          function()
            vim.cmd({ cmd = "History", bang = isFullscreen })
          end,
          desc = "Recent",
        },
        -- { "<localleader>fR", Util.telescope("oldfiles", { cwd = vim.loop.cwd() }), desc = "Recent (cwd)" },
        -- -- git
        {
          "<localleader>sgc",
          function()
            vim.cmd({ cmd = "Commits", bang = isFullscreen })
          end,
          desc = "commits",
        },
        {
          "<localleader>sgs",
          function()
            vim.cmd({ cmd = "GFiles?", bang = isFullscreen })
          end,
          desc = "status",
        },
        -- -- search
        -- { "<localleader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
        {
          "<localleader>sb",
          function()
            vim.cmd({ cmd = "BLines", bang = isFullscreen })
          end,
          desc = "Buffer",
        },
        {
          "<localleader>sc",
          function()
            vim.cmd({ cmd = "History:", bang = isFullscreen })
          end,
          desc = "Command History",
        },
        {
          "<localleader>sC",
          function()
            vim.cmd({ cmd = "Commands", bang = isFullscreen })
          end,
          desc = "Commands",
        },
        {
          "<localleader>sf",
          function()
            vim.cmd({ cmd = "RG", bang = isFullscreen })
          end,
          desc = "Find/Grep (cwd)",
        },
        {
          "<localleader>sF",
          function()
            vim.cmd({ cmd = "PRG", bang = isFullscreen })
          end,
          desc = "Find/Grep (root dir)",
        },

        {
          "<leader>zF",
          function()
            vim.cmd({ cmd = "WikiRG", bang = isFullscreen })
          end,
          desc = "Find/Grep",
        },
        {
          "<leader>zf",
          function()
            vim.cmd({ cmd = "Files", args = { "~/.vimwiki/notes" }, bang = isFullscreen })
          end,
          desc = "Find files",
        },
        {
          "gr",
          function()
            vim.cmd({ cmd = "References", bang = isFullscreen });
            vim.fn.feedkeys("!import ");
          end,
          desc = "Find references",
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
  { "zackhsi/fzf-tags" },
}
