lvim.plugins = {
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  },
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    config = function()
      require("rose-pine").setup()
      -- vim.cmd('colorscheme rose-pine')
    end
  },
  {
    "karb94/neoscroll.nvim",
    event = "WinScrolled",
    config = function()
      require('neoscroll').setup({
        -- All these keys will be mapped to their corresponding default scrolling animation
        mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>',
          '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
        hide_cursor = true,          -- Hide cursor while scrolling
        stop_eof = true,             -- Stop at <EOF> when scrolling downwards
        use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
        respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
        cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
        easing_function = nil,       -- Default easing function
        pre_hook = nil,              -- Function to run before the scrolling animation starts
        post_hook = nil,             -- Function to run after the scrolling animation ends
      })
    end
  },
  { "lilydjwg/colorizer" },
  {
    'projekt0n/github-nvim-theme',
    lazy = false,
    priority = 1000,
    config = function()
      require('github-theme').setup({
        --transparent = false,
        -- theme_style = "dark_default"
      })
    end
  },
  { 'datsfilipe/min-theme.nvim' },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
  },
  {
    "zbirenbaum/copilot-cmp",
    after = { "copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end,
  },
  {
    "andweeb/presence.nvim",
    config = function()
      require("presence").setup({
        auto_update = true,
        neovim_image_text = "LunarVim to the moon",
        main_image = "file",
        -- client_id = "793271441293967371",
        log_level = nil,
        debounce_timeout = 10,
        enable_line_number = true,                -- displays the current line number instead of the current project
        editing_text = "Editing %s",              -- %s will be replaced with the file name
        file_explorer_text = "Browsing %s",       -- %s will be replaced with folder name
        git_commit_text = "Committing changes",   -- text to display when commiting changes in git
        plugin_manager_text = "Managing plugins", -- text to display when updating plugins
        reading_text = "Reading %s",              -- text to display when reading
        workspace_text = "Working on %s",         -- text to display when you have an active workspace
        line_number_text = "Line %s out of %s",   -- text to display when line number enabled
      })
    end
  }
}
