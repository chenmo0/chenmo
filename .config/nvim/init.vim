" 设置leader键
let mapleader=','

" 切换buffer保留撤销
set hidden

" nvim新功能, 替换时预览
set inccommand=split

" c语言自动缩进
" set cindent

" 使用系统剪切板
set clipboard=unnamedplus

" 80行
set cc=81

" 设置 jj 为esc
inoremap jj <Esc>

" 规范缩进
nnoremap <leader>vv gg0<c-v>G=''

" 高亮当前光标行列
set cursorline
" set cursorcolumn

" 更快的提示时间
set updatetime=300

" tab键转为n个空格
set expandtab
autocmd FileType * set tabstop=4 shiftwidth=4 softtabstop=4
autocmd FileType dart set tabstop=2 shiftwidth=2 softtabstop=2

" 打开语法高亮
syntax on

" 强制高亮引擎从第一行开始解析文件, 防止解析错误，大文件时会很慢
" autocmd BufEnter *.md :syn sync fromstart

" 强制高亮引擎从100行前开始解析文件
autocmd BufEnter *.md :syn sync minlines=100

" 使用 utf-8 编码
set encoding=utf-8

" 启用256色
set t_Co=256

" 默认关闭折行,关闭行号,开启两列提示列
autocmd FileType * set nowrap nonumber signcolumn=yes

" txt文件中开启折行,开启行号,关闭提示列,行内上下移
autocmd FileType text set wrap number signcolumn=auto
autocmd FileType text nnoremap <buffer> j gj
autocmd FileType text nnoremap <buffer> k gk

" 垂直滚动时, 光标距离顶部/底部的位置
" set scrolloff=5

" 是否显示状态栏。0 表示不显示, 1 表示只在多窗口时显示, 2 表示显示
set laststatus=2

" 光标遇到圆括号、方括号、大括号时, 自动高亮对应的另一个圆括号、方括号和大括号
set showmatch

" 搜索时, 高亮显示匹配结果
set hlsearch

" 输入搜索模式时, 每输入一个字符, 就自动跳到第一个匹配的结果
set incsearch

" 不创建备份文件
set nobackup

" 编辑的时候不需要备份文件
set nowritebackup

" 出错时, 不要发出响声
set noerrorbells

" 打开文件监视。如果在编辑过程中文件发生外部改变（比如被别的编辑器编辑了）, 就会发出提示
set autoread

" 命令模式下, 底部操作指令按下 Tab 键自动补全
set wildmenu
set wildmode=longest:list,full

" 长行平滑后移
set sidescroll=1

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" f5 一键运行
function s:Return_sh()
    let cd_p = 'cd '.expand('`pwd`').';'
    let f_n = expand('%')
    if &filetype == 'markdown'
        return 'zsh ~/bin/markdeep/markdeep_run.sh '.f_n
    elseif filereadable('./run.sh')
        return cd_p.'zsh ./run.sh'
    elseif &filetype == 'python'
        return cd_p.'python3 '.f_n
    elseif &filetype == 'javascript'
        return cd_p.'node '.f_n
    elseif &filetype == 'scheme'
        return cd_p.'chezscheme --script '.f_n
    elseif &filetype == 'html'
        return cd_p.'google-chrome-stable '.f_n
    elseif &filetype == 'c'
        return cd_p.'gcc '.f_n.' -o '.f_n.'.out && ./'.f_n.'.out'
    elseif &filetype == 'sh'
        return cd_p.'zsh '.f_n
    else
        return 'echo "运行指令未定义"'
    endif
endfunction
function s:Run()
    execute '!'.s:Return_sh()
endfunction
function s:New_tmux_run()
    let a = system('echo "'.s:Return_sh().'" > ~/.config/nvim/.ghost')
    let b = system('tmux split-window')
endfunction
noremap <f5> <esc><esc><esc>:wa<cr>:call <SID>Run()<cr>
nnoremap <leader><f5> <esc><esc><esc>:wa<cr>:call <SID>New_tmux_run()<cr>





" vim-plug配置
call plug#begin('~/.config/nvim/plugged')

" 使终端中vim主题颜色正常
Plug 'vim-scripts/CSApprox' 

" 缩进块
" Plug 'nathanaelkane/vim-indent-guides'

" 高亮要查看的单词 <leader>k开启 <leader>K关闭
Plug 'lfv89/vim-interestingwords'

" 快捷注释
Plug 'tpope/vim-commentary'

" glsl高亮
Plug 'tikhomirov/vim-glsl'

" 回车快速选中
Plug 'gcmt/wildfire.vim'

" 'S'加字符, 可以把选中部分用此字符包裹
Plug 'tpope/vim-surround'

" 启动界面
Plug 'mhinz/vim-startify'

" 快速生成html代码
Plug 'mattn/emmet-vim'

" c类语言根据语义高亮, 依赖coc.nvim和coc-clangd
Plug 'jackguo380/vim-lsp-cxx-highlight'

