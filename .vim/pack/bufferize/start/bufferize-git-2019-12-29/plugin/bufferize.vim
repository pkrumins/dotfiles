if exists('g:loaded_bufferize') || &cp
  finish
endif

let g:loaded_bufferize = '0.0.1' " version number
let s:keepcpo = &cpo
set cpo&vim

if !exists('g:bufferize_command')
  let g:bufferize_command = 'new'
endif

if !exists('g:bufferize_keep_buffers')
  let g:bufferize_keep_buffers = 0
endif

command! -nargs=* -complete=command Bufferize call bufferize#Run(<q-args>)
command! -nargs=* -complete=command BufferizeTimer call bufferize#RunWithTimer(<q-args>)

let &cpo = s:keepcpo
unlet s:keepcpo
