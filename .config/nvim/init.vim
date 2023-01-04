"set runtimepath+=~/.vim,~/.vim/after

"set packpath+=~/.vim
"source ~/.vimrc
"testing
set autochdir

:imap <C-BS> <C-W>

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim')) "Automating vim-plug vim package manager install
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" ____________________________________
" *** SETTING RUNTIME PATH SECTION ***
" ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
"
set runtimepath+="/home/jakub/.local/share/nvim/plugged/vim-snippets/UltiSnips" "TODO
set rtp+=/usr/local/opt/fzf "TODO: not full name?

let g:python_host_prog = '/usr/bin/python'
" Other example virtualenvs setups:
"let g:python3_host_prog = '/home/jakub/.virtualenvs/nvim3-KZb6yFWR/bin/python'
"let g:python3_host_prog = 'python3'
"let g:python3_host_prog = '/usr/bin/python3'
"let g:python3_host_prog = '/home/linuxbrew/.linuxbrew/bin/python3'


let g:DV=$HOME.'/.local/share/nvim'
let g:DV=expand(g:DV)

" backup
let &backupdir=g:DV."/tmp/backup"
if !isdirectory(g:DV."/tmp/backup")
    call mkdir(g:DV."/tmp/backup", 'p', 0755)
endif

" tags
let &tags=g:DV."/tmp/tags/"
if !isdirectory(g:DV."/tmp/tags")
    call mkdir(g:DV."/tmp/tags", 'p', 0755)
endif

" Set everything so vundle can load TODO: rename
autocmd!
filetype off
"let &rtp.=','.g:DV.'/bundle/Vundle.vim'

let &undodir=g:DV."/tmp/undo"
if !isdirectory(g:DV."/tmp/undo")
    call mkdir(g:DV."/tmp/undo", 'p', 0755)
endif
set undofile

" ______________________________________________
" *** SETTING GENERAL EDITOR CONFIGS SECTION ***
" ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
set autoindent " Automatic indentation
set autowrite " Save file when moving buffers
set showmatch "Highlight matching braces
set ruler "Display a ruler (in the right bottom of the window)
set cursorline
"set exrc "Allow execution of some commands from a .vimrc in a directory where vim reads a file
set secure "mitigate some potential problems of "set exrc"
set laststatus=2 "display the status line always
set backspace=indent,eol,start "make backspace work like most other programs
set showmode " Notify what mode is used
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab " Tab settings
set history=1000
set encoding=utf-8
set noswapfile
set hidden "Hide buffers instead hiding them when a new file is opened
" line number display
" credit: https://jeffkreeftmeijer.com/vim-number/
set number relativenumber
set ignorecase
set smartcase

set number numberwidth=3
set nrformats=
set wrap linebreak
set nocompatible "No compatible with old vi
let mapleader =","
let maplocalleader='\'
"let maplocalleader="\<space>"
set mouse=a " allow scrolling in vim
set scrolloff=3 " scrolloff to see below and above text

set autoread
"set wildmode=list:longest " Autocompletion
set wildmode=list:longest,full " Autocompletion
set hlsearch incsearch

set clipboard=unnamedplus

set t_Co=256  "TODO: possibly move to the end?

"TODO: understand the underlying concept
"augroup numbertoggle
  "autocmd!
  "autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  "autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
"augroup END

" ______________________________________
" *** PLUGINS USING VIM-PLUG SECTION ***
" ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾

call plug#begin('~/.local/share/nvim/plugged')

Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] } " List all keys configuration

Plug 'tpope/vim-fugitive' "TODO: describe
Plug 'tpope/vim-rhubarb' " Search and highlight GitHub: In visual mode: :Gbrowse
Plug 'tpope/vim-git' "TODO: describe
Plug 'airblade/vim-gitgutter' " status of lines in file for git

Plug 'ekalinin/Dockerfile.vim'

set timeoutlen=300

"set notimeout                   " No command timeout
set ttimeout ttimeoutlen=0    " But timeout on terminal escape codes, like arrow keys

Plug 'scrooloose/nerdcommenter'
" Unmap some overlapping shortcuts

Plug 'tpope/vim-surround' " Lets you deal with braket pairs etc.

Plug 'jiangmiao/auto-pairs' " Automatically adding closing brackets and parentheses

Plug 'ntpeters/vim-better-whitespace' " Causes all trailing carracters to be highlighted

Plug 'machakann/vim-highlightedyank' " Highlight yanked text for a while

Plug 'tpope/vim-obsession' " Autosave sessions

Plug 'michaeljsmith/vim-indent-object'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'} "

Plug 'metakirby5/codi.vim'

Plug 'SirVer/ultisnips', { 'do': ':UpdateRemotePlugins' } " Snippets-related pluggins

" TODO: consider vimtex for tex file autocompletion
"https://www.reddit.com/r/vim/comments/b6c6iw/contextual_autocomplete/
"You use <c-x><c-o> to start omnicompletion, and it should complete what you want based on the context
"e.g. filenames for \includegraphics and bibliography entries with \cite
" TODO: tag completion mode: https://georgebrock.github.io/talks/vim-completion/

Plug 'honza/vim-snippets'

"Plug 'ActivityWatch/aw-watcher-vim' " track vim active usage

" Bracketed Paste "TODO: describe
Plug 'ConradIrwin/vim-bracketed-paste'

" Syntax highlighting
"Plug 'sheerun/vim-polyglot' "TODO: possibly replace
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'} "Syntax highlighting for Python

Plug 'easymotion/vim-easymotion' "nicer jumping in normal mode
Plug 'justinmk/vim-sneak' " minimalist alternative to vim-easymotion
Plug 'matze/vim-move' " move a block of text without delete (Alt + h/j/k/l)


