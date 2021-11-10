set number
let g:airline_powerline_fonts = 1
let g:airline_theme='violet'
let g:airline_solarized_bg='dark'
set splitbelow
set mouse=a
set incsearch
nmap <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeNodeDelimiter = "\u00a0"
set noswapfile
set noshowmode
nmap <C-t> :term<CR>
