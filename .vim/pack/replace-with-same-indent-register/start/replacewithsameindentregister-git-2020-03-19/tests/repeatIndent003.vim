" Test count-repeat indent-replacing a line with a single line.
" Tests that the count is correctly repeated.

call vimtest#SkipAndQuitIf(! vimtest#features#SupportsNormalWithCount(), 'Need support for :normal with count')

normal! 3G02W
normal "igrR

normal! 7j
normal 3.

normal! 2j0W
normal .

call VerifyRegisters()
call vimtest#SaveOut()
call vimtest#Quit()
