{
  home.shellAliases = {
    cp = "cp -iv";
    mv = "mv -iv";
    rm = "rm -vI";
    bc = "bc -ql";
    #ls = "ls -hN --color=auto --group-directories-first";
    ls = "eza";
    cat = "bat";
    grep = "grep --color=auto";
    diff = "diff --color=auto";

    cpwd = "pwd | wl-copy";

    nnenv = "nix-shell ~/tu/shell.nix";

    emptyflake = "cp -i /etc/nixos/flake-templates/empty/flake.nix .";
    uvenv = "nix develop /etc/nixos/flake-templates/uv-flake";
  };
}