"Plug 'Shougo/denite.nvim' " More generic fuzzy finder TODO: figure out shortcuts

"Plug 'terryma/vim-multiple-cursors' "TODO: possibly remove, questionable value

"TODO: describe
Plug 'w0rp/ale', { 'for': ['tex', 'matlab'] } "Syntax checking plugin TODO: consider migration
"Plug 'dense-analysis/ale' { 'for': ['tex', 'matlab'] } "Syntax checking plugin TODO: consider migration
"Plug 'daeyun/vim-matlab', { 'do': function('DoRemote') }

Plug 'yinflying/matlab.vim', {'for': 'matlab'}
Plug 'dpelle/vim-LanguageTool' "https://github.com/dpelle/vim-LanguageTool
Plug 'reedes/vim-wordy'
Plug 'rhysd/vim-grammarous' "checking grammar
Plug 'ron89/thesaurus_query.vim' "TODO: describe
Plug 'reedes/vim-pencil'
Plug 'dbmrq/vim-ditto' "checking repetitions
Plug 'junegunn/vim-easy-align' "align tables and text easily
Plug 'junegunn/vim-peekaboo' "showing registers in normal mode
"Plug 'iamcco/markdown-preview.vim', {'for': 'markdown'} " markdown live preview in a browser
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'tpope/vim-markdown', {'for': 'markdown'}
Plug 'vimwiki/vimwiki', {'for': 'markdown'}

Plug 'donRaphaco/neotex', { 'for': 'tex' } " Live preview for LaTeX;

Plug 'Rykka/riv.vim', { 'for': 'rst' } " reStructuredText file support
Plug 'Rykka/InstantRst', { 'for': 'rst' } " reStructuredText server for autoupdates

" Testing some variables
let proj1 = { 'path': '~/Documents/test', }
let g:riv_projects = [proj1]

Plug 'junegunn/limelight.vim' "simple colors, better focus
Plug 'junegunn/goyo.vim' "large margins and reduced distraction, better focus
Plug 'zefei/vim-colortuner' "Changing colors when bright light

Plug 'freitass/todo.txt-vim' "todo list syntax
Plug 'tpope/vim-speeddating' "incrementing/decrementing dates

Plug 'tpope/vim-repeat' " make more commands work with repeat

Plug 'tpope/vim-abolish' " handle word variants

Plug 'nelstrom/vim-visual-star-search' " visual selection search with # and * (hash and star)

Plug 'wincent/scalpel' "search and replace locally with <leader>e shortcut

Plug 'tpope/vim-unimpaired' " various mappings related to pairs


Plug 'scrooloose/nerdtree' " File browsing

Plug 'mileszs/ack.vim' " Ack search integration, does not support open buffers
Plug 'mhinz/vim-grepper' " does support search in the open buffers TODO: learn

Plug 'Peeja/vim-cdo' " Add Cdo and Ldo (similar to argdo but for the quickfix list) TODO: describe

Plug 'milkypostman/vim-togglelist' " Toggle quickfix and localist

Plug 'majutsushi/tagbar', {'for': ['cpp', 'py', 'c', 'sh']} " Ctag viewer TODO: describe

Plug 'jlanzarotta/bufexplorer' " Nice buffer browsers/switcher

Plug 'tpope/vim-eunuch' " Vim sugar for unix shell commands that need it

Plug 'sjl/gundo.vim' " Graphical interface for the vim's branching undo stuff

Plug 'christoomey/vim-tmux-navigator' " Tmux vim bindings

Plug 'benmills/vimux' " Sending text from VIM to TMUX panes

Plug 'julienr/vim-cellmode' " Sending cell text from VIM to TMUX panes (for MATLAB)

Plug 'itchyny/lightline.vim' " A better status line

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim' "two calls needed

Plug 'haya14busa/incsearch.vim' "TODO: learn

"Plug 'rbgrouleff/bclose.vim'

Plug 'francoiscabrol/ranger.vim'


"Plug 'kien/ctrlp.vim' "TODO: describe
" A fuzzy file finder-- really great just press CTRL-P!

Plug 'vim-scripts/BufOnly.vim' " Close buffers (:BufOnly)

Plug 'ryanoasis/vim-devicons'

" Initialize plugin system
call plug#end()

" __________________________________________
" *** EXTENSION_HOTKEY REMAPPING SECTION ***
" ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
" 'francoiscabrol/ranger.vim'
let g:ranger_map_keys = 0
" TODO: define ranger shortcut
map <leader>F :Ranger<>CR

" 'junegunn/fzf'
nmap <silent> <leader>m :History<CR>

" Better commenting 'scrooloose/nerdcommenter'
let g:NERDCreateDefaultMappings = 0
"map <Leader>c <plug>NERDCommenterToggle
"nmap <Leader>c <plug>NERDCommenterToggle

nmap <C-_>   <Plug>NERDCommenterToggle
vmap <C-_>   <Plug>NERDCommenterToggle
"vmap <C-_>   <Plug>NERDCommenterToggle<CR>gv
"map <Leader>c <plug>NERDCommenterToggle
"nmap <Leader>c <plug>NERDCommenterToggle
"umap <leader>cs "TODO:fix unbinding problem

" 'justinmk/vim-sneak' minimalist alternative to vim-easymotion
let g:sneak#s_next = 1
"map n <Plug>Sneak_; " TODO: figure out n/N mappings in search results
"map N <Plug>Sneak_;

nnoremap <leader>u :UltiSnipsEdit<CR>


