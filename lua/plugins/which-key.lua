-- Show the Space-key (Leader) menu immediately instead of after a delay.

---@type LazySpec
return {
  "folke/which-key.nvim",
  opts = {
    delay = 0,
  },
}
