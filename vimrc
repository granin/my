
"a




"I prefer to use textile with txt files. To tell vim that it should treat txt files as Textile add the following line to your ~/.vim/ftdetect/txt.vim:
"http://www.zalas.eu/textile-in-vim-edit-your-text-files-with-wiki-markup

au BufRead,BufNewFile *.txt     set filetype=textile

if version >= 700
"   По умолчанию проверка орфографии выключена.
    setlocal spell spelllang=
    setlocal nospell
    function ChangeSpellLang()
        if &spelllang =~ "en_us"
            setlocal spell spelllang=ru
            echo "spelllang: ru"
        elseif &spelllang =~ "ru"
            setlocal spell spelllang=
            setlocal nospell
            echo "spelllang: off"
        else
            setlocal spell spelllang=en_us
            echo "spelllang: en"
        endif
    endfunc

    " map spell on/off for English/Russian
    map <F11> <Esc>:call ChangeSpellLang()<CR>
endif



" убираем звук переключения раскладки
set vb t_vb=
" раскладка 
" set keymap=russian-jcukenwin 
" set iminsert=0

" Toggle spell checking on and off with `,s`
let mapleader = ","
nmap <silent> <leader>s :set spell!<CR>
 
" Set region to British English
" и русский
:setlocal spell spelllang=ru,en_us
"
"backup system 
"

" включить сохранение резервных копий
set backup

" сохранять умные резервные копии ежедневно
function! BackupDir()
	" определим каталог для сохранения резервной копии
	let l:backupdir=$HOME.'/.vim/backup/'.
			\substitute(expand('%:p:h'), '^'.$HOME, '~', '')

	" если каталог не существует, создадим его рекурсивно
	if !isdirectory(l:backupdir)
		call mkdir(l:backupdir, 'p', 0700)
	endif

	" переопределим каталог для резервных копий
	let &backupdir=l:backupdir

	" переопределим расширение файла резервной копии
	let &backupext=strftime('~%Y-%m-%d~')
endfunction

" выполним перед записью буффера на диск
autocmd! bufwritepre * call BackupDir()


" хранить больше истории команд ...
set history=128

" ... и правок
set undolevels=2048

" хранить swap в отдельном каталоге
set directory=~/.vim/swap/

" меньше приоритета бинарным файлам при автодополнении
set suffixes+=.png,.gif,.jpg,.jpeg,.ico

" информация о положении курсора в строке статуса
set statusline+=%=Col:%3*%03c%*\ Ln:%3*%04l/%04L%*

" информация о типе и атрибутах файла в строке статуса
" set statusline+=%(\ File:%3*%{join(filter([&filetype,&fileformat!=split(&fileformats,\",\")[0]?&fileformat:\"\",&fileencoding!=split(&fileencodings,\",\")[0]?&fileencoding:\"\"],\"!empty(v:val)\"),\"/\")}%*%)

" показывать имя буфера в заголовке терминала
set title