" go to the next or previous error detected by ALE 'w0rp/ale'
"nnoremap <silent> <Leader>aj :ALENext<CR>
"nnoremap <silent> <Leader>ak :ALEPrevious<CR>
nnoremap <Leader>aj :lnext<CR>
nnoremap <Leader>ak :lprevious<CR>
nnoremap <space>r :lrewind<CR>

" Spell checking and sysonyms search
let g:grammarous#use_vim_spelllang = 1
let g:grammarous#enable_spell_check= 1
let g:grammarous#show_first_error = 1
"let g:grammarous#enabled_categories = {'*' : ['PUNCTUATION', 'STYLE', 'PASSIVE VOICE']}

augroup tex_mappings
    autocmd!
    " rhysd/vim-grammarous'
    "autocmd FileType text,tex,latex,context,plaintex let g:grammarous#use_vim_spelllang = 0
    "autocmd FileType text,tex,latex,context,plaintex let g:grammarous#enable_spell_check=1

    autocmd FileType text,tex,latex,context,plaintex map <Leader>r <Plug>(grammarous-fixit)
    autocmd FileType text,tex,latex,context,plaintex map <Leader>g <Plug>(grammarous-move-to-next-error)
    autocmd FileType text,tex,latex,context,plaintex map <Leader>b <Plug>(grammarous-move-to-previous-error)
    autocmd FileType text,tex,latex,context,plaintex map <Leader>i <Plug>(grammarous-move-to-info-window)
    autocmd FileType text,tex,latex,context,plaintex map <Leader>x <Plug>(grammarous-close-info-window)
    autocmd FileType text,tex,latex,context,plaintex let g:wordy#ring = [
      \ 'weak',
      \ ['being', 'passive-voice', ],
      \ 'business-jargon',
      \ 'weasel',
      \ 'puffery',
      \ ['problematic', 'redundant', ],
      \ ['colloquial', 'idiomatic', 'similies', ],
      \ 'art-jargon',
      \ ['contractions', 'opinion', 'vague-time', 'said-synonyms', ],
      \ 'adjectives',
      \ 'adverbs',
      \ ]
    if !&wildcharm | set wildcharm=<C-z> | endif
    execute 'nnoremap <leader>w :Wordy<space>'.nr2char(&wildcharm)
augroup END

" 'ron89/thesaurus_query.vim'
nnoremap <unique><silent> <leader>cw :ThesaurusQueryReplaceCurrentWord<CR>
vnoremap <unique><silent> <leader>cw "ky:ThesaurusQueryReplace <C-r>k<CR>
"nnoremap <silent> <LocalLeader>cw :ThesaurusQueryReplaceCurrentWord<CR>
"vnoremap <silent> <LocalLeader>cw "ky:ThesaurusQueryReplace <C-r>k<CR>

"'dbmrq/vim-ditto'
" Use autocmds to check your text automatically and keep the highlighting
" up to date (easier):
au FileType markdown,text,tex DittoOn  " Turn on Ditto's autocmds
nmap <leader>di <Plug>ToggleDitto      " Turn Ditto on and off

" If you don't want the autocmds, you can also use an operator to check
" specific parts of your text:
" vmap <leader>d <Plug>Ditto	       " Call Ditto on visual selection
" nmap <leader>d <Plug>Ditto       " Call Ditto on operator movement

