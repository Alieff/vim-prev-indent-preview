" KALO GA TERJADI APA2 BIASANYA ERRROR DI PYTHON
function! s:prev_indent_preview(...)
  " save toggle var
  if exists('t:prev_indent_preview_on') && t:prev_indent_preview_on == 1
    let t:prev_indent_preview_on = 0
  else
    let t:prev_indent_preview_on = 1
  endif

  let current_ve = &ve
  let top_window_line_number = line('.')-winline()+1
  let current_col = col('.')
  set ve=all

  if t:prev_indent_preview_on == 1
    " save window id
    let t:preview_win = win_getid()
    sp
    let t:editor_win = win_getid()

    call win_gotoid(t:preview_win)
    let w:vim_prev_indent_text_preview_status_line_hidden = 1
    resize 1
    execute top_window_line_number
    execute 'normal 00'.(current_col-1).'l' 
    execute 'GotoNonBlankColumn normal p'
    call win_gotoid(t:editor_win)
  else
    if win_id2win(t:preview_win)
      call win_gotoid(t:preview_win)
      close
    endif
    if win_id2win(t:editor_win)
      call win_gotoid(t:editor_win)
    endif
  endif

  " restore last ve
  let &ve = current_ve
endfunction 
"" sort by date (my custom sort function)
:command! -nargs=* -range PrevIndentPreview call s:prev_indent_preview(<f-args>)
nnoremap <a-m> :PrevIndentPreview<cr>
