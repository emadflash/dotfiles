" Make the vertical split column blend with the line number
" column.
highlight LineNr cterm=NONE ctermbg=Black ctermfg=Green
if v:version >= 800
  highlight! link CursorLineNr LineNr
endif
highlight VertSplit cterm=NONE ctermbg=Black ctermfg=Green