nmap =d <Plug>DittoNext                " Jump to the next word
nmap -d <Plug>DittoPrev                " Jump to the previous word
nmap +d <Plug>DittoGood                " Ignore the word under the cursor
nmap _d <Plug>DittoBad                 " Stop ignoring the word under the cursor
nmap ]d <Plug>DittoMore                " Show the next matches
nmap [d <Plug>DittoLess                " Show the previous matches


" autocmd BufRead,BufNewFile *.md :Goyo 80

" 'scrooloose/nerdtree'
let NERDTreeMapHelp = '<f1>'
noremap <silent> <leader>1 :NERDTreeToggle<CR>

" 'majutsushi/tagbar'
let g:tagbar_iconchars = ['+', '-']
noremap <silent> <leader>2 :TagbarToggle<CR>

" 'ivegotasthma/bufexplorer'
noremap <silent> <leader>3 :BufExplorer<CR>
let g:bufExplorerDefaultHelp=0
let g:bufExplorerSortBy='mru'        " Sort by most recently used.

 "TODO: clean here a little bit!
" Auto open buffer explorer after splitting a window
" 95% of the time when I open a slit, I want to view a currently open file
noremap <silent> <C-w>s <C-w>s:BufExplorer<CR>
noremap <silent> <C-w>v <C-w>v:BufExplorer<CR>

" 'sjl/gundo.vim'
nnoremap <silent> <leader>4 :GundoToggle<CR>
let g:gundo_right = 1
let g:gundo_help  = 0


 " set make program shortcut
nnoremap <leader>5 :call Make()<CR>
vnoremap <leader>5 :call Make()<CR>

nnoremap <silent> <leader>6 :call GStatusToggle()<CR>

nnoremap gb <C-t> " go back
nnoremap gu vawy:tselect <C-r>0<CR> " see uses

nnoremap <leader>Ev :call Edit_vimrc()<CR>
nnoremap <leader>Es :call Edit_ShortcutsSheet()<CR>
nnoremap <leader>Et :call Edit_todo()<CR>
nnoremap <leader>Ec :call Edit_colorscheme()<CR>


" See what syntax groups are under the cursor
nnoremap <leader>O :call <SID>SynStack()<CR>


" TODO: read: https://medium.com/free-code-camp/a-guide-to-modern-web-development-with-neo-vim-333f7efbf8e2
"nmap <silent> <leader>dd <Plug>(coc-defnition)
"nmap <silent> <leader>dr <Plug>(coc-references)
"nmap <silent> <leader>dj <Plug>(coc-implementation)

nnoremap <leader>cl :call Toggle_Column_Width()<cr>

" 'ntpeters/vim-better-whitespace'
"nnoremap <leader>f :StripWhitespace<cr>
"
" sort visual selection
"vnoremap <leader>s :'<,'>!sort -f<cr>

nmap <script> <silent> <leader>l :call ToggleLocationList()<CR>
nmap <script> <silent> <leader><leader> :call ToggleQuickfixList()<CR>


" 'junegunn/vim-easy-align'
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" 'airblade/vim-gitgutter'
nmap ]h <Plug>GitGutterNextHunk
nmap [h <Plug>GitGutterPrevHunk


" 'benmills/vimux' "Sending text from VIM to TMUX (Matlab, Python)
let g:VimuxRunnerType = "window"
let g:VimuxUseNearest = 1

 " Run the current file with rspec
 map <Leader>rb :call VimuxRunCommand("clear; rspec " . bufname("%"))<CR>

 " Prompt for a command to run
 nnoremap <LocalLeader>g :VimuxPromptCommand<CR>

 " Run last command executed by VimuxRunCommand
 map <Leader>vl :VimuxRunLastCommand<CR>

 " Inspect runner pane
 map <Leader>vi :VimuxInspectRunner<CR>

 " Close vim tmux runner opened by VimuxRunCommand
 map <Leader>vq :VimuxCloseRunner<CR>

 " Interrupt any command running in the runner pane
 map <Leader>vx :VimuxInterruptRunner<CR>

 " Zoom the runner pane (use <bind-key> z to restore runner pane)
 map <Leader>vz :call VimuxZoomRunner()<CR>

 function! VimuxSlime()
  call VimuxSendText(@v)
  "call VimuxSendKeys("Enter")
 endfunction

 " If text is selected, save it in the v buffer and send that buffer it to tmux
 "vnoremap <LocalLeader>vs "vy :call VimuxSlime()<CR>
 vnoremap <silent> <leader>vs "vy :call VimuxSlime()<CR>

 " Select current paragraph and send it to tmux
 "nnoremap <leader>vs vip<LocalLeader>vs<CR>
 "nmap <leader>vs vip"vy :call VimuxSlime()<CR>
 nnoremap <silent> <leader><CR> vip"vy :call VimuxSlime()<CR>

au BufReadPost,BufNewFile *.m :call VimuxOpenRunner()

" 'julienr/vim-cellmode'
"let g:cellmode_default_mappings='0'
"let g:cellmode_use_tmux=1
"let g:cellmode_cell_delimiter='\(##\|%%\|#\s%%\)'
"let g:cellmode_tmux_sessionname=''  " Will try to automatically pickup tmux session
"let g:cellmode_tmux_windowname='matlab'
"let g:cellmode_tmux_panenumber='0'

"map <leader>S j?## -- ##<CR>v/## -- ##<CR>
"

function! VimuxSlimeMatlab()
"Highlight text
  ":execute "normal! j?%%\<CR>jV/%%\<CR>koj"
  silent execute "normal! j?%%\<CR>jV/%%\<CR>k"
  ":execute "normal! j/%%\<CR>V?%%\<CR>j"
"copy highlighted text to the 'v' register
  silent execute "normal! \"vyn"
"TODO: remove blank lines from register 'v'
"TODO: remove lines starting with % from register 'v'
  silent call VimuxSendText(@v)
  "call VimuxSendKeys("Enter")
endfunction



function! VimuxSlimeMatlab3()
"Highlight text
  ":execute "normal! j?%%\<CR>jV/%%\<CR>koj"
  silent execute "normal! j/%%\<CR>kV?%%\<CR>"
  ":execute "normal! j/%%\<CR>V?%%\<CR>j"
"copy highlighted text to the 'v' register
  silent execute "'<,'>g/^[^%\w+]/y V"

  silent execute "normal! /%%\<CR>j"
  "silent execute "normal! \"vyn"
"TODO: remove blank lines from register 'v'
"TODO: remove lines starting with % from register 'v'
  silent call VimuxSendText(@v)
    call setreg('v', [])
  "call VimuxSendKeys("Enter")
  "silent execute "normal! \%%\<CR>"
endfunction


"function! VimuxSlimeMatlab2()
  ""silent execute "normal! ?\v\%\%<CR>V/\v\%\%<CR>k"
  "silent execute "normal! ?\v\%\%<CR>V/\v\%\%<CR>k"
  "silent execute "normal! ?%%\<CR>V/%%\<CR>"
  "silent execute "'<,'>g/^[^%\w+]/y V"
  "silent call VimuxSendText(@v)
    "call setreg('v', [])
"endfunction

function! VimuxSlimeMatlab2()
  call setreg('V', [])
  call setreg('v', [])
  execute "normal! V?%%\<CR>o/%%\<CR>\<ESC>"
  "execute ":'<,'>g/^[^%\w+]/y V"
  execute ":'<,'>g/^[^%\+]/y V"
  execute "normal! /%%\<CR>"
  call search('^[^%\+]')
  call VimuxSendText(@v)
endfunction

function! VimuxSlimeMatlabStay()
  call setreg('V', [])
  call setreg('v', [])

  let start_position = line('.')
  execute "normal! V?%%\<CR>o/%%\<CR>\<ESC>"
  execute ":'<,'>g/^[^%\+]/y V"
  "execute "normal! /%%\<CR>"
  "call search('^[^%\+]')
  execute "normal!". start_position ."gg"
  call VimuxSendText(@v)

endfunction


function! VimuxSlimeMatlab4()
    execute "normal! ?%%\<CR>"
    let start = line('.')
    execute "normal! /%%\<CR>"
    let end = line('.')
    execute start .",". end .':g/^[^%\w+]/y V'
    call VimuxSendText(@v)
    "execute "normal! /%%\<CR>"
    call search('^[^%\+]')
    execute "normal! qvq"
endfunction


function! VimuxSlimeMatlab2Line()
  call setreg('V', [])
  call setreg('v', [])
  execute "normal! V\<ESC>"
  execute "normal! \"Vyy"
  "execute ":'<,'>g/^[^%\w+]/y Vj"
  "execute "normal! /%%\<CR>j"
    call search('^[^%\+]')
    "execute "normal! \<CR>"
  "
  call VimuxSendText(@v)
endfunction


" GOOD BACKUP
"function! VimuxSlimeMatlab2()
""Highlight text
  "":execute "normal! j?%%\<CR>jV/%%\<CR>koj"
  "silent execute "normal! j?%%\<CR>jV/%%\<CR>k"
  "":execute "normal! j/%%\<CR>V?%%\<CR>j"
""copy highlighted text to the 'v' register
  "silent execute "'<,'>g/^[^%\w+]/y V"
  ""silent execute "normal! \"vyn"
""TODO: remove blank lines from register 'v'
""TODO: remove lines starting with % from register 'v'
  "silent call VimuxSendText(@v)
    "call setreg('v', [])
  ""call VimuxSendKeys("Enter")
"endfunction

function! RunAsMatlabScript()
"stuff which works in the command line :!tmux send-keys -t matlab "run '%:p'" Enter
    "normal! :!tmux send-keys -t matlab "run '%:p'" Enter
    silent execute 'wa'
    silent execute "normal! <CR>"
    silent execute '!tmux send-keys -t matlab "run'expand("'%:p'")'" Enter'
    silent execute "normal! <CR>"
endfunction

function! IgnoreMatlabLinter()
    silent execute "normal! A %#ok\<ESC>^:w"
    silent execute "normal! :w\<CR>"
endfunction

" send current MATLAB cell to TMUX
nnoremap <silent><leader>m :call VimuxSlimeMatlab2()<CR>
nnoremap <silent><leader>ms :call VimuxSlimeMatlabStay()<CR>

" send current MATLAB line to TMUX
nnoremap <silent><leader>ma :call VimuxSlimeMatlab2Line()<CR>

" send current MATLAB line to TMUX
nnoremap <silent><leader>M :call RunAsMatlabScript()<CR>

nnoremap <silent><leader>k :call IgnoreMatlabLinter()<CR>
vnoremap <silent><leader>k :call IgnoreMatlabLinter()<CR>

"map <leader>R j?\v\%\%<CR>V/\v\%\%<CR>koj"vy :call VimuxSlime()<CR>
"map <expr> <leader>R 'j?\v\%\%<CR>V/\v\%\%<CR>koj"vy' :call VimuxSlime()<CR>
" /EXTENSION_HOTKEY REMAPPING


" _____________________________________
" *** OTHER_PLUGIN SETTINGS SECTION ***
" ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾

"unmap <leader>r

" 'mileszs/ack.vim' Using with ripgrep
if executable('rg')
  let g:ackprg = '/home/linuxbrew/.linuxbrew/bin/rg --vimgrep'
  vnoremap <leader>r :'<,'>Ack!<cr>
  "nnoremap <leader>G :Ack!
  "nnoremap <leader>G :rg
  nnoremap <C-g> :Gcd <bar> Ack!
  "nnoremap <leader>g :Gcd <bar> Ack!
  "vnoremap <LocalLeader>g :'<,'>Ack!<cr>
  "nnoremap <LocalLeader>g :Ack!
endif

" Likewise, Files command with preview window
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=* Flines call fzf#vim#grep('rg --line-number --no-heading '.shellescape(<q-args>), 0, <bang>0)
"command! -bang -nargs=* Flines call fzf#vim#with_preview('rg --line-number --no-heading '.shellescape(<q-args>), 0, <bang>0)

" Similarly, we can apply it to fzf#vim#grep. To use ripgrep instead of ag:
command! -bang -nargs=* Kurczak
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

function! Find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

" alias for simple rg in the current directory
cnoreabbrev rg Ack!
"cnoreabbrev rg Gcd <bar> Ack!

"command! -nargs=1 Ag execute "Ack! <args> " . Find_git_root()
"command! -nargs=2 Ag execute "Ack! <args> " . Find_git_root()

"if executable('pyls')
    "" pip install python-language-server
    "au User lsp_setup call lsp#register_server({
        "\ 'name': 'pyls',
        "\ 'cmd': {server_info->['pyls']},
        "\ 'whitelist': ['python'],
        "\ })
"endif

"let g:lsp_signs_error = {'text': '✗'}
"let g:lsp_signs_warning = {'text': '‼', 'icon': '/path/to/some/icon'} " icons require GUI
"let g:lsp_signs_hint = {'icon': '/path/to/some/other/icon'} " icons require GUI


"call lsp#server#add('python', 'pyls')

" Snippets Plugin
let g:ycm_use_ultisnips_completer = 0
let g:UltiSnipsSnippetsDir="/home/jakub/.local/share/nvim/plugged/vim-snippets/snippets"
let g:UltiSnipsSnippetDirectories=["UltiSnips"]


"To make <cr> select the first completion item and confirm the completion when no item has been selected:
" TODO: look here: https://github.com/neoclide/coc.nvim/wiki/Completion-with-sources#improve-completion-experience


" 'Shougo/deoplete.nvim'
"let g:deoplete#enable_at_startup = 1

let g:SuperTabDefaultCompletionType = '<C-n>'

 "TODO: specify order
let g:UltiSnipsExpandTrigger       = '<c-j>'
let g:UltiSnipsListSnippets        = '<c-l>'
let g:UltiSnipsJumpForwardTrigger  = '<c-j>'
let g:UltiSnipsJumpBackwardTrigger = '<c-k>'

" Syntax checking 'w0rp/ale'
"let b:ale_linters = ['chktex', 'lacheck']
"let g:ale_linters = {'tex': ['chktex', 'lacheck']}
let g:ale_linters = {'tex': ['chktex'], 'matlab': ['mlint']}
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
let g:ale_open_list = 1
" Set warnings on
let g:ale_set_signs = 1

"source /home/jakub/.vim/colors/darcula_jtk.vim "TODO: relocate it or install as a plugin?
source /home/jakub/.config/nvim/colors/darcula_jtk.vim "TODO: relocate it or install as a plugin?

" 'junegunn/limelight.vim'
let g:limelight_conceal_ctermfg = 245  " Solarized Base1
let g:limelight_conceal_guifg = '#8a8a8a'  " Solarized Base1

" 'donRaphaco/neotex', { 'for': 'tex' }
let g:neotex_subfile=1
"let g:neotex_subfile=0
"let g:neotex_latexdiff=1
let g:neotex_latexdiff=1
let g:tex_flavor = 'latex'
let g:neotex_latexdiff_options="--flatten"
let g:neotex_pdflatex_add_options="--synctex=1"



" Fix problems with syntax highlighting in markdown files
autocmd BufNewFile,BufRead *.md set filetype=markdown

" 'tpope/vim-markdown'
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']

" 'scrooloose/nerdtree'
let NERDTreeIgnore = ['\~$', '\.pyc', '__pycache__', '\.qmlc', '\.jsc']

" 'mileszs/ack.vim'
"let g:ackprg = 'ag --noheading --nocolor --nogroup --column --smart-case --follow --nobreak --silent'

" 'machakann/vim-highlightedyank'
let g:highlightedyank_highlight_duration = 300


" / OTHER_PLUGIN SETTINGS

" _________________________
" *** FUNCTIONS SECTION *** "TODO: possibly relocate to another file?
" ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
let g:grammarous#hooks = {}
function! g:grammarous#hooks.on_check(errs) abort
    nmap <buffer><C-n> <Plug>(grammarous-move-to-next-error)
    nmap <buffer><C-p> <Plug>(grammarous-move-to-previous-error)
endfunction

function! g:grammarous#hooks.on_reset(errs) abort
    nunmap <buffer><C-n>
    nunmap <buffer><C-p>
endfunction

function! s:goyo_enter()

  if executable('tmux') && strlen($TMUX)
    silent !tmux set status off
    silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  endif
  set noshowmode
  set noshowcmd
  set scrolloff=999
  Limelight
  " ...
endfunction

function! s:goyo_leave()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status on
    silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  endif
  set showmode
  set showcmd
  set scrolloff=5
  Limelight!
  " ...
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()


" Move back and forth through commits while staying on the same line
" TODO: which app is that?
nnoremap <A-right> :call GlogForward()<CR>
nnoremap <A-left> :call GlogBackward()<CR>

function! GlogForward()
    let l:line=line('.')
    try
        cnext
    catch /^Vim\%((\a\+)\)\=:E553/
        echo 'Already at the newest version'
    endtry
    call setpos('.', [0, l:line, 0, 0])
endfunction

function! GlogBackward()
    let l:line=line('.')
    try
        cprev
    catch /^Vim\%((\a\+)\)\=:E553/
        echo 'Already at the oldest version'
    endtry
    call setpos('.', [0, l:line, 0, 0])
endfunction

"574 in .vimrc
" TODO: do I need it in NEOVIM?
function! s:get_visual_selection()
  " Why is this not a built-in Vim script function?!
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col1 - 1:]
  return join(lines, "\n")
