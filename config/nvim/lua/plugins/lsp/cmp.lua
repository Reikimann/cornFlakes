return {
  {
    "saghen/blink.cmp",
    dependencies = {
      "rafamadriz/friendly-snippets",
      -- "onsails/lspkind.nvim",
      -- "tailwind-tools",
    },
    version = "1.*",
    event = { "InsertEnter", "CmdlineEnter" },
    ---@module "blink.cmp"
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = "super-tab",

        -- FIX: Why this no worky??
        -- ["<C-n>"] = { function(cmp) cmp.scroll_documentation_down(2) end, "fallback" },
        -- ["<C-m>"] = { function(cmp) cmp.scroll_documentation_up(2) end, "fallback" },
        ["<C-n>"] = { "scroll_documentation_down", "fallback" },
        ["<C-m>"] = { "scroll_documentation_up", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        -- TEST: This
        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ["<C-e>"] = { "cancel", "fallback" },
        ['<C-l>'] = { "select_and_accept", "fallback" },
        ["<C-g>"] = {
          function(cmp)
            if cmp.is_documentation_visible() then return cmp.hide_documentation()
            else return cmp.show_documentation() end
          end
        },
      },
      snippets = { preset = "luasnip" },
      completion = {
        accept = {
          auto_brackets = {
            enabled = true,
          },
        },
        menu = {
          border = "rounded",
          draw = {
            treesitter = { "lsp" },
            columns = {
              { "label", "label_description" }, { "kind_icon", gap = 1, "kind" }
            }
          }
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
          window = {
            border = "rounded"
          }
        },
        ghost_text = {
          enabled = true
        }
      },
      cmdline = {
        completion = {
          menu = {
            auto_show = true
          }
        },
        keymap = {
          preset = "cmdline",
          ["<Tab>"] = { "select_and_accept", "fallback" },
          ["<C-k>"] = { "select_prev", "fallback" },
          ["<C-j>"] = { "select_next", "fallback" },
          ["<Up>"] = { "select_prev", "fallback" },
          ["<Down>"] = { "select_next", "fallback" },
        }
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        per_filetype = {
          lua = { inherit_defaults = true, "lazydev" }
        },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100
          }
        }
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },

      -- How do I do the following options in blink?
      -- maxwidth = 50,
      -- ellipsis_char = '...', -- when popup menu exceed maxwidth,
      appearance = {
        nerd_font_variant = "mono",
        -- To setup tailwind-tools icons
        -- https://github.com/onsails/lspkind.nvim#option-3-blinkcmp
        -- https://github.com/luckasRanarison/tailwind-tools.nvim#nvim-cmp
        kind_icons = {
          Method = '󰆧', -- 󰊕
          Function = '󰊕',
          Constructor = '󰒓', -- 

          Field = '󰜢',
          Variable = '󰀫', -- 󰆦
          Property = '󰖷',

          Class = '󰠱',
          Interface = '', -- 󱡠
          Struct = '󰙅', -- 󱡠
          Module = '󰅩', --  󰆦

          Unit = '󰑭',
          Value = '󰎠',
          Enum = '', -- 󰦨
          EnumMember = '', -- 󰦨

          Keyword = '󰌋', -- 󰻾
          Constant = '󰏿',

          Snippet = '󱄽', -- 
          Color = '󰏘',
          File = '󰈔', -- 󰈙
          Reference = '󰬲', -- 󰈇
          Folder = '󰉋', -- 󰉋
          Event = '󱐋', -- 
          Operator = '󰪚', -- 󰆕
          TypeParameter = '󰬛', -- 
        }
      }
    },
    opts_extend = { "sources.default" }
  }
}
