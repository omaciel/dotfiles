" Pathogen plugin: https://github.com/tpope/vim-pathogen
execute pathogen#infect()

" Emacs-like commands
:cnoremap <C-a>  <Home>
:cnoremap <C-b>  <Left>
:cnoremap <C-f>  <Right>
:cnoremap <C-d>  <Delete>
:cnoremap <M-b>  <S-Left>
:cnoremap <M-f>  <S-Right>
:cnoremap <M-d>  <S-right><Delete>
:cnoremap <Esc>b <S-Left>
:cnoremap <Esc>f <S-Right>
:cnoremap <Esc>d <S-right><Delete>
:cnoremap <C-g>  <C-c>

" Searching
:set ignorecase             " Ignore case in search patterns
:set hlsearch               " Highlight match while typing search pattern
:set incsearch              " Do incremental searches
:set smartcase              " /foo matches FOO and fOo, but /FOO only matches the former
:nmap \q :nohlsearch<CR>    " Turns off highlighted search

" Buffers
:nmap <C-e> :e#<CR>         " Switch to previously edited buffer
:nmap <C-n> :bnext<CR>
:nmap <C-p> :bprev<CR>
:nmap <C-x>f :CtrlP             " Uses http://kien.github.com/ctrlp.vim/
:nmap <C-x>b :CtrlPBuffer<CR>   " Uses http://kien.github.com/ctrlp.vim/
:let g:ctrlp_custom_ignore = '\v\~$|\.(o|swp|pyc|wav|mp3|ogg|blend)$|(^|[/\\]).(hg|git|bzr)($|[/\\])'

" Force vim to use 256-color support
if $TERM == "xterm-256color" || $TERM == "screen-256color" || $COLORTERM == "gnome-terminal"
    set t_Co=256
endif

" Tabs, tabstops, and softtabs
:set shiftwidth=4
:set tabstop=4
:set softtabstop=4
:set expandtab

:set ai
syntax on
"set number
:set bg=dark
:set nocompatible

" Lots of these things are set by default, but I just want to make sure...
"set foldenable		"set to display all folds open
set showcmd		" Show (partial) command in status line
set ruler		" Turn on ruler
"set number		" Show line numbers
set sm			" Show matching ()'s []'s {}'s
set title		" Put title in title bar
set noerrorbells	" Beeping sucks
set shell=/bin/bash	" Set shell
set history=250		" Set command history length
set showmode		" Show what mode you're in
set autoindent		" Autoindentation
set pastetoggle=<F10>

" Settings for VimClojure
"let vimclojure#HighlightBuiltins = 1
"let vimclojure#ParenRainbow = 1
" Send entire file to repl
"nmap <C-m> ggVG<C-c><C-c>


:nmap <C-d> :call Pylyglot()<CR>
:nmap <C-N><C-N> :set invnumber <CR>
":nmap <silent> <Leader>t :CommandT<CR>
:nmap <silent> <C-t> :CommandT<CR>
:nmap <S-T> :call TrimWhiteSpace()<CR>
:nmap <S-W> :call RemoveWindowsEndLine()<CR>

"map <F8> <Esc>:1,$!xmllint --format -
map <F12> <Esc>:%!gpg --encrypt --armor --recipient ogmaciel@gnome.org<CR><CR><C-l>
map <S-F12> <Esc>:%!gpg --decrypt 2>/dev/null<CR><CR><C-l>
"map <F9> :nohl<CR>
map <F6> <Esc>Oimport epdb; epdb.st()<Esc>
map <F7> gg<Esc>:r !date +\%Y-\%m-\%d<Cr>i - Og Maciel<Esc>
map <F5> gg<Esc>:r !date +\%Y-\%m-\%d<Cr>:r ~/commit.tpl<Cr><Esc>kJ4ddggP3jo<Esc>k$a
map <F4> :call TrimWhiteSpace()<CR>
map <F3> <Esc>a Brazilian Portuguese <ldp-br@bazar2.conectiva.com.br><Esc>
map <F2> <Esc>a Og Maciel <ogmaciel@gnome.org><Esc>
map <F1> <Esc>ggO#!/usr/bin/env python<CR># -*- encoding: utf-8 -*-<CR># vim: ts=4 sw=4 expandtab ai<CR><ESC>
nmap <silent> <Leader>date <Esc>i<C-R>=strftime('%c')<C-R><Esc>
nmap <silent> <Leader>csrf <Esc>a{% csrf_token %}<Esc>

" Don't expandtab for Makefiles
au FileType make setlocal noexpandtab ts=8 sw=8
au FileType automake setlocal noexpandtab ts=8 sw=8
au BufWinEnter * let w:m3=matchadd('ErrorMsg', '\s\+$', -1)
au BufWinEnter * let w:m4=matchadd('ErrorMsg', '^ \+\t\+\|^\t\+ \+', -1)
" Handle tsv files as make files
au BufNewFile,BufRead *.tsv setf automake
" Auto check .po files for format syntax
autocmd BufWritePost,FileWritePost *.po !msgfmt -cvo /dev/null <afile>

