return {
  {
    "epwalsh/obsidian.nvim",
    lazy = true,
    -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand':
    event = { "BufReadPre " .. vim.fn.expand("~") .. "/Documents/Fall-2023-notes/**.md" },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",

      -- see below for full list of optional dependencies 👇
    },
    opts = {
      dir = "~/Documents/Fall-2023-notes/", -- no need to call 'vim.fn.expand' here
      daily_notes = {
        folder = "daily",
      },
      completion = {
        nvim_cmp = true,
      },
      -- see below for full list of options 👇
    },
    config = function(_, opts)
      require("obsidian").setup(opts)

      vim.keymap.set("n", "gf", function()
        if require("obsidian").util.cursor_on_markdown_link() then
          return "<cmd>ObsidianFollowLink<CR>"
        else
          return "gf"
        end
      end, { noremap = false, expr = true })
    end,
  },
}
