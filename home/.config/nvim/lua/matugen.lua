 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#1e100d',
    base01 = '#2b1c19',
    base02 = '#372622',
    base03 = '#aa8982',
    base04 = '#e3beb6',
    base05 = '#f9dcd6',
    base06 = '#f9dcd6',
    base07 = '#f9dcd6',
    base08 = '#ffb4ab',
    base09 = '#f1bf5b',
    base0A = '#ffb4a4',
    base0B = '#ffb4a4',
    base0C = '#f1bf5b',
    base0D = '#ffb4a4',
    base0E = '#ffb4a4',
    base0F = '#93000a',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#f9dcd6',          bg = '#1e100d' })
  hi('TelescopeBorder',         { fg = '#aa8982',             bg = '#1e100d' })
  hi('TelescopePromptNormal',   { fg = '#f9dcd6',          bg = '#1e100d' })
  hi('TelescopePromptBorder',   { fg = '#aa8982',             bg = '#1e100d' })
  hi('TelescopePromptPrefix',   { fg = '#ffb4a4',             bg = '#1e100d' })
  hi('TelescopePromptCounter',  { fg = '#e3beb6',  bg = '#1e100d' })
  hi('TelescopePromptTitle',    { fg = '#1e100d',             bg = '#ffb4a4' })
  hi('TelescopePreviewTitle',   { fg = '#1e100d',             bg = '#ffb4a4' })
  hi('TelescopeResultsTitle',   { fg = '#1e100d',             bg = '#f1bf5b' })
  hi('TelescopeSelection',      { fg = '#f9dcd6',          bg = '#372622' })
  hi('TelescopeSelectionCaret', { fg = '#ffb4a4',             bg = '#372622' })
  hi('TelescopeMatching',       { fg = '#ffb4a4',             bold = true })
end

 -- Register a signal handler for SIGUSR1 (matugen updates)
 local signal = vim.uv.new_signal()
 signal:start(
   'sigusr1',
   vim.schedule_wrap(function()
     package.loaded['matugen'] = nil
     require('matugen').setup()
   end)
 )

 return M
