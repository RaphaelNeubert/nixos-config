{
  description = "Minimal dev shell";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      forAllSystems =
        f:
        nixpkgs.lib.genAttrs systems (
          system:
          f (
            import nixpkgs {
              inherit system;
              config.allowUnfree = true;
            }
          )
        );
    in
    {
      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShell {
          packages = with pkgs; [
            zsh
            gcc.cc.lib
            zlib
            mesa
            libGL
            libglvnd
            egl-wayland
            SDL2
            libdecor
            libxkbcommon
            wayland
            wayland-protocols
            libx11
            libxcursor
            libxext
            libxfixes
            libxi
            libxinerama
            libxrandr
            libxrender
            libxscrnsaver
          ];
          shellHook = ''
            export LD_LIBRARY_PATH="${
              pkgs.lib.makeLibraryPath [
                pkgs.zlib
                pkgs.gcc.cc.lib
                pkgs.mesa
                pkgs.libGL
                pkgs.libglvnd
                pkgs.egl-wayland
                pkgs.SDL2
                pkgs.libdecor
                pkgs.libxkbcommon
                pkgs.wayland
                pkgs.wayland-protocols
                pkgs.libx11
                pkgs.libxcursor
                pkgs.libxext
                pkgs.libxfixes
                pkgs.libxi
                pkgs.libxinerama
                pkgs.libxrandr
                pkgs.libxrender
                pkgs.libxscrnsaver
              ]
            }:$LD_LIBRARY_PATH"
                        exec ${pkgs.zsh}/bin/zsh -i
          '';
        };
      });
    };
}
