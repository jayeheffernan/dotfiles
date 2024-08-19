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
        agents = {
          -- Disable ChatGPT 3.5
          {
            name = "ChatGPT3-5",
            chat = false,    -- just name would suffice
            command = false, -- just name would suffice
          },
          {
            name = "ChatGPT4",
            chat = true,
            command = true,
            -- chat_template = require("gp.defaults").chat_template,
            -- string with model name or table with model name and parameters
            model = "gpt-4",
            -- system prompt (use this to specify the persona/role of the AI)
            system_prompt = "You are a general AI assistant.\n\n"
                .. "The user provided the additional info about how they would like you to respond:\n\n"
                .. "- If you're unsure don't guess and say you don't know instead.\n"
                .. "- Ask question if you need clarification to provide better answer.\n"
                -- .. "- Think deeply and carefully from first principles step by step.\n"
                -- .. "- Zoom out first to see the big picture and then zoom in to details.\n"
                -- .. "- Use Socratic method to improve your thinking and coding skills.\n"
                .. "- Don't elide any code from your output if the answer requires coding.\n"
                .. "- Take a deep breath; You've got this!\n",
          },
        },
      })
      -- keymap("n", "<leader>aa", ":GpChatNew<CR>", { desc = "New" })
      -- keymap("n", "<leader>at", ":GpChatToggle<CR>", { desc = "Toggle" })
      -- keymap("n", "<leader>af", ":GpChatFind<CR>", { desc = "Find" })
      keymap("n", "<leader>a<Space>", ":GpChatRespond<CR>", { desc = "Respond" })
      --
      -- keymap("n", "<leader>as", ":GpStop<CR>", { desc = "Stop" })
      --
      -- keymap("x", "<leader>ar", ":GpRewrite<CR>", { desc = "Rewrite" })
      -- keymap("x", "<leader>aa", ":GpAppend<CR>", { desc = "Append" })
      -- keymap("x", "<leader>ai", ":GpImplement<CR>", { desc = "Implement" })
      --
      -- keymap("n", "<leader>va", ":GpWhisperAppend<CR>", { desc = "Whisper Append" })
      -- Chat commands
      -- local norm = { "n", "i" }
      local norm = "n"
      vim.keymap.set(norm, "<Leader>ac", "<cmd>GpChatNew<cr>", keymapOptions("New Chat"))
      vim.keymap.set(norm, "<Leader>at", "<cmd>GpChatToggle<cr>", keymapOptions("Toggle Chat"))
      vim.keymap.set(norm, "<Leader>af", "<cmd>GpChatFinder<cr>", keymapOptions("Chat Finder"))

      vim.keymap.set("v", "<Leader>ac", ":<C-u>'<,'>GpChatNew<cr>", keymapOptions("Visual Chat New"))
      vim.keymap.set("v", "<Leader>ap", ":<C-u>'<,'>GpChatPaste<cr>", keymapOptions("Visual Chat Paste"))
      vim.keymap.set("v", "<Leader>at", ":<C-u>'<,'>GpChatToggle<cr>", keymapOptions("Visual Toggle Chat"))

      vim.keymap.set(norm, "<Leader>a<C-x>", "<cmd>GpChatNew split<cr>", keymapOptions("New Chat split"))
      vim.keymap.set(norm, "<Leader>a<C-v>", "<cmd>GpChatNew vsplit<cr>", keymapOptions("New Chat vsplit"))
      vim.keymap.set(norm, "<Leader>a<C-t>", "<cmd>GpChatNew tabnew<cr>", keymapOptions("New Chat tabnew"))

      vim.keymap.set("v", "<Leader>a<C-x>", ":<C-u>'<,'>GpChatNew split<cr>", keymapOptions("Visual Chat New split"))
      vim.keymap.set("v", "<Leader>a<C-v>", ":<C-u>'<,'>GpChatNew vsplit<cr>", keymapOptions("Visual Chat New vsplit"))
      vim.keymap.set("v", "<Leader>a<C-t>", ":<C-u>'<,'>GpChatNew tabnew<cr>", keymapOptions("Visual Chat New tabnew"))

      -- Prompt commands
      vim.keymap.set(norm, "<Leader>ar", "<cmd>GpRewrite<cr>", keymapOptions("Inline Rewrite"))
      vim.keymap.set(norm, "<Leader>aa", "<cmd>GpAppend<cr>", keymapOptions("Append (after)"))
      vim.keymap.set(norm, "<Leader>ab", "<cmd>GpPrepend<cr>", keymapOptions("Prepend (before)"))

      vim.keymap.set("v", "<Leader>ar", ":<C-u>'<,'>GpRewrite<cr>", keymapOptions("Visual Rewrite"))
      vim.keymap.set("v", "<Leader>aa", ":<C-u>'<,'>GpAppend<cr>", keymapOptions("Visual Append (after)"))
      vim.keymap.set("v", "<Leader>ab", ":<C-u>'<,'>GpPrepend<cr>", keymapOptions("Visual Prepend (before)"))
      vim.keymap.set("v", "<Leader>ai", ":<C-u>'<,'>GpImplement<cr>", keymapOptions("Implement selection"))

      vim.keymap.set(norm, "<Leader>agp", "<cmd>GpPopup<cr>", keymapOptions("Popup"))
      vim.keymap.set(norm, "<Leader>age", "<cmd>GpEnew<cr>", keymapOptions("GpEnew"))
      vim.keymap.set(norm, "<Leader>agn", "<cmd>GpNew<cr>", keymapOptions("GpNew"))
      vim.keymap.set(norm, "<Leader>agv", "<cmd>GpVnew<cr>", keymapOptions("GpVnew"))
      vim.keymap.set(norm, "<Leader>agt", "<cmd>GpTabnew<cr>", keymapOptions("GpTabnew"))

      vim.keymap.set("v", "<Leader>agp", ":<C-u>'<,'>GpPopup<cr>", keymapOptions("Visual Popup"))
      vim.keymap.set("v", "<Leader>age", ":<C-u>'<,'>GpEnew<cr>", keymapOptions("Visual GpEnew"))
      vim.keymap.set("v", "<Leader>agn", ":<C-u>'<,'>GpNew<cr>", keymapOptions("Visual GpNew"))
      vim.keymap.set("v", "<Leader>agv", ":<C-u>'<,'>GpVnew<cr>", keymapOptions("Visual GpVnew"))
      vim.keymap.set("v", "<Leader>agt", ":<C-u>'<,'>GpTabnew<cr>", keymapOptions("Visual GpTabnew"))

      vim.keymap.set(norm, "<Leader>ax", "<cmd>GpContext<cr>", keymapOptions("Toggle Context"))
      vim.keymap.set("v", "<Leader>ax", ":<C-u>'<,'>GpContext<cr>", keymapOptions("Visual Toggle Context"))

      vim.keymap.set({ "n", "v", "x" }, "<Leader>as", "<cmd>GpStop<cr>", keymapOptions("Stop"))
      vim.keymap.set({ "n", "v", "x" }, "<Leader>an", "<cmd>GpNextAgent<cr>", keymapOptions("Next Agent"))

      -- optional Whisper commands with prefix <Leader>aw
      vim.keymap.set(norm, "<Leader>aww", "<cmd>GpWhisper<cr>", keymapOptions("Whisper"))
      vim.keymap.set("v", "<Leader>aww", ":<C-u>'<,'>GpWhisper<cr>", keymapOptions("Visual Whisper"))

      vim.keymap.set(norm, "<Leader>awr", "<cmd>GpWhisperRewrite<cr>", keymapOptions("Whisper Inline Rewrite"))
      vim.keymap.set(norm, "<Leader>awa", "<cmd>GpWhisperAppend<cr>", keymapOptions("Whisper Append (after)"))
      vim.keymap.set(norm, "<Leader>awb", "<cmd>GpWhisperPrepend<cr>", keymapOptions("Whisper Prepend (before) "))

      vim.keymap.set("v", "<Leader>awr", ":<C-u>'<,'>GpWhisperRewrite<cr>", keymapOptions("Visual Whisper Rewrite"))
      vim.keymap.set("v", "<Leader>awa", ":<C-u>'<,'>GpWhisperAppend<cr>", keymapOptions("Visual Whisper Append (after)"))
      vim.keymap.set("v", "<Leader>awb", ":<C-u>'<,'>GpWhisperPrepend<cr>",
        keymapOptions("Visual Whisper Prepend (before)"))

      vim.keymap.set(norm, "<Leader>awp", "<cmd>GpWhisperPopup<cr>", keymapOptions("Whisper Popup"))
      vim.keymap.set(norm, "<Leader>awe", "<cmd>GpWhisperEnew<cr>", keymapOptions("Whisper Enew"))
      vim.keymap.set(norm, "<Leader>awn", "<cmd>GpWhisperNew<cr>", keymapOptions("Whisper New"))
      vim.keymap.set(norm, "<Leader>awv", "<cmd>GpWhisperVnew<cr>", keymapOptions("Whisper Vnew"))
      vim.keymap.set(norm, "<Leader>awt", "<cmd>GpWhisperTabnew<cr>", keymapOptions("Whisper Tabnew"))

      vim.keymap.set("v", "<Leader>awp", ":<C-u>'<,'>GpWhisperPopup<cr>", keymapOptions("Visual Whisper Popup"))
      vim.keymap.set("v", "<Leader>awe", ":<C-u>'<,'>GpWhisperEnew<cr>", keymapOptions("Visual Whisper Enew"))
      vim.keymap.set("v", "<Leader>awn", ":<C-u>'<,'>GpWhisperNew<cr>", keymapOptions("Visual Whisper New"))
      vim.keymap.set("v", "<Leader>awv", ":<C-u>'<,'>GpWhisperVnew<cr>", keymapOptions("Visual Whisper Vnew"))
      vim.keymap.set("v", "<Leader>awt", ":<C-u>'<,'>GpWhisperTabnew<cr>", keymapOptions("Visual Whisper Tabnew"))
    end,
  }
}
