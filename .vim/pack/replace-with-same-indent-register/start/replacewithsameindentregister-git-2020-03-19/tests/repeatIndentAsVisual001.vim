" Test repeat indent-replacing a single line with a single line in visual modes.
" Tests that the same register is used on repetition.

runtime plugin/visualrepeat.vim

normal! 3G02W
normal "igrR

normal! 10jV2k
normal .

call VerifyRegisters()
call vimtest#SaveOut()
call vimtest#Quit()
