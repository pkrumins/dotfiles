" Test indent-replacing a single line with multiple indented lines.
" Tests that the cursor is positioned on the first non-blank of the indent-replaced line.

normal! 3G02W
normal "ngrR

14normal "ngrR
13normal "ngrR
12normal "ngrR
normal! r*

call VerifyRegisters()
call vimtest#SaveOut()
call vimtest#Quit()
