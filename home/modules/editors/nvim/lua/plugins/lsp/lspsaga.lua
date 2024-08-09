return {
  -- Documentation: https://nvimdev.github.io/lspsaga/
  'nvimdev/lspsaga.nvim',
  event = { "LspAttach" },
  config = function()
    require('lspsaga').setup({
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
    })
  end,
  dependencies = {
    'nvim-treesitter/nvim-treesitter', -- optional
    'nvim-tree/nvim-web-devicons',     -- optional
  }
}
