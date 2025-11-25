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

      nvim_lsp.ts_ls.setup({
        capabilities = capabilities,
        cmd = { "typescript-language-server", "--stdio" },
      })

      nvim_lsp.svelte.setup({
        capabilities = capabilities,
      })

      nvim_lsp.astro.setup({
        capabilities = capabilities,
        -- cmd = { "astro-ls", "--stdio" }, -- default
      })
      -- MDX-analyzer?
      -- vim.treesitter.language.register("markdown", "mdx")

      nvim_lsp.tailwindcss.setup({
        capabilities = capabilities,
      })

      nvim_lsp.jsonls.setup({
        capabilities = capabilities,
        cmd = { "vscode-json-language-server", "--stdio" },
      })

      nvim_lsp.qmlls.setup({
        capabilities = capabilities,
        cmd = { "qmlls", "-E" },
      })

      nvim_lsp.tinymist.setup({
        capabilities = capabilities,
        settings = {
          formatterMode = "typstyle",
          exportPdf = "onSave",
          semanticTokens = "disable"
        },
        on_attach = function (client, bufnr)
          local wk = require("which-key")
          wk.add({
            { "<leader>llt", group = "Typst"}
          })
          vim.keymap.set("n", "<leader>lltp", function ()
            client:exec_cmd({
              title = "pin",
              command = "tinymist.pinMain",
              arguments = { vim.api.nvim_buf_get_name(0) },
            }, { bufnr = bufnr})
          end, { desc = "[T]inymist [P]in", noremap = true })
          vim.keymap.set("n", "<leader>lltu", function()
            client:exec_cmd({
              title = "unpin",
              command = "tinymist.pinMain",
              arguments = { vim.v.null },
            }, { bufnr = bufnr })
          end, { desc = "[T]inymist [U]npin", noremap = true })
        end
      })
    end,
  },
  {
    "luckasRanarison/tailwind-tools.nvim",
    name = "tailwind-tools",
    build = ":UpdateRemotePlugins",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim", -- optional
      "neovim/nvim-lspconfig", -- optional
    },
    keys = {
      { "<leader>tc", ":TailwindConcealToggle<cr>", desc = "Conceal Tailwind" },
    },
    opts = {
      server = {
        override = true, -- setup the server from the plugin if true
        settings = {}, -- shortcut for `settings.tailwindCSS`
        on_attach = function(client, bufnr) end, -- callback triggered when the server attaches to a buffer
      },
      document_color = {
        enabled = true, -- can be toggled by commands
        kind = "inline", -- "inline" | "foreground" | "background"
        inline_symbol = "󰝤 ", -- only used in inline mode
        debounce = 200, -- in milliseconds, only applied in insert mode
      },
      conceal = {
        enabled = false, -- NOTE: Resource intensive - is toggled by command
        min_length = nil, -- only conceal classes exceeding the provided length
        symbol = "󱏿", -- only a single character is allowed
        highlight = { -- extmark highlight options, see :h 'highlight'
          fg = "#38BDF8",
        },
      },
      cmp = {
        highlight = "foreground", -- color preview style, "foreground" | "background"
      },
    }
  }
}
