return {
  {
    "crnvl96/lazydocker.nvim",
    event = "VeryLazy",
    opts = {},
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    vim.keymap.set(
      "n",
      "<leader>dd",
      "<cmd>LazyDocker<CR>",
      { desc = "Toggle LazyDocker", noremap = true, silent = true }
    ),
  },
}
