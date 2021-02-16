" load .bashrc when executing commands
:set shellcmdflag=-ic

" prevents insert starting in paste mode
:set nopaste

" highlight search terms
:set hlsearch

" highlight search terms as you type
:set incsearch

:highlight Search ctermfg=White ctermbg=Green

" enable syntax highlighting
:syntax on

" sets colors to cater to a dark background
:set background=dark

" start scrolling when the cursor gets within 3 lines of the top or bottom of
" the screen
:set scrolloff=3
" don't jump to the start of line when jumping to a new location
:set nostartofline

" info bar at bottom of screen
:set ruler

" when making a new line, preserve the indentation from the previous line
:set autoindent

" makes the formatter use a line length limit of 80, rather than the width of
" the screen
:set textwidth=80

" when formatting text:
" r = insert comment header in newlines in insert mode
" o = insert comment header in newlines when using o or O
" q = allow formatting of comments with gq
" l = don't break long lines in insert mode
" j = remove comment header when joining
:set formatoptions=roqlj
:autocmd BufEnter * set formatoptions=roqlj

" TODO put this in a ftplugin file
:autocmd FileType ocaml setlocal comments=s1:(*,mb:*,ex:*)

" the distance to shift text when using < and >
:set shiftwidth=2

" change tabs to spaces
:set expandtab

" sets the width of a single tab
:set ts=2

" when splitting the screen, put the new window at the bottom
:set splitbelow

" when splitting the screen vertically, put the new window at the right
:set splitright

" always display the filename bar
:set laststatus=2

" disable the audible warning bell
:set visualbell

" disable the visual bell
:set t_vb=

:set wildmode=longest,list,full
:set wildmenu

" allow the mouse to be used
:set mouse=a

" set enter to make a new line below the current line without entering insert
" mode, and set space to do the same except on the line above the current line
:nnoremap <Enter> o
:nnoremap <Space> O
:nnoremap  :syntax sync fromstart<CR>

" Make shift-K act as just k, instead of doing whatever obnoxious thing it
" usually does.
:nmap K k

" use control-e for changing windows, as well as control-w
:nmap <C-e> <C-w>

" saves all buffers before a make. executes make silently -- that is, don't
" prompt before re-entering the vim buffer. Because doing that messes up the
" screen, redraw with CTRL+L
" :cabbrev make wa <BAR> silent make <BAR> :normal 

" wsh saves and opens a shell
:cabbrev wsh w <BAR> sh

" turn spelling on and off
:cabbrev ss set spell
:cabbrev sns set nospell

" set X to delete the contents of a line without deleting the line itself,
" instead of deleting the character to the left of the cursor.
:nnoremap X 0d$

" as of vim 7.4 this seems to be needed in order to backspace through whitespace
" at the beginning of a line
set backspace=indent,eol,start

" set the contents of the "r register to a ruler at startup
:let @r="--------------------------------------------------------------------------------"

" set the contents of the t register to add todo boxes
:let @t='{j}kI[ ] {jV}k:s/\[ \] \[/[/:noh'

" highlight trailing whitespace
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
au ColorScheme * highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
au BufEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhiteSpace /\s\+$/

" make the 81st column dark gray
set colorcolumn=81
highlight ColorColumn ctermbg=DarkGray

" Only do this part when compiled with support for autocommands
if has("autocmd")
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
endif

" configure syntax highlighting for thrift
au BufRead,BufNewFile *.thrift set filetype=thrift
au! Syntax thrift source ~/.vim/syntax/thrift.vim

au BufRead,BufNewFile *.ru set filetype=ruby

" use only a single space when joining lines
set nojoinspaces

inoremap <C-h> <C-n>
inoremap <S-Tab> <Esc>
" ## added by OPAM user-setup for vim / base ## 93ee63e278bdfc07d1139a748ed3fff2 ## you can edit, but keep this line
let s:opam_share_dir = system("opam config var share")
let s:opam_share_dir = substitute(s:opam_share_dir, '[\r\n]*$', '', '')

let s:opam_configuration = {}

function! OpamConfOcpIndent()
  execute "set rtp^=" . s:opam_share_dir . "/ocp-indent/vim"
endfunction
let s:opam_configuration['ocp-indent'] = function('OpamConfOcpIndent')

function! OpamConfOcpIndex()
  execute "set rtp+=" . s:opam_share_dir . "/ocp-index/vim"
endfunction
let s:opam_configuration['ocp-index'] = function('OpamConfOcpIndex')

function! OpamConfMerlin()
  let l:dir = s:opam_share_dir . "/merlin/vim"
  execute "set rtp+=" . l:dir
endfunction
let s:opam_configuration['merlin'] = function('OpamConfMerlin')

let s:opam_packages = ["ocp-indent", "ocp-index", "merlin"]
let s:opam_check_cmdline = ["opam list --installed --short --safe --color=never"] + s:opam_packages
let s:opam_available_tools = split(system(join(s:opam_check_cmdline)))
for tool in s:opam_packages
  " Respect package order (merlin should be after ocp-index)
  if count(s:opam_available_tools, tool) > 0
    call s:opam_configuration[tool]()
  endif
endfor
" ## end of OPAM user-setup addition for vim / base ## keep this line
