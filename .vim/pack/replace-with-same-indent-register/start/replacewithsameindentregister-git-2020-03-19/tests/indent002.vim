" Test indent-replacing a single line with word.
" Tests that the cursor is positioned on the first non-blank of the indent-replaced line.

normal! 3G02W
normal "agrR

11normal "agrR
10normal "agrR
12normal "agrR
normal! r*

call VerifyRegisters()
call vimtest#SaveOut()
call vimtest#Quit()
