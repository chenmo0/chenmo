"设置leader键
let mapleader=','

" 切换buffer保留撤销
set hidden

"nvim新功能，替换时预览
set inccommand=split

"显示行数
" set number

"c语言自动缩进
"set cindent

"使用系统剪切板
set clipboard=unnamedplus

"80行
set cc=81

"设置 jj 为esc
inoremap jj <Esc>
"vnoremap jj <Esc>

"规范缩进
nnoremap <leader>vv gg0<c-v>G=''

"高亮当前光标行列
set cursorline
"set cursorcolumn

"不兼容vi快捷键
set nocompatible

"更快的提示时间
set updatetime=300

"tab键设为4格
set tabstop=4

"自动将 Tab 转为空格
set expandtab

"Tab 转为多少个空格
set softtabstop=4
set ts=4 sw=4 et

"打开语法高亮
syntax on

"在底部显示，当前处于命令模式还是插入模式
set showmode

"命令模式下，在底部显示，当前键入的指令
set showcmd

"使用 utf-8 编码
set encoding=utf-8

"启用256色
set t_Co=256

"不自动折行
set nowrap

"垂直滚动时，光标距离顶部/底部的位置
"set scrolloff=5

"是否显示状态栏。0 表示不显示，1 表示只在多窗口时显示，2 表示显示
set laststatus=2

"在状态栏显示光标的当前位置
set ruler

"光标遇到圆括号、方括号、大括号时，自动高亮对应的另一个圆括号、方括号和大括号
set showmatch

"搜索时，高亮显示匹配结果
set hlsearch

"输入搜索模式时，每输入一个字符，就自动跳到第一个匹配的结果
set incsearch

"不创建备份文件
set nobackup

"多出一行提示信息空间
" set cmdheight=2

"编辑的时候不需要备份文件
set nowritebackup

"出错时，不要发出响声
set noerrorbells

"打开文件监视。如果在编辑过程中文件发生外部改变（比如被别的编辑器编辑了），就会发出提示
set autoread

"命令模式下，底部操作指令按下 Tab 键自动补全
set wildmenu
set wildmode=longest:list,full

"长行平滑后移
set sidescroll=1


" 留出提示列空间
if has("patch-8.1.1564")
  " 新版(neo)vim合并提示列和行号列
  set signcolumn=number
else
  set signcolumn=yes
endif

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"vim-plug配置
call plug#begin('~/.config/nvim/plugged')

Plug 'vim-scripts/CSApprox' "使终端中vim主题颜色正常
Plug 'jackguo380/vim-lsp-cxx-highlight' "语义突出显示
"Plug 'nathanaelkane/vim-indent-guides' "缩进线
Plug 'jiangmiao/auto-pairs' "括号自动补全
Plug 'lfv89/vim-interestingwords' "高亮要查看的单词 <leader>k开启 <leader>K关闭
Plug 'tpope/vim-commentary' "快捷注释
Plug 'tikhomirov/vim-glsl' "glsl高亮
Plug 'gcmt/wildfire.vim' "回车快速选中
Plug 'tpope/vim-surround' "'S'加字符，可以把选中部分用此字符包裹
Plug 'mhinz/vim-startify' "启动界面

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

Plug 'joshdick/onedark.vim' "onedark主题
autocmd VimEnter * colorscheme onedark

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

Plug 'OmniSharp/omnisharp-vim' "c#插件

" 使用本机mono
let g:OmniSharp_server_use_mono = 1

" 使用OmniSharp-roslyn的stdio版本
let g:OmniSharp_server_stdio = 1

" 关闭语法高亮
let g:OmniSharp_highlighting = 0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

Plug 'neoclide/coc.nvim', {'branch': 'release'} "coc.nvim配置

" 使用K现实文档
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

" 符号重命名
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

"使用 :Format 格式化当前缓冲区
command! -nargs=0 Format :call CocAction('format')

"状态行支持
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" 使用'[g'跳转到前一个错误，']g'跳转到后一个错误
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

" coc-explorer启动目录
nnoremap <leader>ff :CocCommand explorer<CR>

" vim启动后打开文件目录
" autocmd VimEnter * CocCommand explorer

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

Plug 'mattn/emmet-vim' "快速生成html代码
" nnoremap <c-,> <c-y>,

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

Plug 'vim-airline/vim-airline' "状态行美化
Plug 'vim-airline/vim-airline-themes' "airline主题

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

Plug 'Yggdroot/indentLine' "缩进线 
autocmd FileType json,markdown,scheme let g:indentLine_conceallevel=0
autocmd FileType javascript,python,c,cpp,java,vim,shell let g:indentLine_conceallevel=2


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

Plug 'preservim/tagbar' "代码文本结构
nnoremap <leader>tt :TagbarToggle<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

Plug 'luochen1990/rainbow' "彩虹括号
let g:rainbow_active = 1 "启用彩虹括号

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

Plug 'sbdchd/neoformat' "代码格式化
"设置neoformat快捷键
nnoremap <leader>bb :Neoformat<CR>

"设置js格式化的所用程序
let g:neoformat_javascript_jsbeautify = {
            \ 'exe': '/home/chenmo/node_modules/.bin/js-beautify',
            \ }
let g:neoformat_enabled_javascript=['jsbeautify']

"设置json格式化的所用程序
let g:neoformat_json_jsbeautify = {
            \ 'exe': '/home/chenmo/node_modules/.bin/js-beautify',
            \ }
let g:neoformat_enabled_json=['jsbeautify']

"设置lua格式化的所用程序
let g:neoformat_lua_luafmt = {
            \ 'exe': '/home/chenmo/node_modules/.bin/luafmt',
            \ }
let g:neoformat_enabled_lua=['luafmt']

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

Plug 'vim-scripts/paredit.vim' "lisp相关
autocmd FileType javascript,python,c,cpp,java,vim,shell,lua,json,markdown,csharp inoremap <cr> <cr>
autocmd FileType scheme imap <cr> <a-cr>

call plug#end()
