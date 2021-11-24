set clipboard+=unnamedplus
"save with zz shortcut"
nnoremap zz :update!<cr>
"change
"SHORTCUTS ====================================="
let g:mapleader=',' " remap leader key to , 
nmap <leader>n :NERDTreeToggle<CR> "  <leader>n - Toggle NERDTree on/off
nmap <leader>f :NERDTreeFind<CR> "<leader>f - Opens current file location in NERDTree
nnoremap <leader>g :<c-u>:Gwrite<bar>Git commit -m WIP<bar>Git push<cr> //map commit push to github
nnoremap <leader>w :w<cr> "write fie
nnoremap <leader>q :q<cr> "close file/window
nmap <C-h> <C-w>h " Quick window switching
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
nmap <silent> <leader>b :Bracey<CR> "Bracey shortcut"

"PLUGINS ==========================================
" Install vim-plug if not found
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin('~/.config/nvim/plugged')

" editing ------------------------------ "
"Plug 'ntpeters/vim-better-whitespace' " Trailing whitespace highlighting & automatic fixing
Plug 'rstacruz/vim-closer' " auto-close plugin
Plug 'easymotion/vim-easymotion' " Improved motion in Vim
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Intellisense Engine
Plug 'Shougo/neosnippet' " Snippet support
Plug 'Shougo/neosnippet-snippets' " Snippet support
Plug 'Shougo/echodoc.vim' " Print function signatures in echo area
Plug 'taku-o/vim-copypath' "copy path from NERDTREE 
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" git ---------------------------------- "
" Enable git changes to be shown in sign column
Plug 'mhinz/vim-signify' "uses sign column to indicate added, modified and removed
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter' "other option to see git changes on gutter
" java -------------------------------- "
" Typescript syntax highlighting
Plug 'HerringtonDarkholme/yats.vim'
Plug 'mxw/vim-jsx' " ReactJS JSX syntax highlighting
Plug 'heavenshell/vim-jsdoc' " Generate JSDoc commands based on function signature

" syntax highlight -----------------------"
Plug 'chr4/nginx.vim' " Syntax highlighting for nginx
Plug 'othree/javascript-libraries-syntax.vim' " Syntax highlighting for javascript libraries
Plug 'othree/yajs.vim' " Improved syntax highlighting and indentation

"code ---------------------------------------"
Plug 'sheerun/vim-polyglot' "language pack
Plug 'dense-analysis/ale' "ale linting assistant

" ui ----------------------------------------"
Plug 'scrooloose/nerdtree' " File explorer
Plug 'mhinz/vim-startify' "Startify
Plug 'vim-airline/vim-airline' " Customized vim status line
Plug 'vim-airline/vim-airline-themes' " Customized vim status line
Plug 'ryanoasis/vim-devicons' " Icons
Plug 'tiagofumo/vim-nerdtree-syntax-highlight' " Icons
Plug 'davidgranstrom/nvim-markdown-preview' "markdown
Plug 'turbio/bracey.vim', {'do': 'npm install --prefix server'} "Bracey
Plug 'tpope/vim-commentary' "Vim commentary

"theme ----------------------------------------
" Plug 'dracula/vim'
Plug 'mhartington/oceanic-next'

call plug#end()

""CONFIG ========================================

" "Dracula config"
" if (has("termguicolors"))
"  set termguicolors
" endif
" syntax enable
" colorscheme dracula

"set nonumber "disable line numbers
set noshowcmd " Don't show last command
set clipboard=unnamed " Yank and paste with the system clipboard

set hidden " Hides buffers instead of closing them

" tab/space--------------------------------------- 
set expandtab " Insert spaces when TAB is pressed.
set softtabstop=2 " Change number of spaces that a <Tab> counts for during editing ops
set shiftwidth=2 " Indentation amount for < and > commands.
set nowrap " do not wrap long lines by default

" ui--------------------------------------------
set nocursorline " Don't highlight current cursor line
set noruler " Disable line/column number in status line
set cmdheight=1 " Only one line for command line

" completion ------------------------------------ "

set shortmess+=c " Don't give completion messages like 'match 1 of 2 or 'The only match'


" PLUGINS SETUP ======================================

" === Coc.nvim === "
" use <tab> for trigger completion and navigate to next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

"Close preview window when completion is done.
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" === NeoSnippet === "
" Map <C-k> as shortcut to activate snippet if available
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

" Load custom snippets from snippets folder
let g:neosnippet#snippets_directory='~/.config/nvim/snippets'

" Hide conceal markers
let g:neosnippet#enable_conceal_markers = 0

