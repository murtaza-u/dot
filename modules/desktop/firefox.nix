{ config, pkgs, lib, ... }:
let
  lock-false = {
    Value = false;
    Status = "locked";
  };
  lock-true = {
    Value = true;
    Status = "locked";
  };
  firefoxUiFix = pkgs.fetchFromGitHub {
    owner = "black7375";
    repo = "Firefox-UI-Fix";
    rev = "v8.6.5";
    sha256 = "sha256-8sRUGrKcSBDzqIjACR7eRfn4VzFbL3zfRB8GDsNKO5A=";
  };
in
{
  options = {
    desktop.firefox.enable = lib.mkEnableOption "Enable firefox";
  };

  config = lib.mkIf config.desktop.firefox.enable {
    programs.firefox = {
      enable = true;
      policies = {
        DisableFirefoxAccounts = true;
        DisableAccounts = true;
        DisableFirefoxScreenshots = true;
        DisableFirefoxStudies = true;
        DisableFormHistory = true;
        DisablePasswordReveal = true;
        DisableTelemetry = true;
        DNSOverHTTPS = true;
        DontCheckDefaultBrowser = true;
        DisablePocket = true;
        OverrideFirstRunPage = "";
        OverridePostUpdatePage = "";
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
        DisplayBookmarksToolbar = "never"; # alternatives: "always" or "newtab"
        DisplayMenuBar = "default-off"; # alternatives: "always", "never" or "default-on"
        SearchBar = "unified"; # alternative: "separate"
        Preferences = {
          "browser.contentblocking.category" = { Value = "strict"; Status = "locked"; };
          "extensions.pocket.enabled" = lock-false;
          "extensions.screenshots.disabled" = lock-true;
          "browser.topsites.contile.enabled" = lock-false;
          "browser.formfill.enable" = lock-false;
          "browser.search.suggest.enabled" = lock-false;
          "browser.search.suggest.enabled.private" = lock-false;
          "browser.urlbar.suggest.searches" = lock-false;
          "browser.urlbar.showSearchSuggestionsFirst" = lock-false;
          "browser.newtabpage.activity-stream.feeds.section.topstories" = lock-false;
          "browser.newtabpage.activity-stream.feeds.snippets" = lock-false;
          "browser.newtabpage.activity-stream.section.highlights.includePocket" = lock-false;
          "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = lock-false;
          "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = lock-false;
          "browser.newtabpage.activity-stream.section.highlights.includeVisited" = lock-false;
          "browser.newtabpage.activity-stream.showSponsored" = lock-false;
          "browser.newtabpage.activity-stream.system.showSponsored" = lock-false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = lock-false;
        };
      };
      profiles = {
        default = {
          id = 0;
          name = "default";
          isDefault = true;
          search = {
            force = true;
            default = "DuckDuckGo";
            privateDefault = "DuckDuckGo";
          };
          userChrome = builtins.readFile "${firefoxUiFix}/userChrome.css";
          userContent = builtins.readFile "${firefoxUiFix}/userContent.css";
          extensions = with pkgs.nur.repos.rycee.firefox-addons; [
            ublock-origin
            privacy-badger
            vimium
          ];
        };
      };
    };
  };
}
