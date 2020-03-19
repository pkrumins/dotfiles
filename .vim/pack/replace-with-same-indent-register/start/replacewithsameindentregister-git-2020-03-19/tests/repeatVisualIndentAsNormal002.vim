" Test repeat indent-replacing a multi-line selection in normal mode.
" Tests that the same register is used on repetition.
" Tests that the same number of lines is used on normal mode repetition.

call vimtest#SkipAndQuitIf(! vimtest#features#SupportsNormalWithCount(), 'Need support for :normal with count')

normal! 4G0V3j
normal "ngR

normal! 6j
normal .

call VerifyRegisters()
call vimtest#SaveOut()
call vimtest#Quit()
