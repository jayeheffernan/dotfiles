local keymap = vim.keymap.set

return {
  {
    "robitx/gp.nvim",
    config = function()
      require("gp").setup({
        whisper_dir = "/tmp/gp_whisper",
        whisper_rec_cmd = { "ffmpeg", "-y", "-f", "avfoundation", "-i", ":1", "-t", "3600", "rec.wav" },
      })
    end,
  }
}
