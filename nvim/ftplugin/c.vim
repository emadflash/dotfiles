let s:in_file = expand('%:p')
let s:out_file = expand('%:r') 
let s:compiler_flags = "-g".
		\ " -fstack-clash-protection" .
		\ " -D_FORTIFY_SOURCE=2".
		\ " -D GLIBCXX_DEBUG".
		\ " -Wall -O1 "


exec 'nnoremap <buffer> ,c :!gcc '.s:compile_flags. s:in_file. ' -o /tmp/a.out && /tmp/a.out<cr>'

exec 'nnoremap <buffer> ,i :!gcc '.s:compile_flags. s:in_file. ' -o /tmp/a.out;
			\ echo "INPUT: " ;
			\ while read line; do echo -e "\t$line"; done < input.txt ;
			\ echo "OUPUT:" ;
			\ /tmp/a.out < input.txt > /tmp/output.txt ;
			\ while read line; do echo -e "\t$line"; done < /tmp/output.txt<cr>'