" dart 语法识别
Plug 'dart-lang/dart-vim-plugin'

" 浮动终端
Plug 'voldikss/vim-floaterm'

" unicode图标
" Plug 'ryanoasis/vim-devicons'

" 颜色文本突出显示
" Plug 'norcalli/nvim-colorizer.lua'

" 显示快捷键
" Plug 'liuchengxu/vim-which-key'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" fzf
Plug 'junegunn/fzf', {'dir': '~/.fzf','do': './install --all'}
Plug 'junegunn/fzf.vim' 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" coc.nvim配置
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" coc-fzf
Plug 'antoinemadec/coc-fzf', {'branch': 'release'}

" coc插件列表
let g:coc_global_extensions = [ 
            \'coc-clangd', 
            \'coc-clang-format-style-options',
            \'coc-cmake', 
            \'coc-css', 
            \'coc-emmet', 
            \'coc-eslint', 
            \'coc-explorer',
            \'coc-flutter',
            \'coc-html', 
            \'coc-highlight',
            \'coc-json', 
            \'coc-omnisharp', 
            \'coc-pyright', 
            \'coc-rust-analyzer',
            \'coc-sh', 
            \'coc-tabnine',
            \'coc-translator',
            \'coc-tsserver', 
            \'coc-vetur',
            \'coc-vimlsp',
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

" 光标不动时突出光标所在显示符号及其参考
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

" 使用'<leader>n'跳转到前一个错误, '<leader>N'跳转到后一个错误
nmap <silent> <leader>n <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>N <Plug>(coc-diagnostic-next)

" 跳转到代码导航
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" 使用'<leader>a'对当前所选区域操作
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" coc-explorer启动目录
nnoremap <leader>ff :CocCommand explorer<CR>

" coc-translator快捷键
nnoremap <leader>tr :CocCommand translator.popup<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" godot
Plug 'habamax/vim-godot'

" 设置godot可执行文件
let g:godot_executable='/var/lib/flatpak/exports/bin/org.godotengine.Godot'

autocmd FileType gdscript nnoremap <buffer> <f5> <esc>:wa<cr>:GodotRun<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 括号自动补全
Plug 'jiangmiao/auto-pairs'

" 在scheme文件中关闭此功能: 删除空括号中前括号便同时删除后括号
autocmd FileType * let g:AutoPairsMapBS=1
autocmd FileType scheme,vim let g:AutoPairsMapBS=0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 复制时高亮复制的内容
Plug 'machakann/vim-highlightedyank'

map y <Plug>(highlightedyank)

" 设置高亮的时间,负数时一直高亮
let g:highlightedyank_highlight_duration = 1000

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" hlsl语法高亮
Plug 'beyondmarc/hlsl.vim'

" 启用此插件
set rtp^=/path/to/hlsl.vim

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 在浏览器中预览markdown, 依赖node.js和全局yarn
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

" ${name}将替换为文件名
let g:mkdp_page_title = '「${name}」'

" 自定义css样式地址, 写最完整地址或用'~'代替用户目录写为expand('~/path/xxx.css')
" let g:mkdp_markdown_css = expand('~/.config/nvim/markdown_css/github.css')
let g:mkdp_markdown_css = expand('~/work/md_demo/aaa.css')

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

" 使用python-mode样式折叠
let g:vim_markdown_folding_style_pythonic = 1

" 防止设置折叠文本
let g:vim_markdown_override_foldtext = 0

" 文字强调限制为单行
let g:vim_markdown_emphasis_multiline = 0

" 语法隐藏
set conceallevel=2

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
" autocmd VimEnter * colorscheme onedark

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 状态行美化
Plug 'vim-airline/vim-airline'

" airline主题
Plug 'vim-airline/vim-airline-themes'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 缩进线
Plug 'Yggdroot/indentLine'

autocmd FileType * let g:indentLine_conceallevel=2
autocmd FileType json,scheme,markdown let g:indentLine_conceallevel=0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 查看代码结构
Plug 'preservim/tagbar'

" 设置快捷键
nnoremap <leader>ta :TagbarToggle<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 彩虹括号
Plug 'luochen1990/rainbow'

" 启用彩虹括号
let g:rainbow_active = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 代码格式化, 所用的格式化可执行程序需要在环境变量中
Plug 'sbdchd/neoformat'

" 设置neoformat快捷键
nnoremap <leader>bb :Neoformat<cr>

" markdown文件中格式化后重新加载文件
autocmd FileType markdown nmap <buffer> <leader>bb :Neoformat<cr>:w<cr>:e<cr>zv

" dart 使用 :Format
autocmd FileType dart nnoremap <buffer> <leader>bb :Format<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" lisp相关
Plug 'vim-scripts/paredit.vim'

" 括号内回车不自动生成空行
let g:paredit_electric_return=0

call plug#end()

colorscheme onedark
