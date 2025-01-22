










"=======================主設定開始=======================
set list
set fileencoding=utf8
set listchars=eol:¶,tab:->,space:·
"set listchars=eol:¶,tab:->
filetype indent on
syntax enable
set nu
set rnu
set ai
set smarttab
set cindent
set undolevels=10000
set backspace=indent,eol,start
set nowrap
set showmatch
set errorbells
set autoindent
"set smartindent
"set smarttab
set hlsearch
"set smartcase
syntax enable
set t_Co=256
"set background=dark
set cmdheight=1
"
set cursorline
set cursorcolumn
"set nocursorline
set nocompatible
set hlsearch 
hi Search cterm=reverse ctermbg=none ctermfg=none 
set incsearch 
set cindent 
set tabstop=2
set softtabstop=2
set shiftwidth=2
set smarttab
set confirm 
set laststatus=2 
set statusline=%#fname#[\ %{Fname()}\ ]%#ftype#\ [\ %Y\ ]%#fs#\ [\ %{FileSize()}\ ]%#redc#\ %{S()}\ %=%#left#%l/%L:%c\ %p%%\ %#fs#[\ %{&ff}\ ]
hi CursorLine cterm=underline ctermbg=235 ctermfg=none guibg=#003300
hi CursorColumn cterm=none ctermbg=none ctermfg=none
hi fname cterm=bold,underline	ctermbg=235 ctermfg=2 gui=bold,underline guibg=#222222 guifg=#008800
hi ftype cterm=none ctermbg=235 ctermfg=4 gui=none guibg=#222222 guifg=#000088
hi fs cterm=none ctermbg=235 ctermfg=4 gui=none guibg=#222222 guifg=#000088
hi redc cterm=bold ctermbg=235 ctermfg=1 gui=bold guibg=#222222 guifg=#880000
hi left cterm=none ctermbg=235 ctermfg=5 gui=none guibg=#222222 guifg=#880088
hi Comment cterm=bold ctermbg=none ctermfg=4 gui=bold guifg=#000088
hi LineNr cterm=bold ctermbg=none ctermfg=12 gui=bold guifg=#0000ff "行號颜色
hi CursorLineNr cterm=bold ctermbg=none ctermfg=9 gui=bold guifg=#ff0000 "當前行行號颜色
highlight MyTabSpace cterm=none ctermbg=none ctermfg=8
match MyTabSpace /\t\| \|\n/
highlight GitGutterAdd    ctermfg=2
highlight GitGutterChange ctermfg=4
highlight GitGutterDelete ctermfg=1



set updatetime=1

set showcmd 
set showmode
set autowrite
set mouse=a

function Fname()
	if expand("%")==""
		return "___"
	else 
		return expand("%")
	endif
endfunction


function FileSize()
	let bytes = getfsize(expand("%:p"))
	let b = bytes % 1024
	let bytes = bytes / 1024
	let k = bytes % 1024
	let bytes = bytes / 1024
	let m = bytes % 1024
	let bytes = bytes / 1024
	let g = bytes % 1024
	let bytes = bytes / 1024
	let t = bytes % 1024
	let bytes = bytes / 1024
	return t."TB ".g."GB ".m."MB ".k."KB ".b."B"
endfunction


function S()
	let re=""
	if &modified
		if re!=""
			let re=re.","
		endif
		let re=re."+"
	endif
	if &readonly
		if re!=""
			let re=re.","
		endif
		let re=re."R"
	endif
	if re!=""
		let re="[ ".re." ]"
	endif
	return re
endfunction

command Reset execute "normal! Atext" | :0 | :del 100000000 | :r basic.cpp | :194
command Build :w | :!sh build.sh -f %
command Run :!sh run.sh
command Cat :!sh out.sh -f %
command W :w
command Q :q
command WQ :wq
command Wq :wq






