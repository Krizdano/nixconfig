{ pkgs, ... }:

{
  programs = {
    firefox = {
      enable = true;
      # package =
      #   (pkgs.firefox.override {
      policies = {
        DontCheckDefaultBrowser = true;
        DisablePocket = true;
        DisableTelemetry = true;
        DisplayBookmarksToolbar = "never";
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };

        FirefoxHome = {
          Search = false;
          TopSites = false;
          SponsoredTopSites = false;
          Highlights = false;
          Pocket = false;
          SponsoredPocket = false;
          Snippets = false;
          Locked = true;
        };

        UserMessaging = {
          WhatsNew = false;
          ExtensionRecommendations = false;
          FeatureRecommendations = false;
          UrlbarInterventions = false;
          SkipOnboarding = true;
          MoreFromMozilla = false;
        };

        Cookies = {
          Behaviour = "reject-tracker-and-partition-foreign";
        };

        # clear all data on exit
        SanitizeOnShutdown = {
          Cache = true;
          Cookies = true;
          History = true;
          Sessions = true;
          SiteSettings = true;
          FormData = true;
          Downloads = true;
          OfflineApps = true;
          Locked = true;
        };

        NoDefaultBookmarks = true;
        OfferToSaveLogins = false;
        SearchSuggestEnabled = false;
        StartDownloadsInTempDirectory = true;
        DisableFirefoxAccounts = true;
        HardwareAcceleration = true;
        OverrideFirstRunPage = "";
        OverridePostUpdatePage = "";
        NetworkPrediction = false; #Disable DNS prefetching
        PasswordManagerEnabled = false;
        PromptForDownloadLocation = true;

        Homepage = {
          URL = "file:///persist/home/nixconfig/config/firefoxCSS/homepage/index.html";
          StartPage = "homepage";
          Locked = true;
        };

        ExtensionSettings = {
          # vimium c 
          "vimium-c@gdh1995.cn" = {
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/vimium-c/latest.xpi";
          };

          # darkreader
          "addon@darkreader.org" = {
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
          };

          # tree style tabs
          "treestyletab@piro.sakura.ne.jp" = {
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/tree-style-tab/latest.xpi";
          };

          # ublock origin
          "uBlock0@raymondhill.net" = {
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          };

          # imagus (image enlarger)
          "{00000f2a-7cde-4f20-83ed-434fcb420d71}" = {
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/imagus/latest.xpi";
          };

          # keepassxc
          "keepassxc-browser@keepassxc.org" = {
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/keepassxc-browser/latest.xpi";
          };

          # multi-account-containers
          "@testpilot-containers" = {
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/multi-account-containers/latest.xpi";
          };

        };


        Preferences = {
          "browser.crashReports.unsubmittedCheck.autoSubmit2" = {
            Value = false;
            Status = "locked";
          };

          "browser.selfsupport.url" = {
            Value = "";
            Status = "locked";
          };

          "browser.aboutConfig.showWarning" = {
            Value = false;
            Status = "locked";
          };

          "browser.aboutHomeSnippets.updateUrl" = {
            Value = "";
            Status = "locked";
          };

          "browser.startup.homepage_override.mstone" = {
            Value = "ignore";
            Status = "locked";
          };

          "browser.startup.homepage_override.buildID" = {
            Value = "";
            Status = "locked";
          };

          "browser.ping-centre.telemetry" = {
            Value = false;
            Status = "locked";
          };

          "browser.newtabpage.activity-stream.feeds.telemetry" = {
            Value = false;
            Status = "locked";
          };

          "browser.safebrowsing.downloads.remote.enabled" = {
            Value = false;
            Status = "locked";
          };

          "browser.newtabpage.activity-stream.default.sites" = {
            Value = "";
            Status = "locked";
          };

          "browser.newtabpage.activity-stream.telemetry" = {
            Value = false;
            Status = "locked";
          };

          "browser.tabs.firefox-view" = {
            Value = false;
            Status = "locked";
          };

          "browser.tabs.crashReporting.sendReport" = {
            Value = false;
            Status = "locked";
          };

          "browser.places.speculativeConnect.enabled" = {
            Value = false;
            Status = "locked";
          };

          "browser.link.open_newwindow.restriction" = {
            Value = 0;
            Status = "locked";
          };

          "browser.discovery.enabled" = {
            Value = false;
            Status = "locked";
          };

          "browser.uitour.enabled" = {
            Value = false;
            Status = "locked";
          };

          "browser.cache.disk.enable" = {
            Value = false;
            Status = "locked";
          };

          "browser.privatebrowsing.forceMediaMemoryCache" = {
            Value = true;
            Status = "locked";
          };

          "browser.sessionstore.privacy_level" = {
            Value = 2;
            Status = "locked";
          };

          "browser.shell.shortcutFavicons" = {
            Value = false;
            Status = "locked";
          };

          "browser.xul.error_pages.expert_bad_cert" = {
            Value = true;
            Status = "locked";
          };

          "browser.helperApps.deleteTempFileOnExit" = {
            Value = true;
            Status = "locked";
          };

          "browser.formfill.enable" = {
            Value = false;
            Status = "locked";
          };

          "browser.tabs.searchclipboardfor.middleclick" = {
            Value = false;
            Status = "locked";
          };

          "browser.download.alwaysOpenPanel" = {
            Value = false;
            Status = "locked";
          };

          "browser.download.manager.addToRecentDocs" = {
            Value = false;
            Status = "locked";
          };

          "browser.download.always_ask_before_handling_new_types" = {
            Value = true;
            Status = "locked";
          };

          "browser.urlbar.showSearchTerms.enabled" = {
            Value = false;
            Status = "locked";
          };

          "geo.provider.use_geoclue" = {
            Value = false;
            Status = "locked";
          };

          "pdfjs.enableScripting" = {
            Value = false;
            Status = "locked";
          };

          "dom.disable_window_move_resize" = {
            Value = true;
            Status = "locked";
          };

          "dom.event.contextmenu.enabled" = {
            Value = false;
            Status = "locked";
          };

          "dom.event.clipboardevents.enabled" = {
            Value = false;
            Status = "locked";
          };

          "dom.security.https_only_mode" = {
            Value = true;
            Status = "locked";
          };

          "dom.security.https_only_mode_send_http_background_request" = {
            Value = false;
            Status = "locked";
          };

					"dom.private-attribution.submission.enabled" = {
            Value = false;
            Status = "locked";
					};

          "extensions.getAddons.showPane" = {
            Value = false;
            Status = "locked";
          };

          "extensions.webextensions.restrictedDomains" = {
            Value = "";
            Status = "locked";
          };

          "extensions.postDownloadThirdPartyPrompt" = {
            Value = false;
            Status = "locked";
          };

          "extensions.htmlaboutaddons.recommendations.enabled" = {
            Value = false;
            Status = "locked";
          };

          "extensions.recommendations.themeRecommendationUrl" = {
            Value = "";
            Status = "locked";
          };

          "network.IDN_show_punycode" = {
            Value = true;
            Status = "locked";
          };

          "network.auth.subresource-http-auth-allow" = {
            Value = 1;
            Status = "locked";
          };

          "network.http.referer.XOriginPolicy" = {
            Value = 2;
          };

          "network.http.referer.XOriginTrimmingPolicy" = {
            Value = 2;
            Status = "locked";
          };

          "network.proxy.socks_remote_dns" = {
            Value = true;
            Status = "locked";
          };

          "network.file.disable_unc_paths" = {
            Value = true;
            Status = "locked";
          };

          "network.dns.skipTRR-when-parental-control-enabled" = {
            Value = false;
            Status = "locked";
          };

          "media.peerconnection.enabled" = {
            Value = false;
            Status = "locked";
          };

          "media.peerconnection.ice.proxy_only_if_behind_proxy" = {
            Value = true;
            Status = "locked";
          };

          "media.peerconnection.ice.default_address_only" = {
            Value = true;
            Status = "locked";
          };
        };
      };

      profiles.default = {
        id = 0;
        name = "Default";
        isDefault = true;
        search = {
          default = "Searx";
          engines = {
            "Nix Packages" = {
              urls = [{
                template = "https://search.nixos.org/packages";
                params = [
                  { name = "type"; value = "packages"; }
                  { name = "query"; value = "{searchTerms}"; }
                ];
              }];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@np" ];
            };

            "Brave" = {
              urls = [{
                template = "https://search.brave.com/search?q={searchTerms}";
              }];
              definedAliases = [ "@br" ];
            };

            "Searx" = {
              urls = [{
                template = "https://searx.hu/search?q={searchTerms}";
              }];
              definedAliases = [ "@sx" ];
            };
          };
        };


        settings = {
          "privacy.donottrackheader.enabled" = true;
          "privacy.firstparty.isolate" = true;
          "startup.homepage_welcome_url" = "";
          "startup.homepage_welcome_url.additional" = "";
          "startup.homepage_override_url" = "";
          "app.shield.optoutstudies.enabled" = false;
          "webgl.disabled" = true;
          "intl.accept_languages" = "en-US, en";

          # RFP
          "privacy.resistFingerprinting" = true;
          "privacy.window.maxInnerWidth" = 1600;
          "privacy.window.maxInnerHeight" = 900;
          "privacy.resistFingerprinting.letterboxing" = true;
          "privacy.resistFingerprinting.block_mozAddonManager" = true;
          "javascript.use_us_english_locale" = true;

          # telemetry
          "toolkit.telemetry.unified" = false;
          "toolkit.telemetry.server" = "data:,";
          "toolkit.telemetry.newProfilePing.enabled" = false;
          "toolkit.telemetry.shutdownPingSender.enabled" = false;
          "toolkit.telemetry.updatePing.enabled" = false;
          "toolkit.telemetry.bhrPing.enabled" = false;
          "toolkit.telemetry.firstShutdownPing.enabled" = false;
          "toolkit.telemetry.coverage.opt-out" = true;
          "toolkit.coverage.opt-out" = true;
          "toolkit.coverage.endpoint.base" = "";

          "app.normandy.enabled" = false;
          "app.normandy.api_url" = "";

          "breakpad.reportURL" = "";
          "permissions.manager.defaultsUrl" = "";
          "webchannel.allowObject.urlWhitelist" = "";

          "security.ssl.require_safe_negotiation" = true;
          "security.tls.enable_0rtt_data" = false;
          "security.OCSP.require" = true;
          "security.cert_pinning.enforcement_level" = 2;
          "security.remote_settings.crlite_filters.enabled" = true;
          "security.pki.crlite_mode" = 2;
          "security.ssl.treat_unsafe_negotiation_as_broken" = true;

          "signon.autofillForms" = false;
          "signon.formlessCapture.enabled" = false;

          "devtools.debugger.remote-enabled" = false;

          #userChrome settings 
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "layers.acceleration.force-enabled" = true;
          "gfx.webrender.all" = true;
          "gfx.webrender.enabled" = true;
          "layout.css.backdrop-filter.enabled" = true;
          "layout.css.overflow-overlay.enabled" = true;
          "svg.context-properties.content.enabled" = true;
        };
        userChrome = ''
          #urlbar[open="true"] #urlbar-background {
          	outline: none !important;
          }

          #urlbar[focused=true] {
          	border: 2px solid !important;
          	border-radius: 6px;
          }

          #urlbar #urlbar-background {
          	outline: none !important;
          	border: none !important;
          	background-color: #0b0a10 !important;
          }


          #urlbar-container {
          	position: relative;
          	top: 18px;
          }

          :root[inFullscreen] #nav-bar{
          	border-inline: none !important;
          }

          .browserStack>browser{
          	border-radius: 10px !important;
          	outline-offset: 1px !important;
          }


          #nav-bar{
          	margin-left: 300px !important;
          	margin-right: 300px !important;
          	border-radius: 8px !important;
          	padding-top: 0px !important;
          	background-color: #100e1b !important;
          }

          #TabsToolbar{ visibility: collapse !important }


          #toolbar-menubar:not([inactive]){ z-index: 2 }
          #toolbar-menubar[inactive] > #menubar-items {
          	opacity: 0;
          	pointer-events: none;
          }


          #urlbar[breakout][breakout-extend] {
          	top: -16px !important;
          	left: 0 !important;
          	width: 100% !important;
          }
          #urlbar[breakout][breakout-extend] > #urlbar-background {
          	animation-name: none !important;
          	box-shadow: none !important;
          }
          #urlbar[breakout][breakout-extend] > #urlbar-input-container {
          	height: 28px !important;
          	width: 100% !important;
          	padding-block: 0 !important;
          	padding-inline: 0 !important;
          	transition: none !important;
          }
          .urlbarView {
          	margin-inline: 0 !important;
          	width: 100% !important;
          }
          .urlbarView-row {
          	padding-block: 0 !important;
          }
          .urlbarView-type-icon {
          	min-width: 16px !important;
          	height: 16px !important;
          	margin-bottom: 0 !important;
          	margin-inline-start: 0 !important;
          }
          .urlbarView-favicon {
          	margin-inline-start: 25px !important;
          }


          /** Changes in TST **/

          :root {
          	--sidebar-width: 250px;
          	/* initial width of the sidebar. 
          	advised not to change since tst css relies on this value*/
          	--sidebar-collapsed-width: 50px;
          	--dividers: 2px;
          }


          :root {
          	--ease-out: cubic-bezier(0.22, 1, 0.36, 1);
          	--transition-time: 0.4s !important;
          }


          /* Container identity colors */
          .identity-color-pink {
          	--identity-tab-color: #ED64A6 !important;
          	--identity-icon-color: #ED64A6 !important;
          }

          .identity-color-blue {
          	--identity-tab-color: #4299E1 !important;
          	--identity-icon-color: #4299E1 !important;
          }

          .identity-color-green {
          	--identity-tab-color: #48BB78 !important;
          	--identity-icon-color: #48BB78 !important;
          }

          .identity-color-orange {
          	--identity-tab-color: #ED8936 !important;
          	--identity-icon-color: #ED8936 !important;
          }

          #sidebar-box {
          	z-index: 1000 !important;
          	position: relative !important;
          	min-width: var(--sidebar-collapsed-width) !important;
          	max-width: var(--sidebar-collapsed-width) !important;
          	padding-left: 6px !important;
          	background-color: #2b2a33 !important;
          }

          #sidebar-header,
          #sidebar-splitter {
          	display: none !important;
          }

          /* inner width = expanded width & move inner to only show initial-width long section */
          #sidebar-box #sidebar {
          	position: absolute !important;
          	min-width: var(--sidebar-width) !important;
          	max-width: var(--sidebar-width) !important;
          	width: var(--sidebar-width) !important;
          	transform: translateX(calc(var(--sidebar-collapsed-width) - var(--sidebar-width)));
          	transition: all var(--transition-time) var(--ease-out);
          }

          /* move inner to show entire sidebar */
          #sidebar-box #sidebar:hover {
          	transform: translateX(0) !important;
          	/* box-shadow: 2px 0 33px -3px; */
          }

          #sidebar-box[sidebarcommand="viewBookmarksSidebar"] #sidebar {
          	transform: translateX(0) !important;
          	/* box-shadow: 2px 0 33px -3px; */
          }
          /* hide sidebar header for tree style tabs sidebar */
          #sidebar-box[sidebarcommand="treestyletab_piro_sakura_ne_jp-sidebar-action"] #sidebar-header {
          	display: none;
          }

          #sidebar {
          	/* border-right: solid var(--dividers) #11111b !important; */
          	border-radius: 10px !important;
          	margin-top: 6px !important;
          	margin-bottom: 6px !important;
          	border-top-width: 12px !important;
          	/* background-color: #111019 !important; */
          }


          toolbar {
          	border: none !important;
          }

          /* Hide splitter, when using Tree Style Tab. */
          #sidebar-splitter {
          	display: none !important;
          }

          /* hide tabs */
          .tabbrowser-tab {
          	display: none;
          }

          #tabs-newtab-button {
          	display: none;
          }

          .titlebar-spacer {
          	display: none !important;
          }

          /*for hiding bookmarks bar*/
          #PersonalToolbar{
          	--uc-bm-height: 20px; /* Might need to adjust if the toolbar has other buttons */
          	--uc-bm-padding: 4px; /* Vertical padding to be applied to bookmarks */
          	--uc-autohide-toolbar-delay: 250ms; /* The toolbar is hidden after 0.6s */

          	/* 0deg = "show" ; 90deg = "hide" ;  Set the following to control when bookmarks are shown */
          	--uc-autohide-toolbar-focus-rotation: 0deg; /* urlbar is focused */
          	--uc-autohide-toolbar-hover-rotation: 0deg; /* cursor is over the toolbar area */
          }

          :root[uidensity="compact"] #PersonalToolbar{ --uc-bm-padding: 1px }
          :root[uidensity="touch"] #PersonalToolbar{ --uc-bm-padding: 7px }

          #PersonalToolbar:not([customizing]){
          	position: relative;
          	margin-bottom: calc(0px - var(--uc-bm-height) - 2 * var(--uc-bm-padding));
          	transform: rotateX(90deg);
          	transform-origin: top;
          	transition: transform 135ms linear var(--uc-autohide-toolbar-delay) !important;
          	z-index: 1;
          }

          #PlacesToolbarItems > .bookmark-item{ padding-block: var(--uc-bm-padding) !important; }

          #nav-bar:focus-within + #PersonalToolbar{
          	margin-top: 61px;
          	margin-bottom: -61px;
          	transform: rotateX(var(--uc-autohide-toolbar-focus-rotation,0));
          }

          #navigator-toolbox:hover > #PersonalToolbar{
          	margin-top: 61px;
          	margin-bottom: -61px;
          	transform: rotateX(var(--uc-autohide-toolbar-hover-rotation,0));
          }

          #navigator-toolbox:hover > #nav-bar:focus-within + #PersonalToolbar {  
          	margin-top: 61px;
          	margin-bottom: -61px;
          }

          #nav-bar:not([customizing="true"]):not([inFullscreen]) {
          	min-height: 0px !important;
          	max-height: 0px !important;
          	margin-top: 0px !important;
          	margin-bottom: -1px !important;
          	z-index: -5 !important;
          }

          #navigator-toolbox:hover:not([inFullscreen]) :-moz-any(#nav-bar), 
          #navigator-toolbox:focus-within :-moz-any(#nav-bar) {
          	min-height: 38px !important;
          	max-height: 38px !important;
          	margin-top: 0px !important;
          	margin-bottom: -39px !important;
          	z-index: 5 !important;
          }
        '';
      };
    };
  };
}
