" ~/Code/dotfiles/.vim/sessions/termJs.vim:
" Vim session script.
" Created by session.vim 2.13.1 on 22 May 2017 at 20:22:34.
" Open this file in Vim and run :source % to restore your session.

if exists('g:syntax_on') != 1 | syntax on | endif
if exists('g:did_load_filetypes') != 1 | filetype on | endif
if exists('g:did_load_ftplugin') != 1 | filetype plugin on | endif
if exists('g:did_indent_on') != 1 | filetype indent on | endif
if &background != 'light'
	set background=light
endif
if !exists('g:colors_name') || g:colors_name != 'vitamins' | colorscheme vitamins | endif
call setqflist([])
let SessionLoad = 1
if &cp | set nocp | endif
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/Code/terminology
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +2 static/js/app.js
badd +9 static/js/views/main/mainCommentsCV.js
badd +10 static/js/views/main/mainCommentV.js
badd +41 app/models/post.py
badd +1 static/js/models/postM.js
badd +3 static/js/models/commentM.js
badd +3 static/js/models/authorM.js
badd +6 static/js/collections/postsC.js
badd +11 static/js/collections/commentsC.js
badd +5 static/js/collections/authorsC.js
badd +11 app/models/user.py
badd +4 static/js/router.js
badd +2 static/js/controller.js
badd +11 static/templates/main/main-post.html
badd +3 static/templates/main/featured-post.html
badd +0 static/templates/main/main-comment.html
badd +10 static/templates/post/regular-comment.html
badd +27 static/templates/main/layout.html
badd +56 app/routes.py
badd +182 static/postcss/main.css
badd +0 static/templates/post/layout.html
badd +0 static/templates/post/comment-section.html
badd +0 static/templates/post/featured-comment.html
badd +0 static/templates/post/recommended-post.html
badd +12 static/js/views/main/mainPostV.js
badd +0 static/js/views/main/mainPostsCV.js
badd +0 static/js/views/main/featuredPostV.js
argglobal
silent! argdel *
$argadd static/js/app.js
edit static/js/views/main/featuredPostV.js
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd _ | wincmd |
split
1wincmd k
wincmd w
wincmd w
wincmd _ | wincmd |
split
1wincmd k
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winminheight=1 winheight=1 winminwidth=1 winwidth=1
exe '1resize ' . ((&lines * 24 + 25) / 51)
exe 'vert 1resize ' . ((&columns * 98 + 98) / 197)
exe '2resize ' . ((&lines * 23 + 25) / 51)
exe 'vert 2resize ' . ((&columns * 98 + 98) / 197)
exe '3resize ' . ((&lines * 24 + 25) / 51)
exe 'vert 3resize ' . ((&columns * 98 + 98) / 197)
exe '4resize ' . ((&lines * 23 + 25) / 51)
exe 'vert 4resize ' . ((&columns * 98 + 98) / 197)
argglobal
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=10
setlocal fen
7
silent! normal! zo
let s:l = 7 - ((6 * winheight(0) + 12) / 24)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
7
normal! 032|
wincmd w
argglobal
edit static/js/views/main/mainPostsCV.js
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=10
setlocal fen
11
silent! normal! zo
let s:l = 13 - ((12 * winheight(0) + 11) / 23)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
13
normal! 026|
wincmd w
argglobal
edit static/js/router.js
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=10
setlocal fen
4
silent! normal! zo
5
silent! normal! zo
9
silent! normal! zo
let s:l = 9 - ((8 * winheight(0) + 12) / 24)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
9
normal! 0
wincmd w
argglobal
edit static/js/app.js
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=10
setlocal fen
25
silent! normal! zo
28
silent! normal! zo
33
silent! normal! zo
42
silent! normal! zo
44
silent! normal! zo
48
silent! normal! zo
49
silent! normal! zo
51
silent! normal! zo
54
silent! normal! zo
54
silent! normal! zo
73
silent! normal! zo
73
silent! normal! zo
let s:l = 1 - ((0 * winheight(0) + 11) / 23)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1
normal! 0
wincmd w
exe '1resize ' . ((&lines * 24 + 25) / 51)
exe 'vert 1resize ' . ((&columns * 98 + 98) / 197)
exe '2resize ' . ((&lines * 23 + 25) / 51)
exe 'vert 2resize ' . ((&columns * 98 + 98) / 197)
exe '3resize ' . ((&lines * 24 + 25) / 51)
exe 'vert 3resize ' . ((&columns * 98 + 98) / 197)
exe '4resize ' . ((&lines * 23 + 25) / 51)
exe 'vert 4resize ' . ((&columns * 98 + 98) / 197)
tabedit static/js/models/authorM.js
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd _ | wincmd |
split
wincmd _ | wincmd |
split
2wincmd k
wincmd w
wincmd w
wincmd w
wincmd _ | wincmd |
split
wincmd _ | wincmd |
split
2wincmd k
wincmd w
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winminheight=1 winheight=1 winminwidth=1 winwidth=1
exe '1resize ' . ((&lines * 16 + 25) / 51)
exe 'vert 1resize ' . ((&columns * 98 + 98) / 197)
exe '2resize ' . ((&lines * 15 + 25) / 51)
exe 'vert 2resize ' . ((&columns * 98 + 98) / 197)
exe '3resize ' . ((&lines * 15 + 25) / 51)
exe 'vert 3resize ' . ((&columns * 98 + 98) / 197)
exe '4resize ' . ((&lines * 16 + 25) / 51)
exe 'vert 4resize ' . ((&columns * 98 + 98) / 197)
exe '5resize ' . ((&lines * 15 + 25) / 51)
exe 'vert 5resize ' . ((&columns * 98 + 98) / 197)
exe '6resize ' . ((&lines * 15 + 25) / 51)
exe 'vert 6resize ' . ((&columns * 98 + 98) / 197)
argglobal
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=2
setlocal fml=1
setlocal fdn=10
setlocal fen
4
silent! normal! zo
let s:l = 10 - ((9 * winheight(0) + 8) / 16)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
10
normal! 03|
wincmd w
argglobal
edit static/js/models/commentM.js
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=2
setlocal fml=1
setlocal fdn=10
setlocal fen
4
silent! normal! zo
let s:l = 5 - ((4 * winheight(0) + 7) / 15)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
5
normal! 05|
wincmd w
argglobal
edit static/js/models/postM.js
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=10
setlocal fen
4
silent! normal! zo
let s:l = 12 - ((11 * winheight(0) + 7) / 15)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
12
normal! 023|
wincmd w
argglobal
edit static/js/collections/authorsC.js
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=2
setlocal fml=1
setlocal fdn=10
setlocal fen
5
silent! normal! zo
let s:l = 9 - ((8 * winheight(0) + 8) / 16)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
9
normal! 0
wincmd w
argglobal
edit static/js/collections/commentsC.js
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=2
setlocal fml=1
setlocal fdn=10
setlocal fen
5
silent! normal! zo
let s:l = 1 - ((0 * winheight(0) + 7) / 15)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1
normal! 021|
wincmd w
argglobal
edit static/js/collections/postsC.js
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=2
setlocal fml=1
setlocal fdn=10
setlocal fen
5
silent! normal! zo
let s:l = 1 - ((0 * winheight(0) + 7) / 15)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1
normal! 0
wincmd w
exe '1resize ' . ((&lines * 16 + 25) / 51)
exe 'vert 1resize ' . ((&columns * 98 + 98) / 197)
exe '2resize ' . ((&lines * 15 + 25) / 51)
exe 'vert 2resize ' . ((&columns * 98 + 98) / 197)
exe '3resize ' . ((&lines * 15 + 25) / 51)
exe 'vert 3resize ' . ((&columns * 98 + 98) / 197)
exe '4resize ' . ((&lines * 16 + 25) / 51)
exe 'vert 4resize ' . ((&columns * 98 + 98) / 197)
exe '5resize ' . ((&lines * 15 + 25) / 51)
exe 'vert 5resize ' . ((&columns * 98 + 98) / 197)
exe '6resize ' . ((&lines * 15 + 25) / 51)
exe 'vert 6resize ' . ((&columns * 98 + 98) / 197)
tabedit app/routes.py
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winminheight=1 winheight=1 winminwidth=1 winwidth=1
exe 'vert 1resize ' . ((&columns * 98 + 98) / 197)
exe 'vert 2resize ' . ((&columns * 98 + 98) / 197)
argglobal
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=10
setlocal fen
48
silent! normal! zo
49
silent! normal! zo
62
silent! normal! zo
64
silent! normal! zo
66
silent! normal! zo
let s:l = 72 - ((32 * winheight(0) + 24) / 48)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
72
normal! 048|
wincmd w
argglobal
edit app/models/post.py
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=10
setlocal fen
19
silent! normal! zo
19
normal! zc
27
silent! normal! zo
35
silent! normal! zo
37
silent! normal! zo
40
silent! normal! zo
48
silent! normal! zo
78
silent! normal! zo
80
silent! normal! zo
90
silent! normal! zo
93
silent! normal! zo
101
silent! normal! zo
90
normal! zc
108
silent! normal! zo
113
silent! normal! zo
108
normal! zc
120
silent! normal! zo
122
silent! normal! zo
125
silent! normal! zo
136
silent! normal! zo
200
silent! normal! zo
let s:l = 136 - ((78 * winheight(0) + 24) / 48)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
136
normal! 09|
wincmd w
exe 'vert 1resize ' . ((&columns * 98 + 98) / 197)
exe 'vert 2resize ' . ((&columns * 98 + 98) / 197)
tabedit static/templates/post/layout.html
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd _ | wincmd |
split
1wincmd k
wincmd w
wincmd w
wincmd _ | wincmd |
split
1wincmd k
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winminheight=1 winheight=1 winminwidth=1 winwidth=1
exe '1resize ' . ((&lines * 23 + 25) / 51)
exe 'vert 1resize ' . ((&columns * 98 + 98) / 197)
exe '2resize ' . ((&lines * 24 + 25) / 51)
exe 'vert 2resize ' . ((&columns * 98 + 98) / 197)
exe '3resize ' . ((&lines * 24 + 25) / 51)
exe 'vert 3resize ' . ((&columns * 98 + 98) / 197)
exe '4resize ' . ((&lines * 23 + 25) / 51)
exe 'vert 4resize ' . ((&columns * 98 + 98) / 197)
argglobal
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=10
setlocal fen
2
silent! normal! zo
3
silent! normal! zo
5
silent! normal! zo
9
silent! normal! zo
20
silent! normal! zo
21
silent! normal! zo
28
silent! normal! zo
let s:l = 21 - ((12 * winheight(0) + 11) / 23)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
21
normal! 038|
wincmd w
argglobal
edit static/templates/post/comment-section.html
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=10
setlocal fen
2
silent! normal! zo
12
silent! normal! zo
13
silent! normal! zo
14
silent! normal! zo
19
silent! normal! zo
20
silent! normal! zo
21
silent! normal! zo
let s:l = 18 - ((17 * winheight(0) + 12) / 24)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
18
normal! 03|
wincmd w
argglobal
edit static/templates/post/featured-comment.html
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=10
setlocal fen
2
silent! normal! zo
3
silent! normal! zo
6
silent! normal! zo
let s:l = 7 - ((6 * winheight(0) + 12) / 24)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
7
normal! 032|
wincmd w
argglobal
edit static/templates/post/recommended-post.html
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=2
setlocal fml=1
setlocal fdn=10
setlocal fen
2
silent! normal! zo
let s:l = 2 - ((1 * winheight(0) + 11) / 23)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
2
normal! 040|
wincmd w
exe '1resize ' . ((&lines * 23 + 25) / 51)
exe 'vert 1resize ' . ((&columns * 98 + 98) / 197)
exe '2resize ' . ((&lines * 24 + 25) / 51)
exe 'vert 2resize ' . ((&columns * 98 + 98) / 197)
exe '3resize ' . ((&lines * 24 + 25) / 51)
exe 'vert 3resize ' . ((&columns * 98 + 98) / 197)
exe '4resize ' . ((&lines * 23 + 25) / 51)
exe 'vert 4resize ' . ((&columns * 98 + 98) / 197)
tabnext 1
if exists('s:wipebuf')
"   silent exe 'bwipe ' . s:wipebuf
endif
" unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToO
set winminheight=1 winminwidth=1
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save

" Support for special windows like quick-fix and plug-in windows.
" Everything down here is generated by vim-session (not supported
" by :mksession out of the box).

1wincmd w
tabnext 1
if exists('s:wipebuf')
  if empty(bufname(s:wipebuf))
if !getbufvar(s:wipebuf, '&modified')
  let s:wipebuflines = getbufline(s:wipebuf, 1, '$')
  if len(s:wipebuflines) <= 1 && empty(get(s:wipebuflines, 0, ''))
    silent execute 'bwipeout' s:wipebuf
  endif
endif
  endif
endif
doautoall SessionLoadPost
unlet SessionLoad
" vim: ft=vim ro nowrap smc=128
