" Test repeat indent-replacing a multi-line selection in normal mode.
" Tests that the same register is used on repetition.
" Tests that the same number of lines is used on normal mode repetition.

call vimtest#SkipAndQuitIf(! vimtest#features#SupportsNormalWithCount(), 'Need support for :normal with count')

normal! 3G0Vj
normal "igR

normal! 6j
normal 3.

normal! 2j0W
normal .

call VerifyRegisters()
call vimtest#SaveOut()
call vimtest#Quit()
