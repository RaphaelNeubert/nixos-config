{
  pkgs,
  ...
}:

{
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc
      zlib
      glib
      openssl
      xz
    ];
  };
}
