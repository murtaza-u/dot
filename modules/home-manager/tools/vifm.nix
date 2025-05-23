{ config, lib, ... }:

{
  options = {
    tools.vifm.enable = lib.mkEnableOption "Enable vifm";
  };

  config = lib.mkIf config.tools.vifm.enable {
    programs.vifm = {
      enable = true;
      extraConfig = ''
        set vicmd=nvim
        set syscalls
        set trash
        set history=1000
        set nofollowlinks
        set sortnumbers
        set undolevels=100
        set vimhelp
        set norunexec
        set timefmt=%m/%d\ %H:%M
        set wildmenu
        set wildstyle=popup
        set ignorecase
        set smartcase
        set incsearch
        set nohlsearch
        set scrolloff=5
        set timeoutlen=300

        filetype * xdg-open %f

        highlight clear
        highlight Border cterm=none	ctermfg=none ctermbg=default
        highlight TopLine cterm=none ctermfg=none ctermbg=none
        highlight TopLineSel cterm=bold	ctermfg=none ctermbg=none
        highlight Win cterm=none ctermfg=none ctermbg=default
        highlight CmdLine cterm=none ctermfg=none ctermbg=default

        " Open all images in current directory in sxiv thumbnail mode
        nnoremap tx :!nsxiv -t %d & <cr>

        " Start shell in current directory
        nnoremap s :shell<cr>

        " Display sorting dialog
        nnoremap S :sort<cr>

        " Toggle visibility of preview window
        nnoremap w :view<cr>
        vnoremap w :view<cr>gv

        " Mappings for faster renaming
        nnoremap I cw<c-a>
        nnoremap cw cw<c-u>
        nnoremap A cw

        nnoremap e :edit<cr>
        nnoremap <space> :select<CR>
        nnoremap md :mkdir<space>
        nnoremap mf :touch<space>
      '';
    };
  };
}