endfunction

function! CopyTraceAbove()
    let trace = expand('%') . ':' . line('.') . ' ' . s:get_visual_selection()
    execute "normal! \<C-w>ko" . trace . "\<ESC>\<C-w>j"
endfunction


let g:quickfix_open=0
function! Make()
    make
    if !g:quickfix_open
        if (len(getqflist()) > 1)
            copen
            let g:quickfix_open=1
        end
    end
endfunction

" toggle fugivite status
let g:gstatus_open=0
function! GStatusToggle()
    if g:gstatus_open
        try
            bdelete index
            let g:gstatus_open=0
        catch
            Gstatus
            let g:gstatus_open=1
        endtry
    else
        Gstatus
        let g:gstatus_open=1
    end
endfunction


function! Edit_vimrc()
    "exe 'edit ' '/home/jakub/.config/nvim/init.vim'
    exe 'edit ' '~/.config/nvim/init.vim'
    "exe 'edit ' '~/.config/nvim/init-coc.vim'
endfunction

function! Edit_todo()
    "exe 'edit ' '/home/jakub/.config/nvim/init.vim'
    exe 'edit ' '~/Drive/Documents/todo.txt'
    "exe 'edit ' '~/.config/nvim/init-coc.vim'
endfunction


function! Edit_ShortcutsSheet()
    "exe 'edit ' '/home/jakub/.config/nvim/init.vim'
    exe 'edit ' '~/Dropbox/sync/homedir/config_scripts/all-shortcuts.md'
    "exe 'edit ' '~/.config/nvim/init-coc.vim'
