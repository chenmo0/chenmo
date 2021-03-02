" 设置leader键
let mapleader=','

" 切换buffer保留撤销
set hidden

" nvim新功能，替换时预览
set inccommand=split

" c语言自动缩进
" set cindent

" 使用系统剪切板
set clipboard=unnamedplus

" 80行
set cc=81

" 设置 jj 为esc
inoremap jj <Esc>
" vnoremap jj <Esc>

" 规范缩进
nnoremap <leader>vv gg0<c-v>G=''

" 高亮当前光标行列
set cursorline
" set cursorcolumn

" 更快的提示时间
set updatetime=300

" 自动将 Tab 转为空格
set expandtab

" tab键转为4个空格
set softtabstop=4
set ts=4 sw=4 et
set tabstop=4

" 打开语法高亮
syntax on

" 在底部显示，当前处于哪种模式
set showmode

" 命令模式下，在底部显示，当前键入的指令
set showcmd

" 使用 utf-8 编码
set encoding=utf-8

" 启用256色
set t_Co=256

" 在txt和markdown文件中启用折行和行号，其他文件中关闭
function YesorNoWrap()
    if &filetype=="txt"||&filetype=="markdown"
        set wrap number
        set signcolumn=auto
        nnoremap <buffer> j gj
        nnoremap <buffer> k gk
    else
        set nowrap nonumber
        set signcolumn=yes
    endif
endfunction
autocmd FileType * call YesorNoWrap()

" 垂直滚动时，光标距离顶部/底部的位置
" set scrolloff=5

" 是否显示状态栏。0 表示不显示，1 表示只在多窗口时显示，2 表示显示
set laststatus=2

" 在状态栏显示光标的当前位置
set ruler

" 光标遇到圆括号、方括号、大括号时，自动高亮对应的另一个圆括号、方括号和大括号
set showmatch

" 搜索时，高亮显示匹配结果
set hlsearch

" 输入搜索模式时，每输入一个字符，就自动跳到第一个匹配的结果
set incsearch

" 不创建备份文件
set nobackup

" 多出一行提示信息空间
" set cmdheight=2

" 编辑的时候不需要备份文件
set nowritebackup

" 出错时，不要发出响声
set noerrorbells

" 打开文件监视。如果在编辑过程中文件发生外部改变（比如被别的编辑器编辑了），就会发出提示
set autoread

" 命令模式下，底部操作指令按下 Tab 键自动补全
set wildmenu
set wildmode=longest:list,full

" 长行平滑后移
set sidescroll=1

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" vim-plug配置
call plug#begin('~/.config/nvim/plugged')

" 使终端中vim主题颜色正常
Plug 'vim-scripts/CSApprox' 

" 缩进块
" Plug 'nathanaelkane/vim-indent-guides'

" 括号自动补全
Plug 'jiangmiao/auto-pairs'

" 高亮要查看的单词 <leader>k开启 <leader>K关闭
Plug 'lfv89/vim-interestingwords'

" 快捷注释
Plug 'tpope/vim-commentary'

" glsl高亮
Plug 'tikhomirov/vim-glsl'

" 回车快速选中
Plug 'gcmt/wildfire.vim'

" 'S'加字符，可以把选中部分用此字符包裹
Plug 'tpope/vim-surround'

" 启动界面
Plug 'mhinz/vim-startify'

" 快速生成html代码
Plug 'mattn/emmet-vim'

" have插件
Plug 'jdonaldson/vaxe'

" c类语言根据语义高亮，依赖coc.nvim和coc-clangd
Plug 'jackguo380/vim-lsp-cxx-highlight'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" coc.nvim配置
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" coc插件列表
let g:coc_global_extensions = [ 
            \'coc-clangd', 
            \'coc-cmake', 
            \'coc-css', 
            \'coc-emmet', 
            \'coc-eslint', 
            \'coc-html', 
            \'coc-json', 
            \'coc-omnisharp', 
            \'coc-pyright', 
            \'coc-sh', 
            \'coc-tsserver', 
            \'coc-vimlsp',
            \'coc-actions',
            \'coc-explorer',
            \]

