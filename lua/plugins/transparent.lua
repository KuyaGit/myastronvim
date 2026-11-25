-- Transparent background so WezTerm's translucent, blurred window
-- (window_background_opacity + macos_window_background_blur) shows through Neovim.

---@type LazySpec
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      flavour = "mocha", -- matches WezTerm's 'Catppuccin Mocha' color scheme
      -- Italic styling like the Catppuccin screenshots
      styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        keywords = { "italic" },
        functions = { "italic" },
        booleans = { "italic" },
        parameters = { "italic" },
        types = { "italic" },
      },
      transparent_background = true, -- Normal, NormalNC, sidebars (neo-tree), statusline, etc.
      float = { transparent = true, solid = false }, -- floating windows / which-key / pickers
    },
  },
}