endfunction

function! Edit_colorscheme()
    exe 'edit ' . g:DV . '/colors/betterblack.vim'
endfunction

function! <SID>SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunction


nnoremap <silent> <localleader>sp :%call todo#txt#sort_by_project()<CR>
vnoremap <silent> <localleader>sp :call todo#txt#sort_by_project()<CR>
nnoremap <silent> <localleader>sc :%call todo#txt#sort_by_context()<CR>
vnoremap <silent> <localleader>sc :call todo#txt#sort_by_context()<CR>

"nnoremap <script> <silent> <buffer> <localleader>s+ :%call todo#txt#sort_by_project()<CR>
"vnoremap <script> <silent> <buffer> <localleader>s+ :call todo#txt#sort_by_project()<CR>


" ________________________________________
" *** GENERAL HOTKEY REMAPPING SECTION ***
" ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
"Solve some hotkey conflicts  "TODO: which conflicts?
nnoremap dp dp]c
nnoremap do do]c

" better <ESC> (to go back to normal mode from insert mode)
"inoremap jk <ESC>
"xnoremap jk <ESC>
"cnoremap jk <ESC>
set timeoutlen=400

" switch semi-colon and colon
nnoremap ; :
vnoremap ; :
nnoremap : ;
vnoremap : ;

nnoremap <C-4> g_
vnoremap <C-4> g_

