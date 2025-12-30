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

      vim.diagnostic.config({
        virtual_text = true,
        underline = true,
        update_in_insert = true,
        severity_sort = false,
        signs = {
          text = {
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "",
          },
          linehl = {
              [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
          },
          numhl = {
              [vim.diagnostic.severity.WARN] = 'WarningMsg',
          },
        }
      })
      -- TODO: Setup:
      --   "ltex"
      --   "texlab"
      -- Good source of nix nvim setup
      -- https://github.com/Ruixi-rebirth/melted-flakes/blob/31f8805ee48b59ea87d8962b25a9d96b8e7cfdbd/modules/editors/nvim/lua/plugins/lsp.lua

      local languages = {
        "arduino_language_server",
        "lua_ls",
        "nixd",
        "rust_analyzer",
        "gopls",
        "pyright",
        "html",
        "cssls",
        "ts_ls",
        "svelte",
        "astro",
        "tailwindcss",
        "jsonls",
        "qmlls",
        "tinymist",
      }

      local server_opts = {
        qmlls = {
          cmd = { "qmlls", "-E" },
        },
        tinymist = {
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
          end,
        }
      }

      require("lazydev").setup()
      -- MDX-analyzer?
      -- vim.treesitter.language.register("markdown", "mdx")

      for _, language in ipairs(languages) do
        vim.lsp.config(language, vim.tbl_deep_extend(
          "force",
          { capabilities = capabilities },
          server_opts[language] or {}
        ))
        vim.lsp.enable(language)
      end
    end,
  },
  {
    "luckasRanarison/tailwind-tools.nvim",
    name = "tailwind-tools",
    build = ":UpdateRemotePlugins",
    ft = {"html", "jsx", "tsx", "astro", "svelte", "vue", "templ"},
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
