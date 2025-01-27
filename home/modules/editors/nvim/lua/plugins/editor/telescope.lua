return {
  {
    'nvim-telescope/telescope.nvim',
    cmd = "Telescope",
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release'
      }
    },
    keys = {
      { "<C-b>", ":Telescope buffers<CR>", desc = "Manage buffers"}
    },
    config = function()
      local actions = require("telescope.actions")
      require("telescope").setup {
        pickers = {
          buffers = {
            show_all_buffers = true,
            sort_mru = true,
            sort_lastused = false,
            initial_mode = "normal",
            theme = "ivy",
            mappings = {
              n = {
                ["d"] = actions.delete_buffer,
              },
              i = {
                ["<C-d>"] = actions.delete_buffer,
              }
            },
            layout_config = {
              preview_width = 0.45
            }
          }
        },
        defaults = {
          mappings = {
            n = {
              ["q"] = actions.close,
            },
            i = {
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-j>"] = actions.move_selection_next,
              ["<M-k>"] = actions.preview_scrolling_up,
              ["<M-j>"] = actions.preview_scrolling_down,
              ["<M-h>"] = actions.preview_scrolling_left,
              ["<M-l>"] = actions.preview_scrolling_right,
            },
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = true,  -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                             -- the default case_mode is "smart_case"
          },
        },
      }
      require("telescope").load_extension("noice")
      -- TODO: Make this work with Nix home-manager
      -- require("telescope").load_extension("fzf")
    end,
  },
}
