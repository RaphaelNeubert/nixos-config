
{ config, lib, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [ 
    chromium
  ];
  programs.chromium = {
    enable = true;

    defaultSearchProviderEnabled = true;
    defaultSearchProviderSearchURL = "https://duckduckgo.com/?q={searchTerms}";
    defaultSearchProviderSuggestURL = "https://duckduckgo.com/ac/?q={searchTerms}&type=list";

    extraOpts = {
      "PromptForDownloadLocation" = true;
    };

    # Install extensions
    extensions = [
      "cjpalhdlnbpafiamejdnhcphjbkeiagm"  # ublock origin
      "mnjggcdmjocbbbhaepdhchncahnbgone"  # sponsorblock
    ];
  };
}