" === NERDTree === "
let g:NERDTreeShowHidden = 1 " Show hidden files/directories
let g:NERDTreeMinimalUI = 1 " Remove bookmarks and help text from NERDTree
let g:NERDTreeChDirMode = 2
let g:NERDTreeDirArrowExpandable = '⬏' " Custom icons for expandable/expanded directories
let g:NERDTreeDirArrowCollapsible = '⬎'

" Hide certain files and directories from NERDTree
let g:NERDTreeIgnore = ['^\.DS_Store$', '^tags$', '\.git$[[dir]]', '\.idea$[[dir]]', '\.sass-cache$']

" Wrap in try/catch to avoid errors on initial install before plugin is available
try

" === Vim airline ==== "
" Enable extensions
let g:airline_extensions = ['branch', 'hunks', 'coc']

" Update section z to just have line number
let g:airline_section_z = airline#section#create(['linenr'])

" Do not draw separators for empty sections (only for the active window) >
let g:airline_skip_empty_sections = 1

" Smartly uniquify buffers names with similar filename, suppressing common parts of paths.
let g:airline#extensions#tabline#formatter = 'unique_tail'

" Custom setup that removes filetype/whitespace from default vim airline bar
let g:airline#extensions#default#layout = [['a', 'b', 'c'], ['x', 'z', 'warning', 'error']]

" Customize vim airline per filetype
" 'nerdtree'  - Hide nerdtree status line
" 'list'      - Only show file type plus current line number out of total
let g:airline_filetype_overrides = {
  \ 'nerdtree': [ get(g:, 'NERDTreeStatusline', ''), '' ],
  \ 'list': [ '%y', '%l/%L'],
  \ }

" Enable powerline fonts
let g:airline_powerline_fonts = 1

" Enable caching of syntax highlighting groups
let g:airline_highlighting_cache = 1

" Define custom airline symbols
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" Don't show git changes to current file in airline
let g:airline#extensions#hunks#enabled=0

catch
  echo 'Airline not installed. It should work after running :PlugInstall'
endtry

" === echodoc === "
" Enable echodoc on startup
let g:echodoc#enable_at_startup = 1

" === vim-javascript === "
" Enable syntax highlighting for JSDoc
let g:javascript_plugin_jsdoc = 1

" === vim-jsx === "
" Highlight jsx syntax even in non .jsx files
let g:jsx_ext_required = 0

" === javascript-libraries-syntax === "
let g:used_javascript_libs = 'underscore,requirejs,chai,jquery'

" === Signify === "
let g:signify_sign_delete = '-'

" ============================================================================ "
" ===                                UI                                    === "
" ============================================================================ "

" Enable true color support
set termguicolors

" Vim airline theme
let g:airline_theme='hybrid'

" Change vertical split character to be a space (essentially hide it)
set fillchars+=vert:.

" Set preview window to appear at bottom
set splitbelow

" Don't dispay mode in command line (airilne already shows it)
set noshowmode

" Set floating window to be slightly transparent
set winbl=10

" ============================================================================ "
" ===                      CUSTOM COLORSCHEME CHANGES                      === "
" ============================================================================ "
"
" Add custom highlights in method that is executed every time a colorscheme is sourced
" See https://gist.github.com/romainl/379904f91fa40533175dfaec4c833f2f for details
function! TrailingSpaceHighlights() abort
  " Hightlight trailing whitespace
  highlight Trail ctermbg=red guibg=red
  call matchadd('Trail', '\s\+$', 100)
endfunction

function! s:custom_jarvis_colors()
  " coc.nvim color changes
  hi link CocErrorSign WarningMsg
  hi link CocWarningSign Number
  hi link CocInfoSign Type

  " Make background transparent for many things
  hi Normal ctermbg=NONE guibg=NONE
  hi NonText ctermbg=NONE guibg=NONE
  hi LineNr ctermfg=NONE guibg=NONE
  hi SignColumn ctermfg=NONE guibg=NONE
  hi StatusLine guifg=#16252b guibg=#6699CC
  hi StatusLineNC guifg=#16252b guibg=#16252b

  " Try to hide vertical spit and end of buffer symbol
  hi VertSplit gui=NONE guifg=#17252c guibg=#17252c
  hi EndOfBuffer ctermbg=NONE ctermfg=NONE guibg=#17252c guifg=#17252c

  " Customize NERDTree directory
  hi NERDTreeCWD guifg=#99c794

  " Make background color transparent for git changes
  hi SignifySignAdd guibg=NONE
  hi SignifySignDelete guibg=NONE
  hi SignifySignChange guibg=NONE

  " Highlight git change signs
  hi SignifySignAdd guifg=#99c794
  hi SignifySignDelete guifg=#ec5f67
  hi SignifySignChange guifg=#c594c5
endfunction