" Highlight trailing whitespace, tabs
set list listchars=tab:»·,trail:·
"set listchars=eol:•,tab:↦\ ,trail:»,extends:↷,precedes:↶
"colorscheme gotan
"colorscheme underwater-mod
"colorscheme molokai

vmap <space> zf

function Pylyglot()
    let s:wordUnderCursor = expand("<cword>")
    let s:url = "http://www.pylyglot.org/?languages=pt_BR&query=".s:wordUnderCursor

    let s:browser = "chromium-browser"
    let s:cmd = "silent !" . s:browser . " " . s:url . "&"
    execute s:cmd
endfunction



function TrimWhiteSpace()
    %s/\s*$//
    ''
    :endfunction

function RemoveWindowsEndLine()
    %s/[ \t\r]\+$//e
    ''
    :endfunction

function ToggleFold()
  if foldlevel('.') == 0
     " No fold exists at the current line,
     " so create a fold based on indentation

     let l_min = line('.')   " the current line number
     let l_max = line('$')   " the last line number
     let i_min = indent('.') " the indentation of the current line
     let l = l_min + 1

     " Search downward for the last line whose indentation > i_min
     while l <= l_max
        " if this line is not blank ...
        if strlen(getline(l)) > 0 && getline(l) !~ '^\s*$'
           if indent(l) <= i_min
              " we've gone too far
              let l = l - 1    " backtrack one line
              break
           endif
        endif
        let l = l + 1
     endwhile

     " Clamp l to the last line
     if l > l_max
        let l = l_max
     endif

     " Backtrack to the last non-blank line
     while l > l_min
        if strlen(getline(l)) > 0 && getline(l) !~ '^\s*$'
           break
        endif
        let l = l - 1
     endwhile

     "execute "normal i" . l_min . "," . l . " fold"   " print debug info

     if l > l_min
        " Create the fold from l_min to l
        execute l_min . "," . l . " fold"
     endif
  else
     " Delete the fold on the current line
     normal zd
  endif
endfunction

nmap <space> :call ToggleFold()<CR>

filetype plugin indent on

" =============================================================
" INSERIR CABEÇALHOS EM ARQUIVOS NOVOS - NÃO INSERE DUAS VEZES
" =============================================================
" Esta função testa as 5 primeiras linhas do arquivo
" se nelas já houver "Last Change" ele passa batido
" ou seja não insere o cabeçalho
" usr_41.txt
fun! InsertChangeLog()
    let l:flag=0
    for i in range(1,5)
        if getline(i) !~ '.*Last Change.*'
            let l:flag = l:flag + 1
        endif
    endfor
    if l:flag >= 5
        normal(1G)
        call append(0, "Created: " . strftime("%a %d/%b/%Y %H:%M"))
        call append(1, "Updated: " . strftime("%a %d/%b/%Y %H:%M"))
        call append(2, "Author: Og Maciel <ogmaciel@gnome.org>")
        normal gg
    endif
endfun
map <special> <F8> <esc>:call InsertChangeLog()<cr>


" =============================================================
"   ATUALIZA O CHANGE LOG INSERIDO NA FUNÇÃO ANTERIOR
" =============================================================
" update changefile log
" http://tech.groups.yahoo.com/group/vim/message/51005
" só atualiza o Change log se o arquivo tiver mais que 5 linhas
" e contiver a string "Last Change:"
fun! LastChange()
    let _s=@/
    let l = line(".")
    let c = col(".")
    if line("$") >= 5
        1,5s/\s*Updated:\s*\zs.*/\="" . strftime("%Y %b %d %X")/ge
    endif
    let @/=_s
    call cursor(l, c)
endfun
" precedendo os comandos com keepjumps ele não adiciona o salto
" referente a alteração na lista de saltos, para mais detalhes veja :h keepjumps
autocmd BufWritePre * keepjumps call LastChange()


" =============================================================
"   Pula com <leader>j para marcas do tipo <+site+> 
" =============================================================
" place holders snippets
" File Templates
" --------------
"  <leader>j jumps to the next marker
" iabbr <buffer> for for <+i+> in <+intervalo+>:<cr><tab><+i+>
function! LoadFileTemplate()
    "silent! 0r ~/.vim/templates/%:e.tmpl
    syn match vimTemplateMarker "<+.\++>" containedin=ALL
    hi vimTemplateMarker guifg=#67a42c guibg=#112300 gui=bold
endfunction
function! JumpToNextPlaceholder()
    let old_query = getreg('/')
    echo search("<+.\\++>")
    exec "norm! c/+>/e\<CR>"
    call setreg('/', old_query)
endfunction
autocmd BufNewFile * :call LoadFileTemplate()
nnoremap <leader>j :call JumpToNextPlaceholder()<CR>a
inoremap <leader>j <ESC>:call JumpToNextPlaceholder()<CR>a
