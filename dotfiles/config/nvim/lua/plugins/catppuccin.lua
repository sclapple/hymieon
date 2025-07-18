return {
  -- add tokyonight
  {
    "catppuccin/nvim",
    lazy = true,
    opts = {
      style = "mocha",
    },
  },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
