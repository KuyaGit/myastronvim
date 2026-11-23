-- Transparent background so WezTerm's translucent, blurred window
-- (window_background_opacity + macos_window_background_blur) shows through Neovim.

---@type LazySpec
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      transparent_background = true, -- Normal, NormalNC, sidebars (neo-tree), statusline, etc.
      float = { transparent = true, solid = false }, -- floating windows / which-key / pickers
    },
  },
}
