return {
  {
    "lervag/vimtex",
    lazy = false,     -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
      vim.g.vimtex_view_method = 'zathura'
      vim.g.vimtex_compiler_method = 'latexmk'

      -- Most VimTeX mappings rely on localleader and this can be changed with the
      -- following line. The default is usually fine and is the symbol "".
      vim.g.maplocalleader = ","
      vim.g.vimtex_fold_enabled = 1
      vim.g.vimtex_view_forward_search_on_start = 0 -- Stops highlighting changes in zathura on start
      vim.g.vimtex_syntax_conceal = {        -- enable or disable specific conceals
        accents = 1,
        ligatures = 1,
        cites = 1,
        fancy = 1,
        spacing = 0,            -- default: 1
        greek = 1,
        math_bounds = 1,
        math_delimiters = 1,
        math_fracs = 1,
        math_super_sub = 1,
        math_symbols = 1,
        sections = 0,
        styles = 1,
        }
    end
  }
}