" insert the very magic reg-ex mode every time
" highlight last search matches and matches as you type
"set hlsearch incsearch "TODO: possibly remove from here
nnoremap / /\v
nnoremap ? ?\v
nnoremap <silent> <leader>/ :noh<CR>

" Searching in source code only Credits: https://stackoverflow.com/questions/35323148/vim-searching-avoid-matches-within-comments
nnoremap <leader>/ /\(^\(\s*[%,#,",//]\)\@!.*\)\@<=
nnoremap <leader>? ?\(^\(\s*[%,#,",//]\)\@!.*\)\@<=

" disable Ex mode
nnoremap Q <nop>
vnoremap Q <nop>

" set paste toggle
set pastetoggle=<F1> "TODO: consider moving

nnoremap <A-]> :cnext<CR>
nnoremap <A-[> :cprev<CR>

" Move between editor lines (instead of actual lines)
vnoremap j gj
vnoremap k gk
vnoremap $ g$
vnoremap ^ g^
vnoremap 0 g0
nnoremap j gj
nnoremap k gk
nnoremap $ g$
nnoremap ^ g^
nnoremap 0 g0

" buffer switching
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

" window switching "TODO: possibly remove
" moving using M-direction
" open new windows ugin M-S-direction
"nnoremap <C-j> <C-w>j
"nnoremap <C-k> <C-w>k
"nnoremap <C-h> <C-w>h
"nnoremap <C-l> <C-w>l

" Highlight whitespace with <leader>w, and remove with <leader>W TODO: conflicts with Git status
"nnoremap <leader>w :/\s\+$<CR>
"nnoremap <leader>W :%s/\s\+$//e<CR><silent>:noh<CR>

" toggle spell checking
nnoremap <silent> <leader>s :set spell!<CR>

" correct the current word and move to the next one using ,S
set spelllang=en_us " Set region to US English
nnoremap <silent> <leader>S 1z=]s
let &spellfile=g:DV."/spell/en.latin1.add" "TODO: solve file issues?

" Add new empty lines in the normal mode the easy way:
nmap <S-Enter> O<Esc>j
"unmap <CR>
nmap <CR> o<Esc>k
" Use backspace for switching between 2 most recent buffers
nnoremap <BS> <C-^>

"TODO: understand
cnoremap <expr> %%  getcmdtype() == ':' ? expand('%:h').'/' : '%%'

"TODO: understand
noremap <Leader>n nzz
noremap <Leader>N Nzz

"set .xml syntax for .launch files [ROS]
autocmd BufEnter *.launch :setlocal filetype=xml
"autocmd BufRead, BufNewFile *.launch set ft=xml "TODO: check if this is relevant too

" select last pasted content
nnoremap gp `[v`]

set t_ZH=^[[3m
set t_ZR=^[[23m

"Search and replace current selection https://stackoverflow.com/questions/676600/vim-search-and-replace-selected-text
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

highlight Normal ctermfg=146
"highlight Comment cterm=italic
highlight SquishedCommas ctermbg=red guibg=red
match SquishedCommas /, \@!/

highlight redCommas ctermfg=red
match redCommas /, /

" TODO: fix
"map gn :bn<cr>
"map gp :bp<cr>
"map gd :bd<cr>


" 'christoomey/vim-tmux-navigator' Tmux vim bindings
"let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>

"nnoremap <silent> <C-i> :TmuxNavigatePrevious<cr>

set timeoutlen=300
"inoremap <silent> kj <ESC> :bprevious<CR>
"nnoremap <silent> kj :bprevious<CR>
"xnoremap <silent> kj :bprevious<CR>

" ============================================================================ "
" ===                            NICE LABEL                                === "
" ============================================================================ "

nnoremap <leader><leader> :call ToggleQuickfix()<cr>
function! ToggleQuickfix()
   for buffer in tabpagebuflist()
        if bufname(buffer)== ''
           "then quickfix window
           cclose
           return
       endif
   endfor
   copen
endfunction

" enable ncm2 for all buffers
"autocmd BufEnter * call ncm2#enable_for_buffer()

" IMPORTANT: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect "trouble to delete the code without this

" suppress the annoying 'match x of y', 'The only match' and 'Pattern not
" found' messages
set shortmess+=c

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes


" ####### COC CONFIG #######
"
let g:coc_global_extensions = ['coc-lists', 'coc-json', 'coc-ultisnips', 'coc-python', 'coc-vimtex', 'coc-texlab']

" 'neoclide/coc.nvim', {'branch': 'release'}
" Use <cr> to confirm completion
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <CR> pumvisible() ? "\<C-Y>" : "\<CR>"

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>


" 'easymotion/vim-easymotion'
map  <Leader>f <Plug>(easymotion-bd-w)
nmap <Leader>f <Plug>(easymotion-overwin-w)


" ************

"delete stuff without putting it in the yank buffer
"
nmap <silent> <leader>d "_d
map <silent> <leader>d "_d

function! GoToRecentBuffer(direction)
    let limit     = 0
    let startName = bufname('%')
    let nowName   = bufname('%')

    while (startName == nowName) && (a:direction == 'previous' ? limit < 100 : limit <= 100)
        execute a:direction == 'previous' ? "normal! \<C-o>" : "normal! 1\<C-i>"

        let nowName = bufname('%')
        let limit  += 1
    endwhile

    if startName == nowName
        echo "No " . a:direction . " file."
    endif
endfunction

"nnoremap <C-e> :call GoToRecentBuffer('previous')<CR>
nnoremap <C-n> :call GoToRecentBuffer('next')<CR>



function! s:find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

command! ProjectFiles execute 'Files' s:find_git_root()
"command! ProjectLines execute 'Kurczak!' s:find_git_root()
command! ProjectLines execute 'Kurczak!'


"nnoremap <C-p> :ProjectFiles<Cr>
nnoremap <C-f> :ProjectFiles<Cr>

command! FZFMru call fzf#run({
\ 'source':  reverse(s:all_files()),
\ 'sink':    'edit',
\ 'options': '-m -x +s',
\ 'down':    '40%' })

function! s:all_files()
  return extend(
  \ filter(copy(v:oldfiles),
  \        "v:val !~ 'fugitive:\\|NERD_tree\\|^/tmp/\\|.git/'"),
  \ map(filter(range(1, bufnr('$')), 'buflisted(v:val)'), 'bufname(v:val)'))
endfunction

" Usage:
"   fzf#wrap([name string,] [opts dict,] [fullscreen boolean])

" This command now supports CTRL-T, CTRL-V, and CTRL-X key bindings
" and opens fzf according to g:fzf_layout setting.
command! Buffers call fzf#run(fzf#wrap(
    \ {'source': map(range(1, bufnr('$')), 'bufname(v:val)')}))

" This extends the above example to open fzf in fullscreen
" when the command is run with ! suffix (Buffers!)
command! -bang Buffers call fzf#run(fzf#wrap(
    \ {'source': map(range(1, bufnr('$')), 'bufname(v:val)')}, <bang>0))

" You can optionally pass the name of the command as the first argument to
" fzf#wrap to make it work with g:fzf_history_dir
command! -bang Buffers call fzf#run(fzf#wrap('buffers',
    \ {'source': map(range(1, bufnr('$')), 'bufname(v:val)')}, <bang>0))

" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
"
" TODO: fixing Find command
"command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

"au BufNewFile,BufRead todo.txt,*/@TODO/* silent !tmux set status on
"
let @j = 'V}kJ}j'
let @k = 'vipJ}j'

function! ZoteroCite()
  " pick a format based on the filetype (customize at will)
  let format = &filetype =~ '.*tex' ? 'citep' : 'pandoc'
  let api_call = 'http://127.0.0.1:23119/better-bibtex/cayw?format='.format.'&brackets=1'
  let ref = system('curl -s '.shellescape(api_call))
  return ref
endfunction

noremap <leader>z "=ZoteroCite()<CR>p
inoremap <C-z> <C-r>=ZoteroCite()<CR>

set diffopt+=vertical

fu! SaveSess()
    "execute 'call mkdir(%:p:h/.vim)'
    execute 'mksession! %:p:h/Session.vim'
endfunction

fu! RestoreSess()
execute 'so %:p:h/Session.vim'
if bufexists(1)
    for l in range(1, bufnr('$'))
        if bufwinnr(l) == -1
            exec 'sbuffer ' . l
        endif
    endfor
endif
endfunction

"autocmd VimLeave * call SaveSess()
"autocmd VimEnter * call RestoreSess()

" Turning on spellcheck by default
autocmd FileType markdown setlocal spell spelllang=en_us

filetype plugin indent on

function! SyncTexForward()
let linenumber=line(".")
let colnumber=col(".")
let filename=bufname("%")
let filenamePDF=filename[:-4]."pdf"
"let filenamePDF="/home/jakub/Downloads/document.pdf"
let execstr="!zathura --synctex-forward " . linenumber . ":" . colnumber . ":" . filename . " " . filenamePDF . "&>/dev/null &"
exec execstr
endfunction
nmap  :call SyncTexForward()

function! OpenZathura()
    let position = line('.') . ":" . col('.') . ":" . expand('%:p') . " "
    call jobstart("zathura -x 'nvr --remote +%{line} %{input}' --synctex-forward " . position . " " . substitute(expand('%:p'),"tex$","pdf", ""))
endfunction

"function! OpenZathura()
    "let position = line('.') . ":" . col('.') . ":" . expand('%:p') . " "
    "call jobstart("zathura -x 'nvr --remote +%{line} %{input}' --synctex-forward " . position . " " . "/home/jakub/Dropbox/Aplikacje/Overleaf/UltrasoundRobot/paper.pdf")
"endfunction


"function! OpenZathura()
    "let position = line('.') . ":" . col('.') . ":" . expand('%:p') . " "
    "call jobstart("zathura -x 'nvr --remote +%{line} %{input}' --synctex-forward " . position . " " . substitute(expand('%:p'),"tex$","pdf", ""))
"endfunction
"

nnoremap <unique><silent> <leader>t :call OpenZathura()<CR>
