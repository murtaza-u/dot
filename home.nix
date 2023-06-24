{ pkgs, ... }@inputs:

{
  imports = [
    ./modules/home-manager
    ./modules/chromium
    ./modules/direnv
    ./modules/git
    ./modules/gpg
    ./modules/newsboat
    ./modules/rofi
    ./modules/theme
    ./modules/zathura
    ./modules/helix
    ./modules/nvim
    ./modules/emacs
    ./modules/vifm
    ./modules/alacritty
  ];

  home.packages = with pkgs; [
    xclip
    gimp
    lm_sensors
    nsxiv
    mpv
    vscodium
    ispell
    simplescreenrecorder
    filezilla
    virt-manager
  ] ++ [ inputs.zpkgs.default ];
}
