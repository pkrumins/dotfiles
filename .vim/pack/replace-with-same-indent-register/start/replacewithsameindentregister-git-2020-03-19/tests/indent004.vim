" Test indent-replacing multiple lines with word.
" Tests that the cursor is positioned on the first non-blank of the indent-replaced line.

call vimtest#SkipAndQuitIf(! vimtest#features#SupportsNormalWithCount(), 'Need support for :normal with count')

normal! 3G02W
normal "a3grR

8normal "a2grR
normal! r*

call VerifyRegisters()
call vimtest#SaveOut()
call vimtest#Quit()
