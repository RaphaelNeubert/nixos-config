{
  pkgs,
  ...
}:

{

  environment.systemPackages = with pkgs; [
    #chromium
    (chromium.override {
      commandLineArgs = [
        # not sure if these even get applied, chrome://flags seems to say no
        "--enable-features=VaapiVideoDecodeLinuxGL"
        "--ignore-gpu-blocklist"
        "--enable-zero-copy"
      ];
      enableWideVine = true;

    })
  ];
  programs.chromium = {
    enable = true;

    defaultSearchProviderEnabled = true;
    defaultSearchProviderSearchURL = "https://duckduckgo.com/?q={searchTerms}";
    defaultSearchProviderSuggestURL = "https://duckduckgo.com/ac/?q={searchTerms}&type=list";

    extraOpts = {
      "PromptForDownloadLocation" = true;
      "PasswordManagerEnabled" = false;
      # 1 = Allow sites to show desktop notifications
      # 2 = Do not allow any site to show desktop notifications
      # 3 = Ask every time a site wants to show desktop notifications
      "DefaultNotificationSetting" = 2;
    };

    # Install extensions
    extensions = [
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
      "mnjggcdmjocbbbhaepdhchncahnbgone" # sponsorblock
      "nngceckbapebfimnlniiiahkandclblb" # bitwarden
      #"akannjhnhbfgceibnngofjbnncmelcjg" # darkmode everywhere
    ];
  };
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
