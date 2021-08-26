if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" :TOhtmlコマンドでxhtmlを吐く
let use_xhtml=1

" カーソルが何行目の何列目に置かれているかを表示
set ruler
" タブの空白幅を半角2個分にする
set tabstop=2
" >>によるインデントのタブ幅を2にする
set shiftwidth=2
" タブをスペースに展開しない
set noexpandtab
" tmuxによるvimの色の変化を防ぐ
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
" end

" EXモードで補完リストの表示
set wildmenu

" 行番号の追加
set number 
" 現在のディレクトリ下全てをfind出来るようにする
set path+=**
" vimでmouse操作の追加(https://yskwkzhr.blogspot.jp/2013/02/use-mouse-on-terminal-vim.html)
set mouse=a
set ttymouse=xterm2
" Escape changes for normal mode in terminal mode
"tnoremap <Esc> <C-W>N
"au BufWinEnter * if &buftype == 'terminal' | setlocal bufhidden=hide | endif

" introduction in https://itchyny.hatenablog.com/entry/2014/12/25/090000
" change a key mapping in normal mode
nnoremap Y y$
" matchした括弧のhilight表示の時間を変更をする
" begin
set showmatch
" set matchtime=1
" end

" 文字コード(https://qiita.com/meio/items/08143eacd174ac0f7bd5)
set encoding=utf-8
set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
" set fileencodings=utf-8
set fileformats=unix,dos,mac

" NerdTree setting
nnoremap <silent><C-e> :NERDTreeToggle<CR>

" start tab settings(https://qiita.com/wadako111/items/755e753677dd72d8036d)
" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()  "{{{
	let s = ''
	for i in range(1, tabpagenr('$'))
		let bufnrs = tabpagebuflist(i)
		let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
		let no = i  " display 0-origin tabpagenr.
		let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
		let title = fnamemodify(bufname(bufnr), ':t')
		let title = '[' . title . ']'
		let s .= '%'.i.'T'
		let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
		let s .= no . ':' . title
		let s .= mod
		let s .= '%#TabLineFill# '
	endfor
	let s .= '%#TabLineFill#%T%=%#TabLine#'
	return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2 " 常にタブラインを表示
"end tab setting

" vimを閉じても、uで履歴を戻せる
set undofile

if &compatible
	"vi互換の動作をやめる
	set nocompatible               " Be iMproved
endif

if exists('*minpac#init')
	call minpac#init()


	" minpac must have {'type': 'opt'} so that it can be loaded with `packadd`.
	call minpac#add('k-takata/minpac', {'type': 'opt'})

	" Add other plugins here
	call minpac#add('tpope/vim-commentary')
	call minpac#add('tpope/vim-surround')
	call minpac#add('tpope/vim-repeat')
	call minpac#add('kana/vim-textobj-user')
	call minpac#add('kana/vim-textobj-entire')
	" call minpac#add('scrooloose/syntastic')

" lint
	" call minpac#add('dense-analysis/ale')

	" colorscheme
	" call minpac#add('flazz/vim-colorschemes')
	" call minpac#add('freeo/vim-kalisi')
	" call minpac#add('tpope/vim-vividchalk')

	" slime
	" call minpac#add('jpalardy/vim-slime')
	"call dein#add('epeli/slimux')

	"filer
" 	call minpac#add('scrooloose/nerdtree')
" 	call minpac#add('woelke/vim-nerdtree_plugin_open')

	" for merlin
	" call minpac#add('ctrlpvim/ctrlp.vim')

	" for csharp
	" call minpac#add('OmniSharp/Omnisharp-vim')

	" for typescript
	" syntax hilighting
	" call minpac#add('HerringtonDarkholme/yats.vim')
	" call minpac#add('Quramy/tsuquyomi', {'do': 'silent! !make'})
endif

" Define user commands for updating/cleaning the plugins.
" " Each of them loads minpac, reloads .vimrc to register the
" " information of plugins, then performs the task.
command! PackUpdate packadd minpac | source $MYVIMRC | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean  packadd minpac | source $MYVIMRC | call minpac#clean()
command! PackStatus packadd minpac | source $MYVIMRC | call minpac#status()

" Required:
filetype plugin indent on
syntax enable

" ## added by OPAM user-setup for vim / base ## 93ee63e278bdfc07d1139a748ed3fff2 ## you can edit, but keep this line
" let s:opam_share_dir = system("opam config var share")
" let s:opam_share_dir = substitute(s:opam_share_dir, '[\r\n]*$', '', '')

" let s:opam_configuration = {}

" function! OpamConfOcpIndent()
	" execute "set rtp^=" . s:opam_share_dir . "/ocp-indent/vim"
" endfunction
" let s:opam_configuration['ocp-indent'] = function('OpamConfOcpIndent')

" function! OpamConfOcpIndex()
	" execute "set rtp+=" . s:opam_share_dir . "/ocp-index/vim"
" endfunction
" let s:opam_configuration['ocp-index'] = function('OpamConfOcpIndex')

" function! OpamConfMerlin()
	" let l:dir = s:opam_share_dir . "/merlin/vim"
	" execute "set rtp+=" . l:dir
" endfunction
" let s:opam_configuration['merlin'] = function('OpamConfMerlin')

" let s:opam_packages = ["ocp-indent", "ocp-index", "merlin"]
" let s:opam_check_cmdline = ["opam list --installed --short --safe --color=never"] + s:opam_packages
" let s:opam_available_tools = split(system(join(s:opam_check_cmdline)))
" for tool in s:opam_packages
	" " Respect package order (merlin should be after ocp-index)
	" if count(s:opam_available_tools, tool) > 0
		" call s:opam_configuration[tool]()
	" endif
" endfor

" jparady/vim-slime  settings
"let g:slime_target = "vimterminal"
"let g:slime_paste_file = "$HOME/.slime_paste"
" end

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" slime

" use tmux for slime
" let g:slime_target = 'tmux'
"let g:slime_target = "vimterminal"
" nmap <c-c><c-l> :SlimeSend0 ""<CR>
" nmap <c-c><c-u> :SlimeSend0 "\x15"<CR>

"let g:slime_paste_file = "$HOME/.slime_paste"
" let g:slime_default_config = {"socket_name": "default", "target_pane": "0.1"}
"let g:slime_default_config = {"socket_name": split($TMUX, ",")[0], "target_pane": ":.2"}
" end

" slimux settings
"let g:slimux_tmux_path = '/snap/bin/tmux'
"end

" nerdtreeをsingle clickで
" let g:NERDTreeMouseMode = 2

"OCamlのシンタックスチェックをmerlinにする
" let g:syntastic_ocaml_checkers = ['merlin']

"NERDTreeでxdg-open可能に
" let g:nerdtree_plugin_open_cmd = 'xdg-open'

" LaTeX settings
" From https://github.com/vim-syntastic/syntastic/issues/2169
" let g:syntastic_tex_lacheck_quiet_messages = { 'regex': '\Vpossible unwanted space at' }

" colorschemeの一部変更
" autocmd colorScheme * highlight Comment ctermfg=92 guifg=#FF00FF
"color schemeの設定
"colorscheme molokai
"let g:airline_theme='kalisi'
colorscheme vividchalk

