set expandtab
set shiftwidth=4
set tabstop=2
set relativenumber

let mapleader="\<Space>"
set background=dark
colorscheme sunbather
filetype off                  

if has("folding")
	set foldmethod=marker
	set foldmarker=#\ {{{,#\ }}}
	set viewoptions=folds,options,cursor,unix,slash
endif


" plugins
call plug#begin('~/.config/nvim/plugins')
Plug 'neovim/nvim-lspconfig'
Plug 'tpope/vim-surround'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-line'
Plug 'christoomey/vim-system-copy'
Plug 'christoomey/vim-sort-motion'
Plug 'christoomey/vim-titlecase'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'szw/vim-maximizer'
Plug 'preservim/nerdcommenter'
Plug 'SirVer/ultisnips'
Plug 'tommcdo/vim-lion'
call plug#end()


" Strip the newline from the end of a string
function! Chomp(str)
  return substitute(a:str, '\n$', '', '')
endfunction

" Netrw
let g:netrw_liststyle = 3
let g:netrw_browse_split = 2
let g:netrw_banner = 0
let g:netrw_winsize = 25

" FZF
nmap <c-p> :FZF<cr>
nmap <Leader>l :Lines<cr>
"nmap <Leader>b :Buffers<cr>
nmap <Leader>b :Windows<cr>

" kill buffer
nnoremap <Leader>wd :bd<CR>

" kill window
nmap <Leader>q :q<CR>
nmap <Leader>Q :q!<CR>

" save file
nmap <Leader>w :w<CR>

" jk escape
inoremap jk <Esc>
inoremap kj <Esc>
cnoremap jk <C-c>
vnoremap jk <esc>

" jump paragraphs
noremap K {
noremap J }

noremap H ^
noremap L $
nnoremap Y y$

" tabs
nmap <A-n> :tabn<cr>
nmap <A-p> :tabp<cr>

" files
nnoremap <leader>e :Ex .<cr>

" bash like command mode
cnoremap <c-a> <Home>
cnoremap <c-e> <End>
cnoremap <c-f> <Right>
cnoremap <c-b> <Left>

" splits
nnoremap <leader>wv :vsplit<cr>
nnoremap <leader>ws :split<cr>

" replace highlighted text
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" terminal
nmap <A-j> :call terminal#TermToggle(12)<CR>
inoremap <A-j> <Esc>:call terminal#TermToggle(12)<CR>
tnoremap <A-j> <C-\><C-n>:call terminal#TermToggle(12)<CR>
tnoremap <Esc> <C-\><C-n>

" maximize toggle
nnoremap <silent><C-o> :MaximizerToggle<cr>
vnoremap <silent><C-o> :MaximizerToggle<cr>gv

" vim-fugitive
nnoremap =s :Git<cr>
nnoremap =l :Git log<cr>
nnoremap =g :Git status<cr>
nnoremap =c :Git commit<cr>

" Ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsSnippetDirectories = [$HOME.'/.config/nvim/snips']

"
"
" vim-lion
"
"
let g:lion_squeeze_spaces = 1

"
"
" Remove trailing whitespaces
" Stolen from - https://vi.stackexchange.com/questions/454/whats-the-simplest-way-to-strip-trailing-whitespace-from-all-lines-in-a-file
" 
"
nmap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>


"
"
" Quickfix list
" 
"
nmap <C-j> :cnext<cr>
nmap <C-k> :cprev<cr>


"
"
" Lsp
" 
"
command! Scratch lua require'tools'.makeScratch()
lua << EOF
require'lspconfig'.clangd.setup{}
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright', 'rust_analyzer', 'tsserver' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
EOF
