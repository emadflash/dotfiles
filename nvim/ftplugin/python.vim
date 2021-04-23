" ale
if has("ALEInfo")
	let b:ale_linters = {'python': ['flake8']}
	let b:ale_fixers = {
		\ 'python': ['black', 'isort'],
		\}
endif


" excute script with keybind
" read input from file and then execute program
nnoremap <buffer> ,c :!python3 %<cr>
nnoremap <buffer> ,i :!
		\ echo "INPUT: " ;
		\ while read line; do echo -e "\t$line"; done < input.txt ;
		\ echo "OUPUT:" ;
		\ python3 % < input.txt > /tmp/output.txt ;
		\ while read line; do echo -e "\t$line"; done < /tmp/output.txt<CR>

" code analysis bull shit
nnoremap <buffer> ,m :!python3 -m radon mi % -s<CR>
nnoremap <buffer> ,h :!python3 -m radon hal %<CR>

" debugging with pdb
if exists("g:debugg_map")
	exec 'nnoremap <buffer> '.g:debugg_map.' :tabe term://python3 %<cr>A'
else
	nnoremap <buffer> ,d :tabe term://python3 %<cr>A
endif
