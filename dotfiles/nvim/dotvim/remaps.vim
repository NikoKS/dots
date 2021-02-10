" Core Remaps {{{
"Utility and General Shortcuts
nnoremap <silent> <esc> :noh<return><esc>
nnoremap = :wincmd =<CR>
nnoremap v <C-v>
nnoremap r <C-r>
nnoremap <Tab> ;
vnoremap <Tab> ;
"nmap '' <C-o>
nmap <BS> <C-o>
nmap <DEL> <C-o>
nnoremap m zz
nnoremap M m
nnoremap O J

"Better copy paste
vnoremap y <Nop>
vnoremap xx y
vnoremap xa "ay
vnoremap xb "by
vnoremap xc "+y
nmap x y
nnoremap yx yy
nnoremap ya "aY
nnoremap yb "bY
nnoremap yc "+Y
nnoremap pp p
nnoremap p <Nop>
nnoremap PP P
nnoremap pa "ap
nnoremap Pa "aP
nnoremap pb "bp
nnoremap Pb "bP
nnoremap pc "+p
nnoremap Pc "+P
nnoremap pd "1p
nnoremap Pd "1P
nnoremap px "0p
nnoremap Px "0P

"More sensible cw dw and yw
nnoremap cw ciw
nnoremap cW ciW
nnoremap dw daw
nnoremap dW daW
nnoremap yw yiw
nnoremap yW yiW
nmap ce cia
nmap de daa

"g remaps
nnoremap gs z=
nnoremap gw *

"Quit and write shortcuts
nnoremap Q :qa<CR>
nnoremap qw ZZ
nnoremap qq :q<CR>
nnoremap qa :qa<CR>
nnoremap qe :q!<CR>
nnoremap ;w :w<CR>
nnoremap zz :stop<CR>

"Navigation Remaping
nnoremap j gj
nnoremap k gk
nnoremap J Lzz
nnoremap K Hzz
vnoremap J Lzz
vnoremap K Hzz
nnoremap H ^
vnoremap H ^
nnoremap L $
vnoremap L $
nnoremap w b
nnoremap W B
vnoremap w b
vnoremap W B

"buffer navigation
set wildcharm=<C-z>
nnoremap bl :ls<CR>
nnoremap b<Tab> :b <C-z>
nnoremap <silent> bn :bNext<CR>
nnoremap <silent> bp :bprevious<CR>
nnoremap bb :b#<CR>
nnoremap ba :badd 
nnoremap bv :vert sb <C-z>
nnoremap bs :sb <C-z>

"Open Shortcuts
nnoremap o<Tab> :edit <C-z>
nnoremap oo o
nnoremap oh :edit ~/
nnoremap ov :vert split 
nnoremap os :split 
nnoremap or :edit ./README.md
nnoremap oi :VimwikiIndex<CR>
nnoremap od :VimwikiMakeDiary<CR>

"Fold shorcuts
nnoremap <space> za
nnoremap zo zr
nnoremap zO zR
nnoremap zc zm
nnoremap zC zM

"faster indent
nnoremap > >>
nnoremap < <<
vnoremap < <gv
vnoremap > >gv

"split Settings
set splitbelow
set splitright
nnoremap <Leader>< :vert resize -10<CR>
nnoremap <Leader>> :vert resize +10<CR>
nnoremap <Leader>+ :vert resize +10<CR>
nnoremap <Leader>- :vert resize -10<CR>

" misc utilities
nnoremap <Leader>s :setlocal spell!<CR>
nnoremap <Leader>t :r! date "+\%a, \%d-\%b-\%Y, \%I:\%M \%p"<CR>
nnoremap <Leader><Leader> <C-w><C-p>
nnoremap <Leader>1 1<c-w><c-w>
nnoremap <Leader>2 2<c-w><c-w>
nnoremap <Leader>3 3<c-w><c-w>
inoremap <C-s> ✩

"Disable Ex mode
map q: <Nop>
map q <Nop>

" Plugin Extra Remaps ###############################################
"Sneak remap 
nnoremap <silent> f :<C-U>call sneak#wrap('',           1, 0, 1, 1)<CR>
nnoremap <silent> F :<C-U>call sneak#wrap('',           1, 1, 1, 1)<CR>
xnoremap <silent> f :<C-U>call sneak#wrap(visualmode(), 1, 0, 1, 1)<CR>
xnoremap <silent> F :<C-U>call sneak#wrap(visualmode(), 1, 1, 1, 1)<CR>
onoremap <silent> f :<C-U>call sneak#wrap(v:operator,   1, 0, 1, 1)<CR>
onoremap <silent> F :<C-U>call sneak#wrap(v:operator,   1, 1, 1, 1)<CR>
map <tab> <Plug>Sneak_;

" Vim Surround
nmap ysw ysiw
nmap s ys
vmap s S

"toggle comment
nmap # <leader>c<space>
vmap # <leader>c<space>

" }}}

" Kitty Navigation
inoremap <silent> <C-h> <Esc>:KittyNavigateLeft<CR>
inoremap <silent> <C-j> <Esc>:KittyNavigateDown<CR>
inoremap <silent> <C-k> <Esc>:KittyNavigateUp<CR>
inoremap <silent> <C-l> <Esc>:KittyNavigateRight<CR>

"CocActions
nmap <Leader>d<space> :call CocAction('diagnosticToggle')<CR>
nmap <Leader>dl :<C-u>CocFzfList diagnostics --current-buf<CR>

"File explorer shortcuts (coc-explorer)
nmap <silent> <Leader>n :CocCommand explorer<CR>

" Tagbar
nnoremap <Leader>m :TagbarOpen fj<CR>
