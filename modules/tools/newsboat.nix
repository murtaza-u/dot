{ config, lib, ... }:

{
  options = {
    tools.newsboat.enable = lib.mkEnableOption "Enable newsboat";
  };

  config = lib.mkIf config.tools.newsboat.enable {
    programs.newsboat = {
      enable = true;
      autoReload = false;
      urls = [
        {
          url = "https://murtazau.xyz/rss.xml";
          tags = [ "technology" ];
        }
      ];
      extraConfig = ''
        bind-key j down
        bind-key k up
        bind-key j next articlelist
        bind-key k prev articlelist
        bind-key J next-feed articlelist
        bind-key K prev-feed articlelist
        bind-key G end
        bind-key g home
        bind-key d pagedown
        bind-key u pageup
        bind-key l open
        bind-key h quit
        bind-key a toggle-article-read
        bind-key n next-unread
        bind-key N prev-unread
        bind-key D pb-download
        bind-key U show-urls
        bind-key x pb-delete

        color listnormal        default default
        color listnormal_unread default default
        color listfocus         default default reverse bold
        color listfocus_unread  default default reverse bold
        color info              default default reverse
        color background        default default
        color article           default default
      '';
    };
  };
}
