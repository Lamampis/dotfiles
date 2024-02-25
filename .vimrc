filetype on
syntax on
set number
set cursorline
set nobackup
set nowrap
set ignorecase
set noswapfile
set bg=dark
syntax on
filetype plugin indent on
let g:gruvbox_contrast_dark = 'medium'
set bg=dark
autocmd vimenter * ++nested colorscheme gruvbox
let g:NERDTreeWinPos = "right"
autocmd VimEnter * if !argc() | NERDTree | endif | wincmd w
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree")
      \ && b:NERDTree.isTabTree()) | q | endif
map <C-n> :NERDTreeToggle<CR>
call plug#begin()
 Plug 'morhetz/gruvbox'
 Plug 'preservim/nerdtree'
 Plug 'vim-airline/vim-airline'
 Plug 'vim-airline/vim-airline-themes'
call plug#end()
let g:airline_theme='minimalist'
" air-line
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif


" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '' 
