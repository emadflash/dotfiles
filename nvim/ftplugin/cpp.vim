nnoremap <buffer> ,c :!g++ -g -std=c++1z -D GLIBCXX_DEBUG -Wall -O0 % -o /tmp/a.out && /tmp/a.out<cr>
nnoremap <buffer> ,i :!g++ -g -std=c++1z -D GLIBCXX_DEBUG -Wall -O0 % -o /tmp/a.out;
			\ echo "INPUT: " ;
			\ while read line; do echo -e "\t$line"; done < input.txt ;
			\ echo "OUPUT:" ;
			\ /tmp/a.out < input.txt > /tmp/output.txt ;
			\ while read line; do echo -e "\t$line"; done < /tmp/output.txt<cr>

