{
  home.shellAliases = {
    cp = "cp -iv";
    mv = "mv -iv";
    rm = "rm -vI";
    bc = "bc -ql";
    ls = "ls -hN --color=auto --group-directories-first";
    grep = "grep --color=auto";
    diff = "diff --color=auto";

    cpwd = "pwd | wl-copy";

    nnenv = "nix-shell ~/tu/shell.nix";
  };
}
