-- kmap([mode], [keymap], [mapped-to], [opts])
local kmap = vim.api.nvim_set_keymap

-- General quality of life keybindings

kmap('n', '<Tab><Tab>', ':w<CR>', {})
kmap('n', ':Q', ':q', {})
kmap('n', ':W', ':w', {})
kmap('n', '<Leader>n', ':noh<CR>', {})

kmap('n', '<Leader>b', ':BlamerToggle<CR>', {})

-- Fuzzy finding

kmap('n', '<C-p>', ':Files<CR>', {})
kmap('n', '<C-b>', ':Buffers<CR>', {})
kmap('n', '<C-l>', ':Lines<CR>', {})

-- LSP specific keybindings

local lsp_kb_opts = {}

kmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', lsp_kb_opts)
kmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', lsp_kb_opts)
kmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', lsp_kb_opts)
kmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', lsp_kb_opts)
kmap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', lsp_kb_opts)
kmap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', lsp_kb_opts)
kmap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', lsp_kb_opts)
kmap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', lsp_kb_opts)
kmap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', lsp_kb_opts)
kmap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', lsp_kb_opts)
kmap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', lsp_kb_opts)
kmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', lsp_kb_opts)
kmap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', lsp_kb_opts)
kmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', lsp_kb_opts)
kmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', lsp_kb_opts)
kmap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', lsp_kb_opts)
kmap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', lsp_kb_opts)
