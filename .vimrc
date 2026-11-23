" ~/.vimrc — minimal: load Vim's sensible defaults, then wire the unified
" clipboard so plain vim stays consistent with nvim/tmux/zsh. (nvim is the
" primary editor; this is the fallback path.)
if filereadable($VIMRUNTIME . '/defaults.vim')
  unlet! g:skip_defaults_vim
  source $VIMRUNTIME/defaults.vim
endif

" Locally, vim has +clipboard +xterm_clipboard, so unnamedplus yanks straight to
" the X11 clipboard.
set clipboard^=unnamedplus

" On a remote / no-DISPLAY session unnamedplus is a no-op, so push yanks out via
" the clip bridge (OSC 52). They land in your LOCAL machine's clipboard through
" ssh + tmux — exactly like nvim. Only fires on yank (not delete) of the unnamed
" or +/* registers, so it isn't noisy.
if empty($DISPLAY) && exists('##TextYankPost')
  function! s:ClipBridgeYank() abort
    if get(v:event, 'operator', '') ==# 'y'
          \ && index(['', '+', '*'], get(v:event, 'regname', '')) >= 0
      call system(expand('~/.scripts/clip-copy'), join(v:event.regcontents, "\n"))
    endif
  endfunction
  augroup ClipBridge
    autocmd!
    autocmd TextYankPost * call s:ClipBridgeYank()
  augroup END
endif