" формат заголовка
set titlestring=%t%(\ %m%)%(\ %r%)%(\ %h%)%(\ %w%)%(\ (%{expand(\"%:p:~:h\")})%)\ -\ VIM

" удалять лишние пробелы при отступе
set shiftround

" не менять позицию курсора при прыжках по буферу
set nostartofline

" расстояние до края при вертикальной прокрутке
set scrolloff=3

" размер прыжка при вертикальной прокрутке
set scrolljump=10 
" расстояние до края при горизонтальной прокрутке
set sidescrolloff=3

" размер прыжка при горизонтальной прокрутке
set sidescroll=10

" разбивать окно горизонтально снизу
set splitbelow

" разбивать окно вертикально справа
set splitright

" не выравнивать размеры окон при закрытии
set noequalalways

" не вставлять лишних пробелов при объединении строк
set nojoinspaces

" подсвечивать некоторые символы
set list

" установим символы для подсветки
if has("unix")
	set listchars=tab:❘-,trail:·,extends:»,precedes:«,nbsp:×
else
	set listchars=tab:+-,trail:?,extends:>,precedes:<,nbsp:?
endif

if has("unix")

	" кодировка по-умолчанию
	set encoding=utf-8

endif

" порядок перебора кодировок
set fileencodings=utf-8,windows-1251,iso-8859-15,koi8-r

" порядок перебора типов EOL
set fileformats=unix,dos,mac

" максимальное число вкладок
set tabpagemax=99

" отключить автоматическое открытие новой строки комментария
set formatoptions-=o

if has("folding")

	" сворачивать по отступам
	set foldmethod=indent

	" не сворачивать рекурсивно
	set foldlevel=99
endif

" --- аббревиатуры ---

" дизайнерская рыба
inoreabbrev lorem Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi.<C-O>:call EatChar()<CR>

" --- подсветка ---

" подсветка строки статуса
highlight user1 term=bold cterm=inverse,bold ctermbg=green gui=inverse,bold guibg=#8AE234
highlight user2 term=bold cterm=inverse,bold ctermbg=red gui=inverse,bold guibg=#EF2929
highlight user3 term=bold cterm=inverse,bold ctermbg=blue gui=inverse,bold guibg=#729FCF

" подсветка непечатаемых символов
highlight specialkey ctermfg=lightgray guifg=#D3D7CF
highlight nontext ctermfg=gray guifg=#D3D7CF

" подсветка вкладок
highlight tabline term=none cterm=none ctermbg=lightgray gui=none guibg=#D3D7CF
highlight tablinefill term=none cterm=none ctermbg=lightgray gui=none guibg=#D3D7CF

" исправить отступы при вставке из внешнего буфера
nnoremap <silent>,p u:set paste<CR>.:set nopaste<CR>:echo "pasted text fixed"<CR>

" сохранять выделение при визуальном изменении отступа
vnoremap < <gv
vnoremap > >gv

" более логичное копирование во внутренний буфер
nnoremap Y y<END>

" более логичная запись макроса
nnoremap Q qq

" не выгружать скрытые буферы
set hidden

" перечитывать изменённые файлы автоматически
set autoread

"Настроим кол-во символов пробелов, которые будут заменять \t

set tabstop=4
set shiftwidth=4
set smarttab
set et 

set wrap " попросим Vim переносить длинные строки

set ai " включим автоотступы для новых строк

"set cin " включим отступы в стиле Си

"http://habrahabr.ru/blogs/vim/64224/#habracut

set tabstop=4
set shiftwidth=4
set smarttab
set expandtab
set smartindent

"Далее настроим поиск и подсветку результатов поиска и совпадения скобок
set showmatch 
set hlsearch
set incsearch
set ignorecase
set smartcase " Vim ищет игнорируя регистр если искомое выражение не содержит большие буквы, в противном случае учитывает регистр.
"set lz " ленивая перерисовка экрана при выполнении скриптов
"
"Показываем табы в начале строки точками
set listchars=tab:··
set list

" показывать совпадающие скобки для HTML-тегов
set matchpairs+=<:>

" сделать строку команд больше
set cmdheight=2

" сделать окно команд больше
set cmdwinheight=16

" показывать строку вкладок всегда
set showtabline=2

" показывать строку статуса всегда
set laststatus=2

" информация о флагах файла и его пути в строке статуса
set statusline=%1*%m%*%2*%r%*%3*%h%w%*%{expand(\"%:p:~\")}\ %<

"Порядок применения кодировок и формата файлов

set ffs=unix,dos,mac
set fencs=utf-8,cp1251,koi8-r,ucs-2,cp866

" поиск слова под курсором не целиком

"nnoremap * g*N


"nnoremap # g#N

" не перепрыгивать через длинные строки при включённом переносе строк
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap <DOWN> gj
nnoremap <UP> gk
vnoremap <DOWN> gj
vnoremap <UP> gk
inoremap <DOWN> <C-O>gj
inoremap <UP> <C-O>gk

" сохранять строку курсора при page up/down
nnoremap <PAGEUP> <C-U>
nnoremap <PAGEDOWN> <C-D>
inoremap <PAGEUP> <C-O><C-U>
inoremap <PAGEDOWN> <C-O><C-D>
vnoremap <PAGEUP> <C-U>
vnoremap <PAGEDOWN> <C-D>

" --- функции ---


set paste # "При копипасте корректно проставляются все отступы
set pastetoggle=
"Insert newline without entering insert mode
map <S-Enter> O<Esc>
nnoremap <C-J> ciW<CR><Esc>:if match( @", "^\\s*$") < 0<Bar>exec "norm P-$diw+"<Bar>endif<CR>

"(Shift)Enter to toggle INSERT
function! ToggleEnterMapping()
  if empty(mapcheck('<CR>', 'i'))
    inoremap <CR> <Esc>`^
    return "\<Esc>"
  else
    iunmap <CR>
    return "\<CR>"
  endif
endfunction
call ToggleEnterMapping()
inoremap <expr> <S-CR> ToggleEnterMapping()
" Optional (so <CR> cancels prefix, selection, operator).
nnoremap <CR> <Esc>
vnoremap <CR> <Esc>gV
onoremap <CR> <Esc>

map ,v :vsp $MYVIMRC<CR>
map ,V :source $MYVIMRC<CR>
autocmd! bufwritepost $VIM/.vimrc source $VIM/.vimrc
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2008 Jul 02
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc
 let g:PreviewBrowsers=' firefox,safari,epiphany,google-chrome,opera' 
 let g:PreviewCSSPath='/path/to/css/file'
 let g:PreviewTextileExt='textile,txt'


" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif
if has("gui_macvim")
    let macvim_hig_shift_movement = 1
endif

