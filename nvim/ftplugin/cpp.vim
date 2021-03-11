nnoremap <buffer> ,c :!g++ -g -std=c++1z -D GLIBCXX_DEBUG -Wall -O0 % -o /tmp/a.out && /tmp/a.out<cr>
nnoremap <buffer> ,i :!g++ -g -std=c++1z -D GLIBCXX_DEBUG -Wall -O0 % -o /tmp/a.out;
			\ echo "INPUT: " ;
			\ while read line; do echo -e "\t$line"; done < input.txt ;
			\ echo "OUPUT:" ;
			\ /tmp/a.out < input.txt > /tmp/output.txt ;
			\ while read line; do echo -e "\t$line"; done < /tmp/output.txt<cr>

let s:in_file = expand('%:p')
let s:out_file = expand('%:r') 
let s:compile_flags = "-g".
		\ " -std=c++1z".
		\ " -D GLIBCXX_DEBUG".
		\ " -Wall -O0 "

" compile inside terminal buffer
exec 'nnoremap <buffer> '.g:compile_map.' :vsplit term://g++ '.s:compile_flags .s:in_file.' -o '.s:out_file.' <cr><c-w>L A'

" excute already compiled binary
exec 'nnoremap <buffer> '.g:execute_map.' :vsplit term://./'.s:out_file.' <cr><c-w>L A'
