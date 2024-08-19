local keymap = vim.keymap.set

return {
  {
    "cbochs/grapple.nvim",
    main = "grapple",
    dependencies = {
      { "nvim-tree/nvim-web-devicons", lazy = true }
    },
    config = function()
      local opts = {
        scope = "git_branch_fast",
        scopes = {
          git_branch_fast = {
            name = "git_branch_fast",
            desc = "Git root directory and branch, at startup",
            fallback = "static",
            cache = {
              event = { "VimEnter" },
              debounce = 0, -- ms
            },
            resolver = function()
              -- TODO: this will stop on submodules, needs fixing
              local git_files = vim.fs.find(".git", { upward = true, stop = vim.loop.os_homedir() })
              if #git_files == 0 then
                return
              end

              local root = vim.fn.fnamemodify(git_files[1], ":h")

              -- TODO: Don't use vim.system, it's a nvim-0.10 feature
              -- TODO: Don't shell out, read the git head or something similar
              local result = vim.fn.system({ "git", "symbolic-ref", "--short", "HEAD" })
              local branch = vim.trim(string.gsub(result, "\n", ""))

              local id = string.format("%s:%s", root, branch)
              local path = root

              return id, path
            end,
          }
        },
      };

      require("grapple").setup(opts)

      -- trsa keys are used as 1234 tags
      keymap("n", "<leader>mt", function()
        require("grapple").select({ index = 1 })
      end, { desc = "Jump 1" })

      keymap("n", "<leader>ms", function()
        require("grapple").select({ index = 2 })
      end, { desc = "Jump 2" })

      keymap("n", "<leader>mr", function()
        require("grapple").select({ index = 3 })
      end, { desc = "Jump 3" })

      keymap("n", "<leader>ma", function()
        require("grapple").select({ index = 4 })
      end, { desc = "Jump 4" })

      keymap("n", "<leader>mm", function() require("grapple").tag() end, { desc = "Tag" })
      keymap("n", "<leader>mM", function() require("grapple").untag() end, { desc = "Untag" })
      keymap("n", "<leader>me", function() vim.cmd("Grapple open_tags") end, { desc = "Edit tags" })
    end
  }
}
