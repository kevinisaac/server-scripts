set nocompatible
set backspace=indent,eol,start
set tabstop=4
set shiftwidth=4
set expandtab
set smartindent
set history=50
set ruler
set showcmd
set wrap
set sidescroll=10                           " scroll with 10 characters side offset
set incsearch
set so=5                                    " provides a gap while scrolling
set autowrite
set nu                                      " sets the line number
set nocp                                    " omnicpp installation
" set option& sets the default value
if has("vms")
    set nobackup
" else
"     set backup
"     set backupext=.bak                      " sets the default backup extension
    " set backupdir=.bak                      " sets the default backup directory
endif
" set patchmode=.orig                         " keeps the original file
" autocmd Filetype text setlocal textwidth=20
filetype plugin on
filetype indent on

" syntax options

set t_Co=256
set background=light
syntax enable
" syntax clear - disable syntax highlighting for a moment
" syntax off - disable syntax highlighting permanently
colorscheme vitamins
set cursorline
hi CursorLine cterm=bold ctermbg=234




" configure tags - add additional tags here or comment out not-used ones
set tags+=~/.vim/tags/cpp
set tags+=~/.vim/tags/gl
set tags+=~/.vim/tags/sdl
set tags+=~/.vim/tags/qt4
" build tags of your own project with Ctrl-F12
map <C-F12> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

" OmniCppComplete
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview

autocmd Filetype java setlocal omnifunc=javacomplete#Complete
autocmd FileType php set ft=php.laravel

" if has("autocmd")
"       autocmd Filetype java setlocal omnifunc=javacomplete#Complete
"         autocmd Filetype java setlocal completefunc=javacomplete#CompleteParamsInfo
" endif
au BufRead *.php set ft=php.html
au BufNewFile *.php set ft=php.html

" NERDTree snippets ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
let g:NERDTreeWinPos = "right"

" Editor ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
set tw=0
set clipboard=unnamed

" Session in vim -------------------------------------------------------------------------------------------------------------------------------------------------------------------------
" Save session on quitting Vim
autocmd VimLeave * NERDTreeClose
" autocmd VimLeave * mksession! [filename]

" Restore session on starting Vim
" autocmd VimEnter * call MySessionRestoreFunction()
" autocmd VimEnter * NERDTree

" Windows -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
autocmd BufEnter * silent! lcd %:p:h
noremap ;a 10<c-w><c-w>
noremap ;1  1<c-w><c-w>
noremap ;2  2<c-w><c-w>
noremap ;3  3<c-w><c-w>
noremap ;4  4<c-w><c-w>
noremap ;5  5<c-w><c-w>
noremap ;6  6<c-w><c-w>
noremap ;7  7<c-w><c-w>
noremap ;8  8<c-w><c-w>
noremap ;9  9<c-w><c-w>

" Backup and original file -------------------------------------------------------------------------------------------------------------------------------------------------------------
" set backupdir=./.backup/

execute pathogen#infect()

" Set filetype tab spaces
autocmd Filetype html,css,xml :setlocal sw=2 ts=2 sts=2
au BufNewFile,BufRead *.jade set filetype=html
autocmd BufRead,BufNewFile *.jade setlocal ft=jade

" Vim indent guides
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=233
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=234
autocmd BufReadPre,FileReadPre * :IndentGuidesEnable


" Python folding
set foldmethod=indent
set foldnestmax=2
noremap <space> za
noremap <NUL> zR

" File manipulation
noremap tt  :tab split<CR>
map ;; :vertical wincmd f<CR>

" Emmet mapping
imap <c-]> <c-y>,

" Vim vertical line at 80
set colorcolumn=80
highlight ColorColumn ctermbg=234 guibg=234
