set expandtab
set shiftwidth=2
set tabstop=2
set termguicolors
set nonumber
set norelativenumber
set signcolumn=no " Remove the left sidebar padding thingy
set mouse= " enable mousea

set background=dark
colorscheme madflash_bathory

let mapleader="\<Space>"

filetype on
highlight Comment cterm=italic gui=italic

if has("folding")
	set foldmethod=marker
	set foldmarker=#\ {{{,#\ }}}
	set viewoptions=folds,options,cursor,unix,slash
endif

" plugins
call plug#begin('~/.config/nvim/plugins')
Plug 'tpope/vim-surround'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-line'
Plug 'christoomey/vim-system-copy'
Plug 'christoomey/vim-sort-motion'
Plug 'christoomey/vim-titlecase'
Plug 'tpope/vim-fugitive'
" Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'szw/vim-maximizer'
Plug 'preservim/nerdcommenter'
Plug 'SirVer/ultisnips'
Plug 'tommcdo/vim-lion'
Plug 'preservim/tagbar'
Plug 'folke/zen-mode.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

Plug 'rust-lang/rust.vim'
Plug 'simrat39/rust-tools.nvim'

Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'

Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'

Plug 'jakemason/ouroboros'
call plug#end()

" source init.vim
nmap <F10> :source $HOME/.config/nvim/init.vim<cr>

" Strip the newline from the end of a string
function! Chomp(str)
  return substitute(a:str, '\n$', '', '')
endfunction

" Netrw
let g:netrw_liststyle = 3
let g:netrw_browse_split = 2
let g:netrw_banner = 0
let g:netrw_winsize = 20

" fzf
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-i': 'split',
  \ 'ctrl-v': 'vsplit' }
nmap <c-p> :FZF<cr>
nmap <Leader>l :Lines<cr>
nmap <Leader>b :Windows<cr>

" kill buffer
nnoremap <Leader>wd :bd<CR>

" kill window
nmap <Leader>q :q<CR>
nmap <Leader>Q :q!<CR>

" save file
nmap <Leader>w :w<CR>
nmap <c-s> :w<CR>

" jump paragraphs
noremap K {
noremap J }

" jump around in line
noremap H ^
noremap L $

" Copy whole line
nnoremap Y y$

" cycle tabs
nmap <A-n> :tabn<cr>
nmap <A-p> :tabp<cr>

" file explorer
nnoremap <leader>f :NvimTreeToggle<cr>

" bash like command mode
cnoremap <c-a> <Home>
cnoremap <c-e> <End>
cnoremap <c-f> <Right>
cnoremap <c-b> <Left>

" replace highlighted text
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" terminal
nnoremap <c-1> :call terminal#TermToggle(12)<cr>
tnoremap <A-j> <C-\><C-n>:call terminal#TermToggle(12)<cr>
tnoremap <Esc> <C-\><C-n>

" maximize toggle
nnoremap <silent><C-o> :MaximizerToggle<cr>
vnoremap <silent><C-o> :MaximizerToggle<cr>gv

" vim-fugitive
nnoremap =s :Git<cr>
nnoremap =l :Git log<cr>
nnoremap =g :Git status<cr>
nnoremap =c :Git commit<cr>

" ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsSnippetDirectories = [$HOME.'/.config/nvim/snips']

" vim-lion
let g:lion_squeeze_spaces = 1

" Quickfix list
nmap <C-j> :cnext<cr>
nmap <C-k> :cprev<cr>

" source lua/madflash.lua
lua require("madflash")
