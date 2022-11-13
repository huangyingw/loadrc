" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()

" configuration for ncm2
call ncm2#override_source('bufword', {'priority': 7})
call ncm2#override_source('otherbuf', {'priority': 6})
call ncm2#override_source('path', {'priority': 5})
