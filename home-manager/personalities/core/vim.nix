{
  pkgs,
  ...
}:{
  programs.vim = {
    enable = true;
    defaultEditor = true;

    settings = {
      background = "dark";
      expandtab = true;
      mouse = "a";
      number = true;
      shiftwidth = 4;
      tabstop = 4;
    };

    # Get available plugins with `nix-env -f '<nixpkgs>' -qaP -A vimPlugins`
    plugins = with pkgs.vimPlugins; [
      # TOCO vim-yaml-folds, indentlines
      ale
      ctrlp
      fzf-vim
      fzfWrapper
      gitgutter
      nerdtree
      polyglot
      todo-txt-vim
      vim-zettel
      vimwiki
    ];

    extraConfig = # "${inputs.dotfiles}/.vimrc"
      ''
        """ Until I figure out the vimPlugins packaging stuff..
        if empty(glob('~/.vim/bundle/Vundle.vim'))
        silent !git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
        autocmd VimEnter * :PluginInstall
        endif

        filetype off
        set rtp+=~/.vim/bundle/Vundle.vim
        call vundle#begin()
        Plugin 'akatch/vim-oceans'
        "Plugin 'Einenlum/yaml-revealer'
        call vundle#end()
        filetype plugin indent on
        """

        colorscheme oceans
        set nohlsearch cursorline
        set wildmode=longest,list,full
        set wildmenu
        filetype plugin indent on
        autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
        autocmd BufNew,BufNewFile,BufRead *todo.txt setlocal ft=todo.txt
        autocmd BufNew,BufNewFile,BufRead *.tpl setlocal ft=helm

        " Insert cursor at previous position
        if has("autocmd")
            au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
        endif

        " Keybinds
        nmap <silent> <C-p> :bprevious<cr>
        nmap <silent> <C-n> :bnext<cr>
        nmap <silent> <C-t> :enew<cr>

        nmap <silent> <leader>n :set number!<CR>
        nmap <silent> <leader>p :set paste!<CR>
        nmap <silent> <leader>j :ALENextWrap<CR>
        nmap <silent> <leader>k :ALEPreviousWrap<CR>
        nmap <silent> <leader>t :NERDTreeToggle<CR>
        nmap <silent> <leader>d :r!date "+\%F \%T"<CR>
        nmap <leader>z :ZettelNew<space>
        nmap <silent> <leader>zo :ZettelOpen<CR>

        " pane separators like tmux
        set fillchars+=vert:\│

        " ctrlp
        let g:ctrlp_map = '<s-f>'
        let g:ctrlp_switch_buffer = 'Et'

        " ale
        let g:ale_fix_on_save = 1
        let g:ale_echo_msg_error_str = 'E'
        let g:ale_echo_msg_warning_str = 'W'
        let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
        let g:ale_json_jq_options = '--indent 4'
        let g:ale_fixers = {
        \   '*': ['remove_trailing_lines', 'trim_whitespace'],
        \   'elixir': ['mix_format'],
        \   'go': ['goimports', 'gofmt', 'gopls'],
        \   'javascript': ['prettier'],
        \   'json': ['jq'],
        \   'terraform': ['terraform'],
        \}

        let g:ale_linters = {
        \    'go': ['gofmt', 'golint', 'go vet', 'gopls', 'golangci-lint'],
        \    'ansible': ['ansible-lint'],
        \    'elixir': ['elixir-ls'],
        \    'perl': ['perlcritic'],
        \    'terraform': ['terraform'],
        \    'ruby': ['rubocop'],
        \    'javascript': ['eslint'],
        \    'bicep': ['bicep'],
        \}

        let g:go_highlight_array_whitespace_error = 1
        let g:go_highlight_chan_whitespace_error = 1
        let g:go_highlight_extra_types = 1
        let g:go_highlight_space_tab_error = 1
        let g:go_highlight_trailing_whitespace_error = 1
        let g:go_highlight_operators = 1
        let g:go_highlight_functions = 1
        let g:go_highlight_function_parameters = 1
        let g:go_highlight_function_calls = 1
        let g:go_highlight_types = 1
        let g:go_highlight_fields = 1
        let g:go_highlight_build_constraints = 1
        let g:go_highlight_generate_tags = 1
        let g:go_highlight_variable_declarations = 1
        let g:go_highlight_variable_assignments = 1
        let g:go_doc_url = "https://pkg.go.dev"

        let g:gitgutter_async = 1

        " zk
        let g:vimwiki_list = [{'path': $HOME + '/' + $ZETTEL_DIR,'ext':'.md', 'syntax':'markdown'}]
        let g:zettel_format = "%Y%m%d%H%M"

        hi TabLine       term=none     cterm=none ctermbg=none ctermfg=239
        hi TabLineFill   term=none     cterm=none ctermbg=none ctermfg=233
        hi TabLineSel    term=none     cterm=none ctermbg=none ctermfg=130
        hi SignColumn    term=none                ctermbg=none
        hi StatusLine    term=none     cterm=none ctermbg=none ctermfg=239
        hi CursorLine    term=reverse  cterm=none ctermbg=233  ctermfg=none

        hi link GitGutterAdd DiffAdd
        hi link GitGutterChange DiffChange
        hi link GitGutterDelete DiffDelete
        hi link GitGutterChangeDelete DiffChange
      '';
  };
}
