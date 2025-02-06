return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = true,
  event = "VeryLazy",
  -- stylua: ignore
  keys = {
    { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
    { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
    { "<leader>tt", "<cmd>TodoTrouble<cr>", desc = "Trouble" },
    { "<leader>tT", "<cmd>TodoTelescope<cr>", desc = "Trouble (Telescope)" },
  },
}