" 使用'K'查看文档
function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
    else
        execute '!' . &keywordprg . " " . expand('<cword>')
    endif
endfunction
nnoremap <silent> K :call <SID>show_documentation()<CR>

" 按住光标时突出显示符号及其参考
autocmd CursorHold * silent call CocActionAsync('highlight')

" 重命名快捷键
nmap <leader>rn <Plug>(coc-rename)

" 重新定义 <C-f> 和 <C-b> 用来滚动浮动窗口
if has('nvim-0.4.0') || has('patch-8.2.0750')
    nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
    inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
    vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" 使用 :Format 格式化当前缓冲区
command! -nargs=0 Format :call CocAction('format')

" 状态行支持
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" 使用'<leader>n'跳转到前一个错误，'<leader>m'跳转到后一个错误
nmap <silent> <leader>n <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>m <Plug>(coc-diagnostic-next)

" 跳转到代码导航
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" coc-actions配置
function! s:cocActionsOpenFromSelected(type) abort
    execute 'CocCommand actions.open ' . a:type
endfunction
xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" coc-explorer启动目录
nnoremap <leader>ff :CocCommand explorer<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" hlsl语法高亮
Plug 'beyondmarc/hlsl.vim'

" 启用此插件
set rtp^=/path/to/hlsl.vim

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 在浏览器中预览markdown，依赖node.js和全局yarn
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

" 自定义css样式地址，写最完整地址或用'~'代替用户目录写为expand('~/a.css')
" let g:mkdp_markdown_css = expand('~/.config/nvim/markdown_css/a.css')

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" c#插件
Plug 'OmniSharp/omnisharp-vim'

" 使用本机mono
let g:OmniSharp_server_use_mono = 1

" 使用OmniSharp-roslyn的stdio版本
let g:OmniSharp_server_stdio = 1

" 关闭语法高亮
let g:OmniSharp_highlighting = 0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" onedark主题
Plug 'joshdick/onedark.vim'

" nvim加载完成后启用onedark主题
autocmd VimEnter * colorscheme onedark

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 状态行美化
Plug 'vim-airline/vim-airline'

" airline主题
Plug 'vim-airline/vim-airline-themes'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 缩进线
Plug 'Yggdroot/indentLine'

" 在json,markdown,scheme文件中关闭缩进线，在其他文件中打开
function NoIndentLine()
    if &filetype=='json' || &filetype=='scheme' || &filetype=='markdown'
        let g:indentLine_conceallevel=0
    else
        let g:indentLine_conceallevel=2
    endif
endfunction
autocmd FileType * call NoIndentLine()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 查看代码结构
Plug 'preservim/tagbar'

" 设置快捷键
nnoremap <leader>tt :TagbarToggle<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 彩虹括号
Plug 'luochen1990/rainbow'

" 启用彩虹括号
let g:rainbow_active = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 代码格式化
Plug 'sbdchd/neoformat'

" 设置neoformat快捷键
nnoremap <leader>bb :Neoformat<CR>

" 设置各种文件格式化的所用可执行文件地址，必须写最完整地址
" javascript
let g:neoformat_javascript_jsbeautify = {
            \ 'exe': '/home/chenmo/node_modules/.bin/js-beautify',
            \ }
let g:neoformat_enabled_javascript=['jsbeautify']

" json
let g:neoformat_json_jsbeautify = {
            \ 'exe': '/home/chenmo/node_modules/.bin/js-beautify',
            \ }
let g:neoformat_enabled_json=['jsbeautify']

" lua
let g:neoformat_lua_luafmt = {
            \ 'exe': '/home/chenmo/node_modules/.bin/luafmt',
            \ }
let g:neoformat_enabled_lua=['luafmt']

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" lisp相关
Plug 'vim-scripts/paredit.vim'

" 括号内回车不自动生成空行
let g:paredit_electric_return=0

call plug#end()
