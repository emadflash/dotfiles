set number

let mapleader="\<Space>"
set background=dark
filetype off                  

if has("folding")
	set foldmethod=marker
	set foldmarker=#\ {{{,#\ }}}
	set viewoptions=folds,options,cursor,unix,slash
endif


"----------------Vim-Plug-------------------------
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
Plug 'szw/vim-maximizer'
Plug 'preservim/nerdcommenter'
Plug 'jmcantrell/vim-virtualenv'
Plug 'dense-analysis/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()


" Strip the newline from the end of a string
function! Chomp(str)
  return substitute(a:str, '\n$', '', '')
endfunction


"----------------netrw----------------------------
let g:netrw_liststyle = 4
let g:netrw_browse_split = 2
let g:netrw_banner = 0
let g:netrw_winsize = 25


"----------------FZF------------------------------
nmap <Leader>o :Files<CR>
nmap <Leader>b :Buffers<CR>
nmap <Leader>h :History<CR>
map  <Leader>l :BLines<CR>
nmap <Leader>L :Lines<CR>
nmap <Leader>' :Marks<CR>
"nmap <Leader>c :Commands<CR>
nmap <Leader>: :History:<CR>

"horizontal split
nnoremap <silent> <Leader>ws :call fzf#run({
\   'down': '40%',
\   'sink': 'botright split' })<CR>

"vertical horizontal split
nnoremap <silent> <Leader>wv :call fzf#run({
\   'down': '40%',
"\   'right': winwidth('.') / 2,
\   'sink':  'vertical botright split' })<CR>


nnoremap <silent> <Leader>C :call fzf#run({
\   'source':
\     map(split(globpath(&rtp, "colors/*.vim"), "\n"),
\         "substitute(fnamemodify(v:val, ':t'), '\\..\\{-}$', '', '')"),
\   'sink':    'colo',
\   'options': '+m',
"\   'left':    30
\   'down': '40%',
\ })<CR>

""" Select buffer
function! s:buflist()
  redir => ls
  silent ls
  redir END
  return split(ls, '\n')
endfunction

function! s:bufopen(e)
  execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction

"nnoremap <silent> <Leader><Enter> :call fzf#run({
nnoremap <silent> <Leader>ls :call fzf#run({
\   'source':  reverse(<sid>buflist()),
\   'sink':    function('<sid>bufopen'),
\   'options': '+m',
\   'down':    len(<sid>buflist()) + 2
\ })<CR>



"----------------Mappings-------------------------
nmap <Leader>q :q<CR>
nmap <Leader>Q :q!<CR>

nmap <Leader>w :w<CR>
map <D-s> <Esc>:w<CR>
map <M-s> <Esc>:w<CR>

inoremap jk <Esc>
inoremap kj <Esc>
cnoremap jk <C-c>

" Edit the alternate / previously edited file
nmap <Leader>6 <C-^>

nmap <Up> 	<Nop>
nmap <Down> 	<Nop>
nmap <Left> 	<Nop>
nmap <Right> 	<Nop>
imap <Up> 	<Nop>
imap <Down> 	<Nop>
imap <Left> 	<Nop>
imap <Right> 	<Nop>

noremap K {
noremap J }
noremap H ^
noremap L $
nnoremap Y y$

nnoremap <leader>J /
nnoremap <leader>K ?
vnoremap jk <esc>

nnoremap <c-i> O<esc>j
nnoremap <c-s>c :source ~/.nvim/init.vim<CR>

nnoremap <c-s>bh yyI#<esc>p^
nnoremap <c-s>bv yyI"<esc>p^
nnoremap <c-s>bx yyI--<esc>p^
nnoremap <leader>sz :term zsh<esc><c-w><s-l>
nnoremap <leader>sb :term bash<esc><c-w><s-l>
nnoremap <c-s>a :saveas<space>
nnoremap <c-t>a :new<esc><c-w><s-h>:new<cr>i
nnoremap <c-t>s :new<esc><c-w><s-j>
nnoremap <c-r>sg :%s/
nnoremap <leader>; '.
nnoremap <leader>, 'a
nnoremap <leader>. ma

cnoremap <c-a> <Home>
cnoremap <c-e> <End>
cnoremap <c-f> <Right>
cnoremap <c-b> <Left>

imap <c-x><c-k> <plug>(fzf-complete-word)
omap <leader><tab> <plug>(fzf-maps-o)
xmap <leader><tab> <plug>(fzf-maps-x)

" Splits
nnoremap <leader>wv :vsplit<CR>
nnoremap <leader>ws :split<CR>

"MaximizeToggle
nnoremap <silent><C-o> :MaximizerToggle<CR>
vnoremap <silent><C-o> :MaximizerToggle<CR>gv
"inoremap <silent><c-o> <C-o>:MaximizerToggle<CR>

"vim-fugitive
nnoremap =s :G<cr>
nnoremap =l :G log<cr>
nnoremap =g :G status<cr>
nnoremap =c :Gcommit<cr>

"-----------------Airline-------------------------
let g:airline_theme='base16_default'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

"-----------------OrgMode-------------------------
let g:org_agenda_files = ['~/org/index.org', '~/org/project.org']

"-----------------UltiSnips-----------------------
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"


"-------------------CtrlP-------------------------
let g:ctrlp_map = '<c-p>'
nnoremap <c-b> :CtrlPBuffer<cr>


"-----------------Autocommands--------------------
""cpp
autocmd FileType cpp nnoremap <buffer> ,c :!g++ -std=c++1z -D GLIBCXX_DEBUG -Wall -O0 % -o /tmp/a.out<CR>
autocmd FileType cpp nnoremap <buffer> ,i :!g++ -std=c++1z -D GLIBCXX_DEBUG -Wall -O0 % -o /tmp/a.out ;
			\ echo "INPUT: " ;
			\ while read line; do echo -e "\t$line"; done < input.txt ;
			\ echo "OUPUT:" ;
			\ /tmp/a.out < input.txt > /tmp/output.txt ;
			\ while read line; do echo -e "\t$line"; done < /tmp/output.txt<CR>
autocmd FileType c nnoremap <buffer> ,c :!gcc % -o /tmp/a.out && /tmp/a.out<CR>
""python3
autocmd FileType python nnoremap <buffer> ,p :! python3 %<CR>
autocmd FileType python nnoremap <buffer> ,i :!
			\ echo "INPUT: " ;
			\ while read line; do echo -e "\t$line"; done < input.txt ;
			\ echo "OUPUT:" ;
			\ python3 % < input.txt > /tmp/output.txt ;
			\ while read line; do echo -e "\t$line"; done < /tmp/output.txt<CR>
autocmd FileType python nnoremap <buffer> ,m :!python3 -m radon mi % -s<CR>
autocmd FileType python nnoremap <buffer> ,h :!python3 -m radon hal %<CR>


"-----------------Temaplates----------------------
"autocmd BufNewFile *.sh 0r ~/.config/nvim/templates/skeleton.sh
"autocmd BufNewFile *.h 0r ~/.config/nvim/templates/skeleton.h
"autocmd BufNewFile *.pl 0r ~/.config/nvim/templates/skeleton.pl
"autocmd BufNewFile *.cpp 0r ~/.config/nvim/templates/skeleton.cpp
"
"--------------------ALE--------------------------
let g:ale_linters = {'python': ['flake8']}
let g:ale_fixers = {'python': ['black']}
let g:ale_fixers = {
\ '*': ['remove_trailing_lines',],
\ 'python': ['black', 'isort'],
\}
let g:ale_fix_on_save = 1


"--------------------COC--------------------------
"" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
