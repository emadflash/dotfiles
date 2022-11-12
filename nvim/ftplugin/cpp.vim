" Compile shortcuts
let s:debug_map = ',d'
let s:compile_map = ',z'
let s:execute_map = ',x'
let s:infile = expand('%:p')
let s:outfile = expand('%:p:r') 

let s:compiler_flags = "-g".
  \ " -std=c++2a".
  \ " -fsanitize=address".
  \ " -Wall".
  \ " -Wconversion".
  \ " -O0 "
let s:compiler = "g++"

let s:compile_string = s:compiler. ' ' .s:compiler_flags. s:infile. ' -o' .s:outfile

" compile and execute with input from file
exec 'nmap <buffer> ,i :!' .s:compile_string. ' && '
			\ .s:outfile. ' < input.txt <cr>'

" compile inside terminal buffer
exec 'nmap <buffer> '.s:compile_map.' :tabe term://' .s:compile_string. '<cr>i'

" excute binary
exec 'nmap <buffer> '.s:execute_map.' :tabe term://'.s:outfile.' <cr>i'

" make
nmap <F1> :make -B<cr>
nmap <F2> :cw<cr>

" Ouroboros
nmap <buffer> <c-x> :Ouroboros<cr>
