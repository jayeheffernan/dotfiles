return {
  {
    "robitx/gp.nvim",
    config = function()
      require("gp").setup({
        whisper_dir = "/tmp/gp_whisper",
        whisper_rec_cmd = "sox",
      })
    end,
  }
}
