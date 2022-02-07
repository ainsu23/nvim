
""""" Plugings
call plug#begin()
Plug 'jalvesaq/Nvim-R', {'branch': 'stable'}

" nerdtree
Plug 'preservim/nerdtree'

" ncm code completion
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-bufword'
Plug 'gaalcaras/ncm-R'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-cssomni'
Plug 'ncm2/ncm2-tern'

" telescope requirements...
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" others
Plug 'dense-analysis/ale'
call plug#end()

vmap <Space> <Plug>RDSendSelection
nmap <Space> <Plug>RDSendLine
map <leader>nn :NERDTreeToggle<CR>

set nocompatible               " be iMproved
filetype off                   " required!
set expandtab
set tabstop=4
set number! relativenumber!
set colorcolumn=80
autocmd FileType r inoremap <buffer> <C-k> <Esc>:normal! a %>%<CR>a

autocmd FileType r setlocal sw=2
let b:ale_linters = ['lintr', 'styler', 'eslint', 'hadolint', 'jq', 'sqlint', 'swaglint']
let b:ale_fixers = { '*': ['remove_trailing_lines','trim_whitespace'],'r': ['styler']}
let g:ale_fix_on_save = 1
"let g:ale_completion_enabled = 1
let g:ale_sign_column_always = 1
let g:ale_set_signs = 1
set signcolumn=yes:1
let r_indent_align_args = 0
filetype plugin indent on
let g:ale_r_lintr_lint_package = 1
:tnoremap <C-n> <C-\><C-n>


" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()
autocmd FileType TelescopePrompt  call ncm2#disable_for_buffer()
set completeopt=noinsert,menuone,noselect
" uppress the annoying 'match x of y', 'The only match' and 'Pattern not
" found' messages
set shortmess+=c

noremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

au User Ncm2Plugin call ncm2#register_source({
            \ 'name' : 'css',
            \ 'priority': 9,
            \ 'subscope_enable': 1,
            \ 'scope': ['css','scss'],
            \ 'mark': 'css',
            \ 'word_pattern': '[\w\-]+',
            \ 'complete_pattern': ':\s*',
            \ 'on_complete': ['ncm2#on_complete#omni', 'csscomplete#CompleteCSS'],
            \ })

nnoremap <C-p> <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <C-o> <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <C-f> <cmd>lua require('telescope.builtin').live_grep()<cr>
