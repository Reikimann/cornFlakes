return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    spec = {
      { "<leader>q", ":q<CR>", desc = "Quit" },
      { "<leader>Q", ":wq<CR>", desc = "Save & Quit" },

      { "<leader>b", group = "Buffers" },
      { "<leader>bd", ":bdelete<CR>", desc = "Delete" },

      { "<leader>f", group = "File" },
      { "<leader>fS", ":so %<CR>", desc = "Source" },
      { "<leader>fs", ":w<CR>", desc = "Save" },

      { "<leader>l", group = "LSP" },
      { "<leader>li", ":LspInfo<cr>", desc = "Connected Language Servers" },
      { "<leader>lk", "<cmd>lua vim.lsp.buf.signature_help()<cr>", desc = "Signature Help" },
      { "<leader>lw", "<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>", desc = "Add Workspace Folder" },
      { "<leader>lW", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>", desc = "Remove Workspace Folder" },
      { "<leader>ll", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>", desc = "List Workspace Folders" },
      { "<leader>lr", "<cmd>lua vim.lsp.buf.references()<cr>", desc = "References" },
      { "<leader>lt", "<cmd>lua vim.lsp.buf.type_definition()<cr>", desc = "Type Definition" },
      { "<leader>ld", "<cmd>lua vim.lsp.buf.definition()<cr>", desc = "Go To Definition" },
      { "<leader>lD", "<cmd>lua vim.lsp.buf.declaration()<cr>", desc = "Go To Declaration" },

      { "<leader>o", group = "Operations" },
      { "<leader>ox", "<cmd>silent !chmod +x %<CR>", desc = "Make executable" },
      -- { "<leader>oo", "<cmd>up | !xdg-open %<CR>", desc = "Open program" },

      { "<leader>t", group = "Toggles" },
      { "<leader>tb", ":ToggleTerm<cr>", desc = "Split Below" },
      { "<leader>ts", ":Telescope colorscheme<CR>", desc = "Telescope Colorscheme" },
      {
        "<leader>tf",
        function()
          local Terminal = require("toggleterm.terminal").Terminal
          local float = Terminal:new({direction = "float"})
          return float:toggle()
        end,
        desc = "Floating Terminal" },
      {
        "<leader>tg",
        function()
          local Terminal = require("toggleterm.terminal").Terminal
          local lazygit = Terminal:new({cmd = "lazygit", direction = "float"})
          return lazygit:toggle()
        end,
        desc = "LazyGit"
      },
      { "<leader>tj", ":Telescope find_files<CR>", desc = "Telescope Find Files" },
      { "<leader>tm", ":Telescope noice<CR>", desc = "Telescope Messages" },
      { "<leader>to", ":Telescope oldfiles<CR>", desc = "Telescope Recent Files" },
      { "<leader>tr", ":Telescope live_grep<CR>", desc = "Telescope Live Grep" },

      { "<leader>p", ":Lazy<cr>", desc = "Lazy" },
    }
  }
}
