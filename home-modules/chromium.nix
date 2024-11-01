{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.chromium = {
    enable = true;
    package = pkgs.chromium; # Use Chromium

    # Add Chromium flags if necessary
    commandLineArgs = [
      "--ignore-gpu-blacklist"
      "--enable-gpu-rasterization"
      "--default-search-provider-search-url=https://duckduckgo.com/?q={searchTerms}"
    ];

    # Install extensions
    extensions = [
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock origin
      { id = "mnjggcdmjocbbbhaepdhchncahnbgone"; } # sponsorblock
    ];
  };
}
