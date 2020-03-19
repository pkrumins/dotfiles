" Test indent-replacing a single line with a single line.
" Tests that the cursor is positioned on the first non-blank of the indent-replaced line.

normal! 3G02W
normal grR

11normal grR
10normal grR
12normal grR
normal! r*

call VerifyRegisters()
call vimtest#SaveOut()
call vimtest#Quit()
