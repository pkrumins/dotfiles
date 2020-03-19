" Test repeat indent-replacing a single line with a single line.
" Tests that the same register is used on repetition.

normal! 3G02W
normal "igrR

normal! 8j
normal .

call VerifyRegisters()
call vimtest#SaveOut()
call vimtest#Quit()
