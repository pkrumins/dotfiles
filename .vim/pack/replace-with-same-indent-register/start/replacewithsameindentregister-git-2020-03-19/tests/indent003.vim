" Test indent-replacing a single line with multiple lines.
" Tests that the cursor is positioned on the first non-blank of the indent-replaced line.

normal! 3G02W
normal "mgrR

14normal "mgrR
13normal "mgrR
12normal "mgrR
normal! r*

call VerifyRegisters()
call vimtest#SaveOut()
call vimtest#Quit()
