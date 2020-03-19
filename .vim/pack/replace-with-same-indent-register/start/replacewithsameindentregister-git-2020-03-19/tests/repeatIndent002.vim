" Test repeat indent-replacing three lines with a single line.
" Tests that the count is correctly repeated.

call vimtest#SkipAndQuitIf(! vimtest#features#SupportsNormalWithCount(), 'Need support for :normal with count')

normal! 3G02W
normal "i3grR

normal! 5j
normal .

call VerifyRegisters()
call vimtest#SaveOut()
call vimtest#Quit()
