require'nvim-tree'.setup {
  disable_netrw       = true,
  hijack_netrw        = true,
  open_on_tab         = false,
  hijack_cursor       = false,
  update_cwd          = false,
  diagnostics = {
    enable = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  renderer = {
    indent_markers = {
      enable = true,
      icons = {
        corner = "╰",
        edge = "│ ",
        none = "  ",
      },
    },
  },
  update_focused_file = {
    enable      = false,
    update_cwd  = false,
    ignore_list = {}
  },
  system_open = {
    cmd  = nil,
    args = {}
  },
  filters = {
    custom = { "^.git$" },
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 500,
  },
  view = {
    width = 25,
    hide_root_folder = false,
    side = 'left',
    signcolumn = "yes",
    mappings = {
      custom_only = false,
      list = {},
    },
    number = false,
    relativenumber = false,
  },
  trash = {
    cmd = "trash",
    require_confirm = true,
  },
}

--vim.g.nvim_tree_indent_markers = 1
