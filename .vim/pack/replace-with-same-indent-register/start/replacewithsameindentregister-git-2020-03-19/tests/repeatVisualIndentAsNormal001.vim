" Test repeat indent-replacing a linewise selection in normal mode.
" Tests that the same register is used on repetition.

call vimtest#SkipAndQuitIf(! vimtest#features#SupportsNormalWithCount(), 'Need support for :normal with count')

normal! 3G0V
normal "igR

normal! 8j
normal .

call VerifyRegisters()
call vimtest#SaveOut()
call vimtest#Quit()
