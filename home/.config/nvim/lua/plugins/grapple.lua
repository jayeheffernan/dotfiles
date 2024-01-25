local keymap = vim.keymap.set

return {
  {
    "cbochs/grapple.nvim",
    main = "grapple",
    opts = function(_, opts)
      opts.scope = require("grapple").resolvers.git_branch
      -- opts.scope = require("grapple").resolvers.git_branch_suffix
    end,
    init = function()
      -- trsa keys are used as 1234 tags
      keymap("n", "<leader>mt", function()
        require("grapple").select({ key = 1 })
      end, { desc = "Jump 1" })

      keymap("n", "<leader>ms", function()
        require("grapple").select({ key = 2 })
      end, { desc = "Jump 2" })

      keymap("n", "<leader>mr", function()
        require("grapple").select({ key = 3 })
      end, { desc = "Jump 3" })

      keymap("n", "<leader>ma", function()
        require("grapple").select({ key = 4 })
      end, { desc = "Jump 4" })

      keymap("n", "<leader>mm", function() require("grapple").tag() end, { desc = "Tag" })
      keymap("n", "<leader>mM", function() require("grapple").untag() end, { desc = "Untag" })
      keymap("n", "<leader>me", function() vim.cmd("GrapplePopup tags") end, { desc = "Edit tags" })
    end
  }
}
