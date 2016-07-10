call plug#begin('~/.vim/plugged')
Plug 'jamessan/vim-gnupg'
Plug 'tpope/vim-fugitive'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-haml'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'xolox/vim-notes'
Plug 'xolox/vim-misc'
call plug#end()

set nocompatible                " no vi compatibility
set nofoldenable                " hate folding
set backspace=indent,eol,start  " backspace over ALL THE THINGS
set history=50                  " keep 50 lines of command line history
set ruler                       " show the cursor position all the time
set showcmd                     " display incomplete commands
set incsearch                   " do incremental searching
set hlsearch                    " hilight search terms
nohlsearch                      " but not right now
set ignorecase                  " ignore case when searching
set expandtab                   " fuck ascii tabs
set softtabstop=2               " 2 spaces is sufficient indentation
set tabstop=2
set shiftwidth=2
set completeopt=longest,menuone
set nobackup                    " don't fill my hdd with backups
set relativenumber              " show relative line numbers
set number                      " show current line number instead of useless 0
set numberwidth=4               " probably don't have files this long
set clipboard=unnamed           " clipboard in the unnamed buffer
set laststatus=2                " always show status line
set encoding=utf-8              " force unicode
set ttimeoutlen=50              " low timeout
set autoread                    " read file when changed
set lazyredraw                  " no redraw during macros
set scrolloff=10                " scroll vertically near the edge of the screen
set mouse=a                     " use mouse (mainly for scrolling)
set exrc                        " use local rc files
syntax on                       " lovely syntax highlighting
filetype plugin indent on       " important

" Show shitty characters
set list listchars=tab:▸\ ,nbsp:˽,trail:⋅

" Show lines that are too long
highlight ColorColumn ctermbg=red
call matchadd('ColorColumn', '\%81v', 100)

" Draw attention to next match
function! HLNext (blinktime)
  let [bufnum, lnum, col, off] = getpos('.')
  let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
  let target_pat = '\c\%#'.@/
  let blinks = 3
  for n in range(1,blinks)
    let red = matchadd('ColorColumn', target_pat, 101)
    redraw
    exec 'sleep ' . float2nr(a:blinktime / (2*blinks) * 1000) . 'm'
    call matchdelete(red)
    redraw
    exec 'sleep ' . float2nr(a:blinktime / (2*blinks) * 1000) . 'm'
  endfor
endfunction

nnoremap <silent> n n:call HLNext(0.25)<cr>
nnoremap <silent> N N:call HLNext(0.25)<cr>

" Automatically open read only when swap file exists
augroup SwapReadOnly
  autocmd!
  autocmd SwapExists * let v:swapchoice = 'o'
  autocmd SwapExists * echohl Error
  autocmd SwapExists * echomsg 'Duplicate edit session (readonly)'
augroup END

" Don't use Ex mode, use Q for formatting
map Q gq

" cool diff command
if !exists(":diff")
  command diff vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
endif

" better diff colors
highlight DiffAdd    term=reverse cterm=bold ctermbg=green ctermfg=white
highlight DiffChange term=reverse cterm=bold ctermbg=cyan  ctermfg=black
highlight DiffText   term=reverse cterm=bold ctermbg=gray  ctermfg=black
highlight DiffDelete term=reverse cterm=bold ctermbg=red   ctermfg=black

" ctrlp settings
let g:ctrlp_custom_ignore = '\v\/(\.(git|hg|svn)|bin|gen|example|local)\/'

" gitgutter settings
let g:gitgutter_enabled = 1
let g:gitgutter_map_keys = 0
nmap ]h <Plug>GitGutterNextHunk
nmap [h <Plug>GitGutterPrevHunk

" ultisnips settings
let g:UltiSnipsExpandTrigger = '<c-j>'
let g:UltiSnipsJumpForwardTrigger = '<c-j>'

" convert to hex
nnoremap <f2> :%!xxd<cr>
inoremap <f2> <esc>:%!xxd<cr>
vnoremap <f2> :<c-u>%!xxd<cr>

" convert from hex
nnoremap <f3> :%!xxd -r<cr>
inoremap <f3> <esc>:%!xxd -r<cr>
vnoremap <f3> :<c-u>%!xxd -r<cr>

" use f4 for formatting
nnoremap <f4> magg=G'a
inoremap <f4> <esc>magg=G'ai
vnoremap <f4> ma='agv

" fugitive shortcuts
nnoremap <f8> :Git add %<cr>
nnoremap <f9> :Git add -p %<cr>
nnoremap <s-f9> :Git add -p<cr>
nnoremap <f10> :Gcommit<cr>

" forgot to sudo
cnoremap w!! w !sudo tee % >/dev/null

" turn off hilighting
nnoremap <cr> :nohlsearch<cr>

" ignore left mouse clicks
noremap <LeftMouse> <Nop>

" completion stuff
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"

" hardtime stuff
let g:hardtime_default_on = 0
let g:hardtime_allow_different_key = 1
let g:hardtime_maxcount = 2

" insert line above
inoremap <nl> <esc>O

" unbind arrows
noremap <up>    <nop>
noremap <down>  <nop>
noremap <left>  :cprevious<cr>
noremap <right> :cnext<cr>

" only use "very magic" mode
nnoremap / /\v
nnoremap ? ?\v
cnoremap s/ s/\v
cnoremap g/ g/\v
cnoremap v/ v/\v

" quickly format blocks
vnoremap <tab> :Tabularize<cr>

" consistency issues
nnoremap Y y$
onoremap w :execute 'normal! '.v:count1.'w'<cr>

" abbreviations
iabbrev @@     steven@lightsblink.com
iabbrev ccopy  © <c-r>=strftime("%Y")<cr> Steven Frankini.  All rights reserved.
iabbrev ddate  <c-r>=strftime("%Y-%m-%d")<cr>
iabbrev ttime  <c-r>=strftime("%H:%M:%S")<cr>

" fat fingers
command! -bang E e<bang>
command! -bang Q q<bang>
command! -bang W w<bang>
command! -bang QA qa<bang>
command! -bang Qa qa<bang>
command! -bang WA wa<bang>
command! -bang Wa wa<bang>
command! -bang WQ wq<bang>
command! -bang Wq wq<bang>
command! -bang WQA wqa<bang>
command! -bang WQa wqa<bang>

" additional filetypes
au BufNewFile,BufRead *.t set filetype=perl
au BufNewFile,BufRead *.psgi set filetype=perl
au BufNewFile,BufRead cpanfile set filetype=perl
au BufNewFile,BufRead *.tt set filetype=tt2html
au BufNewFile,BufRead .xinitrc set filetype=sh
au BufNewFile,BufRead *.md silent set filetype=markdown

au FileType html setlocal indentkeys-=*<Return>

" Turn on spell checking for commit messages
au FileType gitcommit setlocal spell
au FileType svn setlocal spell

highlight clear SignColumn
