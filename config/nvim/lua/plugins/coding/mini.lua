-- TODO: Integrate a lot of mini.nvim plugins
return {
  "echasnovski/mini.nvim",
  version = false,
  config = function()
    require('mini.pairs').setup()
  end,
}
