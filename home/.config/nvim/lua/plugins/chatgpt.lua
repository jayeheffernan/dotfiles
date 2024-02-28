local keymap = vim.keymap.set

local function keymapOptions(desc)
  return {
    noremap = true,
    silent = true,
    nowait = true,
    desc = "GPT " .. desc,
  }
end

return {
  {
    "robitx/gp.nvim",
    config = function()
      require("gp").setup({
        whisper_dir = "/tmp/gp_whisper",
        whisper_rec_cmd = { "ffmpeg", "-y", "-f", "avfoundation", "-i", ":1", "-t", "3600", "rec.wav" },
      })
      -- keymap("n", "<leader>aa", ":GpChatNew<CR>", { desc = "New" })
      -- keymap("n", "<leader>at", ":GpChatToggle<CR>", { desc = "Toggle" })
      -- keymap("n", "<leader>af", ":GpChatFind<CR>", { desc = "Find" })
      -- keymap("n", "<leader>a<Space>", ":GpChatRespond<CR>", { desc = "Respond" })
      --
      -- keymap("n", "<leader>as", ":GpStop<CR>", { desc = "Stop" })
      --
      -- keymap("x", "<leader>ar", ":GpRewrite<CR>", { desc = "Rewrite" })
      -- keymap("x", "<leader>aa", ":GpAppend<CR>", { desc = "Append" })
      -- keymap("x", "<leader>ai", ":GpImplement<CR>", { desc = "Implement" })
      --
      -- keymap("n", "<leader>va", ":GpWhisperAppend<CR>", { desc = "Whisper Append" })
      -- Chat commands
      vim.keymap.set({ "n", "i" }, "<Leader>ac", "<cmd>GpChatNew<cr>", keymapOptions("New Chat"))
      vim.keymap.set({ "n", "i" }, "<Leader>at", "<cmd>GpChatToggle<cr>", keymapOptions("Toggle Chat"))
      vim.keymap.set({ "n", "i" }, "<Leader>af", "<cmd>GpChatFinder<cr>", keymapOptions("Chat Finder"))

      vim.keymap.set("v", "<Leader>ac", ":<C-u>'<,'>GpChatNew<cr>", keymapOptions("Visual Chat New"))
      vim.keymap.set("v", "<Leader>ap", ":<C-u>'<,'>GpChatPaste<cr>", keymapOptions("Visual Chat Paste"))
      vim.keymap.set("v", "<Leader>at", ":<C-u>'<,'>GpChatToggle<cr>", keymapOptions("Visual Toggle Chat"))

      vim.keymap.set({ "n", "i" }, "<Leader>a<C-x>", "<cmd>GpChatNew split<cr>", keymapOptions("New Chat split"))
      vim.keymap.set({ "n", "i" }, "<Leader>a<C-v>", "<cmd>GpChatNew vsplit<cr>", keymapOptions("New Chat vsplit"))
      vim.keymap.set({ "n", "i" }, "<Leader>a<C-t>", "<cmd>GpChatNew tabnew<cr>", keymapOptions("New Chat tabnew"))

      vim.keymap.set("v", "<Leader>a<C-x>", ":<C-u>'<,'>GpChatNew split<cr>", keymapOptions("Visual Chat New split"))
      vim.keymap.set("v", "<Leader>a<C-v>", ":<C-u>'<,'>GpChatNew vsplit<cr>", keymapOptions("Visual Chat New vsplit"))
      vim.keymap.set("v", "<Leader>a<C-t>", ":<C-u>'<,'>GpChatNew tabnew<cr>", keymapOptions("Visual Chat New tabnew"))

      -- Prompt commands
      vim.keymap.set({ "n", "i" }, "<Leader>ar", "<cmd>GpRewrite<cr>", keymapOptions("Inline Rewrite"))
      vim.keymap.set({ "n", "i" }, "<Leader>aa", "<cmd>GpAppend<cr>", keymapOptions("Append (after)"))
      vim.keymap.set({ "n", "i" }, "<Leader>ab", "<cmd>GpPrepend<cr>", keymapOptions("Prepend (before)"))

      vim.keymap.set("v", "<Leader>ar", ":<C-u>'<,'>GpRewrite<cr>", keymapOptions("Visual Rewrite"))
      vim.keymap.set("v", "<Leader>aa", ":<C-u>'<,'>GpAppend<cr>", keymapOptions("Visual Append (after)"))
      vim.keymap.set("v", "<Leader>ab", ":<C-u>'<,'>GpPrepend<cr>", keymapOptions("Visual Prepend (before)"))
      vim.keymap.set("v", "<Leader>ai", ":<C-u>'<,'>GpImplement<cr>", keymapOptions("Implement selection"))

      vim.keymap.set({ "n", "i" }, "<Leader>agp", "<cmd>GpPopup<cr>", keymapOptions("Popup"))
      vim.keymap.set({ "n", "i" }, "<Leader>age", "<cmd>GpEnew<cr>", keymapOptions("GpEnew"))
      vim.keymap.set({ "n", "i" }, "<Leader>agn", "<cmd>GpNew<cr>", keymapOptions("GpNew"))
      vim.keymap.set({ "n", "i" }, "<Leader>agv", "<cmd>GpVnew<cr>", keymapOptions("GpVnew"))
      vim.keymap.set({ "n", "i" }, "<Leader>agt", "<cmd>GpTabnew<cr>", keymapOptions("GpTabnew"))

      vim.keymap.set("v", "<Leader>agp", ":<C-u>'<,'>GpPopup<cr>", keymapOptions("Visual Popup"))
      vim.keymap.set("v", "<Leader>age", ":<C-u>'<,'>GpEnew<cr>", keymapOptions("Visual GpEnew"))
      vim.keymap.set("v", "<Leader>agn", ":<C-u>'<,'>GpNew<cr>", keymapOptions("Visual GpNew"))
      vim.keymap.set("v", "<Leader>agv", ":<C-u>'<,'>GpVnew<cr>", keymapOptions("Visual GpVnew"))
      vim.keymap.set("v", "<Leader>agt", ":<C-u>'<,'>GpTabnew<cr>", keymapOptions("Visual GpTabnew"))

      vim.keymap.set({ "n", "i" }, "<Leader>ax", "<cmd>GpContext<cr>", keymapOptions("Toggle Context"))
      vim.keymap.set("v", "<Leader>ax", ":<C-u>'<,'>GpContext<cr>", keymapOptions("Visual Toggle Context"))

      vim.keymap.set({ "n", "i", "v", "x" }, "<Leader>as", "<cmd>GpStop<cr>", keymapOptions("Stop"))
      vim.keymap.set({ "n", "i", "v", "x" }, "<Leader>an", "<cmd>GpNextAgent<cr>", keymapOptions("Next Agent"))

      -- optional Whisper commands with prefix <Leader>aw
      vim.keymap.set({ "n", "i" }, "<Leader>vw", "<cmd>GpWhisper<cr>", keymapOptions("Whisper"))
      vim.keymap.set("v", "<Leader>vw", ":<C-u>'<,'>GpWhisper<cr>", keymapOptions("Visual Whisper"))

      vim.keymap.set({ "n", "i" }, "<Leader>vr", "<cmd>GpWhisperRewrite<cr>", keymapOptions("Whisper Inline Rewrite"))
      vim.keymap.set({ "n", "i" }, "<Leader>va", "<cmd>GpWhisperAppend<cr>", keymapOptions("Whisper Append (after)"))
      vim.keymap.set({ "n", "i" }, "<Leader>vb", "<cmd>GpWhisperPrepend<cr>", keymapOptions("Whisper Prepend (before) "))

      vim.keymap.set("v", "<Leader>vr", ":<C-u>'<,'>GpWhisperRewrite<cr>", keymapOptions("Visual Whisper Rewrite"))
      vim.keymap.set("v", "<Leader>va", ":<C-u>'<,'>GpWhisperAppend<cr>", keymapOptions("Visual Whisper Append (after)"))
      vim.keymap.set("v", "<Leader>vb", ":<C-u>'<,'>GpWhisperPrepend<cr>",
        keymapOptions("Visual Whisper Prepend (before)"))

      vim.keymap.set({ "n", "i" }, "<Leader>vp", "<cmd>GpWhisperPopup<cr>", keymapOptions("Whisper Popup"))
      vim.keymap.set({ "n", "i" }, "<Leader>ve", "<cmd>GpWhisperEnew<cr>", keymapOptions("Whisper Enew"))
      vim.keymap.set({ "n", "i" }, "<Leader>vn", "<cmd>GpWhisperNew<cr>", keymapOptions("Whisper New"))
      vim.keymap.set({ "n", "i" }, "<Leader>vv", "<cmd>GpWhisperVnew<cr>", keymapOptions("Whisper Vnew"))
      vim.keymap.set({ "n", "i" }, "<Leader>vt", "<cmd>GpWhisperTabnew<cr>", keymapOptions("Whisper Tabnew"))

      vim.keymap.set("v", "<Leader>vp", ":<C-u>'<,'>GpWhisperPopup<cr>", keymapOptions("Visual Whisper Popup"))
      vim.keymap.set("v", "<Leader>ve", ":<C-u>'<,'>GpWhisperEnew<cr>", keymapOptions("Visual Whisper Enew"))
      vim.keymap.set("v", "<Leader>vn", ":<C-u>'<,'>GpWhisperNew<cr>", keymapOptions("Visual Whisper New"))
      vim.keymap.set("v", "<Leader>vv", ":<C-u>'<,'>GpWhisperVnew<cr>", keymapOptions("Visual Whisper Vnew"))
      vim.keymap.set("v", "<Leader>vt", ":<C-u>'<,'>GpWhisperTabnew<cr>", keymapOptions("Visual Whisper Tabnew"))
    end,
  }
}