" autocmd! ColorScheme * call TrailingSpaceHighlights()
autocmd! ColorScheme OceanicNext call s:custom_jarvis_colors()

" Call method on window enter
augroup WindowManagement
  autocmd!
  autocmd WinEnter * call Handle_Win_Enter()
augroup END

" Change highlight group of preview window when open
function! Handle_Win_Enter()
  if &previewwindow
    setlocal winhighlight=Normal:MarkdownError
  endif
endfunction

" Editor theme
set background=dark
try
  colorscheme synthwave84:Q
catch
  colorscheme slate
endtry
" KEYMAPS======================================================

" === coc.nvim === "
"   <leader>dd    - Jump to definition of current symbol
"   <leader>dr    - Jump to references of current symbol
"   <leader>dj    - Jump to implementation of current symbol
"   <leader>ds    - Fuzzy search current project symbols
nmap <silent> <leader>dd <Plug>(coc-definition)
nmap <silent> <leader>dr <Plug>(coc-references)
nmap <silent> <leader>dj <Plug>(coc-implementation)
nnoremap <silent> <leader>ds :<C-u>CocList -I -N --top symbols<CR>

" === vim-better-whitespace === "
"   <leader>y - Automatically remove trailing whitespace
nmap <leader>y :StripWhitespace<CR>

" === Search shorcuts === "
map <leader>h :%s///<left><left> "   <leader>h - Find and replace
nmap <silent> <leader>/ :nohlsearch<CR> "   <leader>/ - Claer highlighted search terms while preserving history


" === Easy-motion shortcuts ==="
"   <leader>w - Easy-motion highlights first word letters bi-directionally
" map <leader>w <Plug>(easymotion-bd-w)

" Allows you to save files you opened without write permissions via sudo
cmap w!! w !sudo tee %

" === vim-jsdoc shortcuts ==="
" Generate jsdoc for function under cursor
nmap <leader>z :JsDoc<CR>

" Delete current visual selection and dump in black hole buffer before pasting
" Used when you want to paste over something without it getting copied to
" Vim's default buffer
vnoremap <leader>p "_dP

"tabs"
nmap <Tab> :bnext<CR>
nmap <S-Tab> :bprevious<CR>

" ============================================================================ "
" ===                                 MISC.                                === "
" ============================================================================ "

" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" === Search === "
" ignore case when searching
set ignorecase

" if the search string has an upper case letter in it, the search will be case sensitive
set smartcase

" Automatically re-read file if a change was detected outside of vim
set autoread

" Enable line numbers
set number

" Enable spellcheck for markdown files
autocmd BufRead,BufNewFile *.md setlocal spell

" Set backups
if has('persistent_undo')
  set undofile
  set undolevels=3000
  set undoreload=10000
endif
set backupdir=~/.config/nvim/backup " Don't put backups in current dir
set backup
set noswapfile

" Reload icons after init source
if exists('g:loaded_webdevicons')
  call webdevicons#refresh()
endif

"Startify
"Startify
" Read ~/.NERDTreeBookmarks file and takes its second column
function! s:nerdtreeBookmarks()
let bookmarks = systemlist("cut -d' ' -f 2 ~/.NERDTreeBookmarks")
let bookmarks = bookmarks[0:-2] " Slices an empty last line
return map(bookmarks, "{'line': v:val, 'path': v:val}")
endfunction

let g:startify_lists = [
\ { 'type': function('s:nerdtreeBookmarks'), 'header': ['   NERDTree Bookmarks']}
\]
let g:startify_lists = [
\ { 'type': 'files',     'header': ['   MRU']            },
\ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
\ { 'type': 'sessions',  'header': ['   Sessions']       },
\ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
\ { 'type': 'commands',  'header': ['   Commands']       },
\ ]

let g:startify_custom_header = [
\'███████╗███████╗████████╗████████╗',
\'╚════██║╚════██║╚══██╔══╝╚══██╔══╝',
\'░░███╔═╝░░███╔═╝░░░██║░░░░░░██║░░░',
\'██╔══╝░░██╔══╝░░░░░██║░░░░░░██║░░░',
\'███████╗███████╗░░░██║░░░░░░██║░░░',
\'╚══════╝╚══════╝░░░╚═╝░░░░░░╚═╝░░░',
\]


"own functions
function! Matches(pat)
    let buffer=bufnr("") "current buffer number
    let b:lines=[]
    execute ":%g/" . a:pat . "/let b:lines+=[{'bufnr':" . 'buffer' . ", 'lnum':" . "line('.')" . ", 'text': escape(getline('.'),'\"')}]"
    call setloclist(0, [], ' ', {'items': b:lines})
    lopen
endfunction




syntax on
filetype plugin on
syntax enable
au BufRead,BufNewFile *.js set filetype=javascript
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS

