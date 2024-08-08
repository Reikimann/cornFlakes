return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    cmd = { "LspInfo", "LspStart", "LspRestart", "Mason" },
    dependencies = {
      -- { "folke/lazydev.nvim", ft = "lua" },
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      -- "stevearc/conform.nvim" -- TODO: Setup conform formatting
      -- https://github.com/ericlovesmath/dotfiles/blob/master/.config/nvim/lua/plugins/lsp.lua
    },
    config = function()
      -- require("lazydev").setup()

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      -- capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

      require("mason").setup()
      require("mason-lspconfig").setup()
      require("mason-lspconfig").setup_handlers({
        function(server_name)
          require("lspconfig")[server_name].setup {
            capabilities = capabilities
          }
        end,

        ["lua_ls"] = function()
          require("")
        end
      })
    end,
  },
}
