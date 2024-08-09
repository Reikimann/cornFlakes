return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    cmd = { "LspInfo", "LspStart", "LspRestart" },
    dependencies = {
      { "folke/lazydev.nvim", ft = "lua" },
      -- "stevearc/conform.nvim" -- TODO: Setup conform formatting
      -- https://github.com/ericlovesmath/dotfiles/blob/master/.config/nvim/lua/plugins/lsp.lua
    },
    config = function()
      local nvim_lsp = require("lspconfig")
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      -- suggested by nvim-ufo
      -- Add additional capabilities supported by nvim-cmp
      -- nvim hasn't added foldingRange to default capabilities, users must add it manually
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }

      local signs = { Error = "", Warn = "", Hint = "", Info = "" }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = true,
        severity_sort = false,
      })
      -- TODO: Setup:
      --   "ltex"
      --   "texlab"
      -- Good source of nix nvim setup
      -- https://github.com/Ruixi-rebirth/melted-flakes/blob/31f8805ee48b59ea87d8962b25a9d96b8e7cfdbd/modules/editors/nvim/lua/plugins/lsp.lua

      require("lazydev").setup()
      nvim_lsp.lua_ls.setup {
        capabilities = capabilities,
      }

      nvim_lsp.nixd.setup {
        capabilities = capabilities,
      }

      nvim_lsp.rust_analyzer.setup({
        capabilities = capabilities,
      })

      nvim_lsp.gopls.setup({
        capabilities = capabilities,
      })

      nvim_lsp.pyright.setup({
        capabilities = capabilities,
      })

      nvim_lsp.html.setup({
        capabilities = capabilities,
        cmd = { "vscode-html-language-server", "--stdio" },
      })

      nvim_lsp.cssls.setup({
        capabilities = capabilities,
        cmd = { "vscode-css-language-server", "--stdio" },
      })

      nvim_lsp.tsserver.setup({
        capabilities = capabilities,
        cmd = { "typescript-language-server", "--stdio" },
      })

      nvim_lsp.jsonls.setup({
        capabilities = capabilities,
        cmd = { "vscode-json-language-server", "--stdio" },
      })
    end,
  },
}
