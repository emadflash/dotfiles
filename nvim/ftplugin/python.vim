let s:debug_map = ',d'


"""""""""""""""""""""""""""""""""""""""""""
" 
" Execute shortcuts
"
"
"""""""""""""""""""""""""""""""""""""""""""

nmap <buffer> ,c :!python3 %<cr>
nmap <buffer> ,i :!
		\ echo "INPUT: " ;
		\ while read line; do echo -e "\t$line"; done < input.txt ;
		\ echo "OUPUT:" ;
		\ python3 % < input.txt > /tmp/output.txt ;
		\ while read line; do echo -e "\t$line"; done < /tmp/output.txt<CR>

"
" some code analysis
nmap <buffer> ,m :!python3 -m radon mi % -s<CR>
nmap <buffer> ,h :!python3 -m radon hal %<CR>

"
" Debugging
exec 'nmap <buffer> '.s:debug_map.' :tabe term://python3 %<cr>A'
