"Start Vundle Configuration
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'airblade/vim-gitgutter'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'elzr/vim-json'
Plugin 'Valloric/YouCompleteMe'
Plugin 'leafgarland/typescript-vim'
Plugin 'vim-scripts/openscad.vim'
Plugin 'digitaltoad/vim-jade'
Plugin 'suan/vim-instant-markdown'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'fatih/vim-go'
Plugin 'smerrill/vcl-vim-plugin'
Plugin '907th/vim-auto-save'

call vundle#end()
filetype plugin indent on
"End Vundle Configuration

syntax on
filetype on

set exrc
set secure
set autowriteall
set hlsearch
set expandtab
set smarttab
set smartindent
set shiftwidth=2
set tabstop=2
set lbr
set tw=500
set backspace=indent,eol,start
set tags=tags,.tags
set foldmethod=syntax
set foldnestmax=1
set foldopen-=block
highlight Folded ctermbg=none
set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

"set mouse=a

set number
set updatetime=1200
set nopaste
set colorcolumn=85
set background=dark
set completeopt=menu,menuone
set completeopt-=preview
let mapleader=','

if isdirectory('./include')
  set path+=./include
endif
if isdirectory('./src')
  set path+=./src
endif

if isdirectory('../include')
  set path+=../include
endif
if isdirectory('../src')
  set path+=../src
endif

"Key Mapping
noremap <C-n> :NERDTree<CR>

noremap <C-Right> <C-w>H
noremap <C-Down> <C-w>J
noremap <C-Up> <C-w>K
noremap <C-Left> <C-w>L

noremap <C-h> <C-w><C-h>
noremap <C-j> <C-w><C-j>
noremap <C-k> <C-w><C-k>
noremap <C-l> <C-w><C-l>
noremap <leader>c :let @/ = ""<CR>
noremap <leader>e :call ToggleErrors()<CR>
noremap <leader>f :tab split<CR>
noremap <leader>F :tabc<CR>
noremap <leader>g :GitGutterToggle<CR>
noremap <leader>G :abo wincmd f<CR>
noremap <leader>l <C-w>>
noremap <leader>h <C-w><
noremap <leader>j <C-w>-
noremap <leader>l :silent %!xmllint --format '  ' --nowarning -<CR>
noremap <leader>k <C-w>+
noremap <leader>m :call HandleMouseSetting()<CR>
noremap <leader>n :call HandleNumberSetting()<CR>
noremap <leader>p :call HandlePasteSetting()<CR>
noremap <leader>q :q<CR>
noremap <leader>Q :qa<CR>
noremap <leader>s :wa<CR>
noremap <leader>t :call TidyFoo()<CR>
noremap <leader>v :source ~/.vimrc<CR>
noremap <leader>z :call SaveAndSuspend()<CR>
noremap <leader>x :xa <CR>
noremap <leader>. :CtrlPTag<cr>
noremap <leader>/ :CtrlPMixed <CR>
noremap <leader> <C-v>

function! SaveAndSuspend()
  :wa
  :sus
endfunction

function! HandleMouseSetting()
  if &mouse == "a"
    set mouse=""
  else
    set mouse=a
  endif
endfunction

function! HandleNumberSetting()
  if &number
    set nonumber
  else
    set number
  endif
endfunction

function! HandlePasteSetting()
  if &paste
    set nopaste
  else
    set paste
  endif
endfunction

function! TidyFoo()
  let filename = expand('%:p')
  python << EOF
import vim
from subprocess import call
call(["tidy", "-iqm", "--show-errors", "0", "--show-warnings", "0", "--tidy-mark", "0", vim.eval("expand('%:p')")])
EOF
  :e
endfunction

function! ToggleErrors()
  if exists("w:syntastic_error_loc_list_is_showing") && w:syntastic_error_loc_list_is_showing
    :lclose
    let w:syntastic_error_loc_list_is_showing = 0
  else
    let w:syntastic_error_loc_list_is_showing = 1
    :Errors
  endif
endfunction

"Whitespace
function! <SID>StripTrailingWhitespaces()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  %s/\s\+$//e
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()
autocmd BufNewFile,BufRead *.json set ft=json
autocmd BufNewFile,BufRead *.wsdl set ft=xml

let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_c_checkers = ['gcc']
let g:syntastic_c_compiler = 'gcc'
let g:syntastic_c_compiler_options = '-D_POSIX_C_SOURCE=200112L'
let g:syntastic_c_include_dirs = [ '../include', 'include', '/usr/include' ]
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exec = 'eslint_d'
let g:syntastic_javascript_eslint_args = '--ignore-path .eslintignore'
let g:syntastic_json_checkers = ['jsonlint']
let g:auto_save = 1
let g:auto_save_silent = 1
let g:auto_save_write_all_buffers = 1
let g:auto_save_events = ["InsertChange", "TextChanged", "BufLeave"]

"plugin configuration
"let g:syntastic_ignore_files = ['.\+\.json$']
"let g:syntastic_javascript_jshint_conf = '~/.bash-bootstrap/resources/.jshintrc-local'
let g:NERDTreeAutoDeleteBuffer=1
let g:NERDTreeShowHidden=1
let g:gitgutter_realtime=1
let g:gitgutter_eager=1
let g:gitgutter_max_signs=10000
" Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetDirectories=["UltiSnips"]
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_complete_in_comments = 1
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_key_list_previous_completion = ['<C-k>', '<Up>']
let g:ycm_key_list_select_completion = ['<C-j>', '<Down>']
let g:ycm_seed_identifiers_with_syntax = 1
