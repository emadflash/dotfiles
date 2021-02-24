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
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-surround'
Plug 'jceb/vim-orgmode'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-line'
Plug 'christoomey/vim-system-copy'
Plug 'christoomey/vim-sort-motion'
Plug 'christoomey/vim-titlecase'
Plug 'tpope/vim-fugitive'
Plug 'kien/ctrlp.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'szw/vim-maximizer'
Plug 'preservim/nerdcommenter'
Plug 'dense-analysis/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()


" Strip the newline from the end of a string
function! Chomp(str)
  return substitute(a:str, '\n$', '', '')
endfunction


" Netrw
let g:netrw_liststyle = 4
let g:netrw_browse_split = 2
let g:netrw_banner = 0
let g:netrw_winsize = 25


" fzf
function! s:bufopen(e)
  execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction

function! s:buflist()
  redir => ls
  silent ls
  redir END
  return split(ls, '\n')
endfunction

nnoremap <silent> <Leader>b :call fzf#run({
\   'source':  reverse(<sid>buflist()),
\   'sink':    function('<sid>bufopen'),
\   'options': '+m',
\   'down':    len(<sid>buflist()) + 2
\ })<CR>


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

" files
nnoremap <leader>e :Ex .<cr>

" search
nnoremap <leader>J /
nnoremap <leader>K ?

" bash like command mode
cnoremap <c-a> <Home>
cnoremap <c-e> <End>
cnoremap <c-f> <Right>
cnoremap <c-b> <Left>

" splits
nnoremap <leader>wv :vsplit<cr>
nnoremap <leader>ws :split<cr>

" maximize toggle
nnoremap <silent><C-o> :MaximizerToggle<cr>
vnoremap <silent><C-o> :MaximizerToggle<cr>gv

" vim-fugitive
nnoremap =s :G<cr>
nnoremap =l :G log<cr>
nnoremap =g :G status<cr>
nnoremap =c :Gcommit<cr>

" airline
let g:airline_theme='solarized'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

" org
let g:org_agenda_files = ['~/org/index.org', '~/org/project.org']

" snippets
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"


" ctrlp
let g:ctrlp_map = '<c-p>'


" cpp
autocmd FileType cpp nnoremap <buffer> ,c :!g++ -std=c++1z -D GLIBCXX_DEBUG -Wall -O0 % -o /tmp/a.out<cr>
autocmd FileType cpp nnoremap <buffer> ,i :!g++ -std=c++1z -D GLIBCXX_DEBUG -Wall -O0 % -o /tmp/a.out ;
			\ echo "INPUT: " ;
			\ while read line; do echo -e "\t$line"; done < input.txt ;
			\ echo "OUPUT:" ;
			\ /tmp/a.out < input.txt > /tmp/output.txt ;
			\ while read line; do echo -e "\t$line"; done < /tmp/output.txt<CR>

" c
autocmd FileType c nnoremap <buffer> ,c :!gcc % -o /tmp/a.out && /tmp/a.out<CR>
autocmd FileType c nnoremap <buffer> ,i :!gcc % -o /tmp/a.out ;
			\ echo "INPUT: " ;
			\ while read line; do echo -e "\t$line"; done < input.txt ;
			\ echo "OUPUT:" ;
			\ /tmp/a.out < input.txt > /tmp/output.txt ;
			\ while read line; do echo -e "\t$line"; done < /tmp/output.txt<CR>

" python3
autocmd FileType python nnoremap <buffer> ,c :! python3 %<cr>
autocmd FileType python nnoremap <buffer> ,i :!
			\ echo "INPUT: " ;
			\ while read line; do echo -e "\t$line"; done < input.txt ;
			\ echo "OUPUT:" ;
			\ python3 % < input.txt > /tmp/output.txt ;
			\ while read line; do echo -e "\t$line"; done < /tmp/output.txt<CR>
autocmd FileType python nnoremap <buffer> ,m :!python3 -m radon mi % -s<CR>
autocmd FileType python nnoremap <buffer> ,h :!python3 -m radon hal %<CR>


" ale
let g:ale_linters = {'python': ['flake8'], 'c': ['cpplint'], 'cpp' : ['cpplint']}
let g:ale_fixers = {'python': ['black']}
let g:ale_fixers = {
\ '*': ['remove_trailing_lines',],
\ 'python': ['black', 'isort'],
\}
let g:ale_fix_on_save = 1


"" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
