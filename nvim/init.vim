set expandtab
set shiftwidth=4
set tabstop=2
set relativenumber

let mapleader="\<Space>"
set background=dark
colorscheme scheme
filetype off                  

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
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'szw/vim-maximizer'
Plug 'preservim/nerdcommenter'
Plug 'SirVer/ultisnips'
Plug 'dense-analysis/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
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

let g:debugg_map = ',d'
let g:compile_map = ',z'
let g:execute_map = ',x'

" ale
let g:ale_fix_on_save = 0
let g:ale_fixers = {
\ '*': ['remove_trailing_lines',],
\}

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" HACK(madflash): load changes made to solarized colorscheme.
autocmd VimEnter * :source ~/.config/nvim/colors/scheme.vim

" Ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsSnippetDirectories = [$HOME.'/.config/nvim/snips']
