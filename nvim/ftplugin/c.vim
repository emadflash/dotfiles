let g:ale_linters = {
		  \'c': ['cpplint'], 
		  \'cpp' : ['cpplint']
		  \}


let s:infile = expand('%:p')
let s:outfile = expand('%:p:r') 

if &filetype ==# 'c'
	let s:cxx_compiler_flags = "-g".
			\ " -fstack-clash-protection" .
			\ " -D_FORTIFY_SOURCE=2".
			\ " -D GLIBCXX_DEBUG".
			\ " -fsanitize=address".
			\ " -Wall".
			\ " -O0 "
	let s:compiler = "gcc"
elseif &filetype ==# 'cpp'
	let s:cxx_compiler_flags = "-g".
			\ " -std=c++2a".
			\ " -D GLIBCXX_DEBUG".
			\ " -fsanitize=address".
			\ " -Wall".
			\ " -O0 "
	let s:compiler = "g++"
endif

let s:compile_string = s:compiler. ' ' .s:cxx_compiler_flags. s:infile. ' -o' .s:outfile


" compile and execute it directly
exec 'nnoremap <buffer> ,c :!' .s:compile_string. ' && ' .s:outfile. '<cr>'

" compile and execute it with args from input file
exec 'nnoremap <buffer> ,i :!' .s:compile_string. ' && '
			\ .s:outfile. ' < input.txt <cr>'

" compile inside terminal buffer
exec 'nnoremap <buffer> '.g:compile_map.' :tabe term://' .s:compile_string. '<cr>i'

" excute already compiled binary
exec 'nnoremap <buffer> '.g:execute_map.' :tabe term://'.s:outfile.' <cr>i'
