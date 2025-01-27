return {
  -- Documentation: https://nvimdev.github.io/lspsaga/
  'nvimdev/lspsaga.nvim',
  event = { "LspAttach" },
  dependencies = {
    'nvim-treesitter/nvim-treesitter', -- optional
    'nvim-tree/nvim-web-devicons',     -- optional
  },
  keys = {
    { "<M-u>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1, '<c-u>')<cr>", silent = true },
    { "<M-d>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1, '<c-d>')<cr>", silent = true },
    { "<leader>lK", "<cmd>Lspsaga hover_doc<cr>", desc = "Hover Commands" },
    { "<leader>lp", "<cmd>Lspsaga peek_definition<cr>", desc = "Preview Definition" },
    { "<leader>lR", "<cmd>Lspsaga rename<cr>", desc = "Rename" },
    { "<leader>la", "<cmd>Lspsaga code_action<cr>", desc = "Code Action" },
    { "<leader>ln", "<cmd>Lspsaga diagnostic_jump_next<cr>", desc = "Go To Next Diagnostic" },
    { "<leader>lN", "<cmd>Lspsaga diagnostic_jump_prev<cr>", desc = "Go To Previous Diagnostic" },
  },
  opts = {
    ui = {
      code_action = ""
    },
    scroll_preview = {
      scroll_down = '<C-j>',
      scroll_up = '<C-k>',
    },
    lightbulb = {
      enable = false,
    }
  }
}
