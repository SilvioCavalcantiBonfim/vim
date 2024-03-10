call plug#begin('~/.config/nvim/plugged')

" LSP client and AutoInstaller
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'mfussenegger/nvim-jdtls'

Plug 'preservim/nerdtree'

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter'

Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-surround'

Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}

Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'


call plug#end()

set nu
\" Define o recuo como 4 espaços.
set shiftwidth=2

\" Define ao tamanho da tabulação como 4 espaços.
set tabstop=2

\" Utiliza espaço ao invés de tabulações.
set expandtab


autocmd VimEnter * NERDTree
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

tnoremap <Esc> <C-\><C-n>
nnoremap <F2> gg=G

" Configure o plugin ToggleTerm
lua << EOF
require("toggleterm").setup({
  -- Tamanho do terminal
  size = 15,
  -- Atalho para abrir/fechar o terminal
  open_mapping = [[<F12>]],
  -- Terminal sombreado
  shade_filetypes = {},
  shade_terminals = true,
  -- Fator de sombreamento
  shading_factor = 1,
  -- Iniciar no modo de inserção
  start_in_insert = true,
  -- Persistir o tamanho do terminal
  persist_size = true,
  -- Direção do terminal
  direction = 'horizontal',
  -- Fechar o terminal na saída
  close_on_exit = true,
  -- Shell a ser usado
  shell = vim.o.shell,
})
EOF

lua << EOF
local Terminal  = require('toggleterm.terminal').Terminal
local term_counter = 0

function _G.create_new_terminal()
  term_counter = term_counter + 1
  local term = Terminal:new({ cmd = "bash", hidden = true, direction = 'horizontal' })
  term:toggle()
end

-- Mapeie a tecla para criar um novo terminal
vim.api.nvim_set_keymap("n", "<F12>", "<cmd>lua create_new_terminal()<CR>", {noremap = true, silent = true})
EOF

lua << EOF
local cmp = require'cmp'

cmp.setup({
  sources = {
    { name = 'nvim_lsp' }
  }
})

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

require'lspconfig'.clangd.setup{
  capabilities = capabilities,
}

vim.api.nvim_set_hl(0, "CmpNormal", { bg = "#FF0000" })
require("cmp").setup({
  window = {
    completion = {
      border = "rounded",
      winhighlight = "Normal:CmpNormal",
    }
  }
})

cmp.setup({
  mapping = {
    ['<Up>'] = cmp.mapping.select_prev_item(),
    ['<Down>'] = cmp.mapping.select_next_item(),
    ['<CR>'] = cmp.mapping.confirm({ select = true })
  },
  sources = {
    { name = 'nvim_lsp' }
  }
})
EOF
