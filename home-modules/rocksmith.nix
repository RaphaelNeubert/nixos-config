{ config, pkgs, ... }:

let
  steamRoot = "${config.home.homeDirectory}/.steam/steam";
  gameDir = "${steamRoot}/steamapps/common/Rocksmith2014";
  prefixDir = "${steamRoot}/steamapps/compatdata/221680/pfx";

  rsAsioIni = pkgs.writeText "RS_ASIO.ini" ''
    [Config]
    EnableWasapiOutputs=0
    EnableWasapiInputs=0
    EnableAsio=1

    [Asio]
    BufferSizeMode=driver

    [Asio.Output]
    Driver=wineasio-rsasio
    BaseChannel=0
    EnableSoftwareEndpointVolumeControl=1
    EnableSoftwareMasterVolumeControl=1
    SoftwareMasterVolumePercent=100

    [Asio.Input.0]
    Driver=wineasio-rsasio
    Channel=0
    EnableSoftwareEndpointVolumeControl=1
    EnableSoftwareMasterVolumeControl=1
    SoftwareMasterVolumePercent=100

    [Asio.Input.1]
    Driver=wineasio-rsasio
    Channel=1
    EnableSoftwareEndpointVolumeControl=1
    EnableSoftwareMasterVolumeControl=1
    SoftwareMasterVolumePercent=100

    [Asio.Input.Mic]
    Driver=wineasio-rsasio
    Channel=2
    EnableSoftwareEndpointVolumeControl=1
    EnableSoftwareMasterVolumeControl=1
    SoftwareMasterVolumePercent=100
  '';

  rocksmithIni = pkgs.writeText "Rocksmith.ini" ''
    [Audio]
    EnableMicrophone=1
    ExclusiveMode=1
    LatencyBuffer=2
    ForceDefaultPlaybackDevice=
    ForceWDM=0
    ForceDirectXSink=0
    DumpAudioLog=0
    MaxOutputBufferSize=0
    RealToneCableOnly=0
    MonoToStereoChannel=0
    Win32UltraLowLatencyMode=1
    [Renderer.Win32]
    ShowGamepadUI=0
    ScreenWidth=0
    ScreenHeight=0
    Fullscreen=2
    VisualQuality=3
    RenderingWidth=0
    RenderingHeight=0
    EnablePostEffects=1
    EnableShadows=1
    EnableHighResScope=1
    EnableDepthOfField=0
    EnablePerPixelLighting=1
    MsaaSamples=4
    DisableBrowser=0
    [Net]
    UseProxy=1
    [Global]
    Version=1
  '';

  launchScript = pkgs.writeShellApplication {
    name = "rocksmith-launch";
    runtimeInputs = with pkgs; [
      coreutils
      findutils
    ];
    text = ''
      STEAM_ROOT="${steamRoot}"
      GAME_DIR="${gameDir}"
      PREFIX_DIR="${prefixDir}"
      WINEASIO=${pkgs.wineasio-32}
      PW_JACK32=${pkgs.pkgsi686Linux.pipewire.jack}
      PW_JACK64=${pkgs.pipewire.jack}

      LOG_DIR="$HOME/.local/state"
      mkdir -p "$LOG_DIR"
      exec 3>>"$LOG_DIR/rocksmith-launch.log"
      printf '\n[%s] Preparing Rocksmith\n' "$(date --iso-8601=seconds)" >&3

      if [ ! -d "$GAME_DIR" ]; then
        printf 'Game directory not found: %s\n' "$GAME_DIR" >&3
        exit 1
      fi

      cp -f ${pkgs.rs-asio}/lib/RS_ASIO.dll "$GAME_DIR/RS_ASIO.dll"
      cp -f ${pkgs.rs-asio}/lib/avrt.dll "$GAME_DIR/avrt.dll"
      cp -f ${rsAsioIni} "$GAME_DIR/RS_ASIO.ini"
      cp -f ${rocksmithIni} "$GAME_DIR/Rocksmith.ini"
      cp -f "$WINEASIO/lib/wine/i386-windows/wineasio32.dll" "$GAME_DIR/wineasio32.dll"

      if [ -d "$PREFIX_DIR/drive_c/windows/syswow64" ]; then
        cp -f "$WINEASIO/lib/wine/i386-windows/wineasio32.dll" \
          "$PREFIX_DIR/drive_c/windows/syswow64/wineasio32.dll"
      fi

      # Install both halves into every available Proton tool instead of relying
      # on a fixed list of Proton release names.
      for proton_dir in \
        "$STEAM_ROOT"/steamapps/common/Proton* \
        "$STEAM_ROOT"/compatibilitytools.d/* \
        "$HOME"/.local/share/Steam/compatibilitytools.d/*; do
        unix_dir="$proton_dir/files/lib/wine/i386-unix"
        windows_dir="$proton_dir/files/lib/wine/i386-windows"
        if [ -d "$unix_dir" ]; then
          cp -f "$WINEASIO/lib/wine/i386-unix/wineasio32.dll.so" "$unix_dir/wineasio32.dll.so"
          # The PE stub's internal module name is wineasio.dll, which Proton 11
          # uses when resolving the Unix half of the module.
          cp -f "$WINEASIO/lib/wine/i386-unix/wineasio32.dll.so" "$unix_dir/wineasio.dll.so"
          printf 'Installed WineASIO into %s\n' "$proton_dir" >&3
        fi
        if [ -d "$windows_dir" ]; then
          cp -f "$WINEASIO/lib/wine/i386-windows/wineasio32.dll" "$windows_dir/wineasio32.dll"
        fi

        # WineASIO uses dlopen(), and Proton exposes this directory to 32-bit
        # Wine processes. Runtime 4's own library directory is not searched.
        jack_dir="$proton_dir/files/lib/i386-linux-gnu"
        if [ -d "$jack_dir" ]; then
          cp -Lf "$PW_JACK32/lib/libjack.so.0" "$jack_dir/libjack.so.0"
          cp -Lf "$PW_JACK32/lib/libjackserver.so.0" "$jack_dir/libjackserver.so.0"
          cp -Lf "$PW_JACK32/lib/libjacknet.so.0" "$jack_dir/libjacknet.so.0"
          printf 'Installed managed JACK into %s\n' "$jack_dir" >&3
        fi
      done

      # Proton can use sniper, soldier, or Runtime 4. Patch each active runtime
      # container with PipeWire's JACK implementation.
      for runtime_dir in "$STEAM_ROOT"/steamapps/common/SteamLinuxRuntime_*; do
        for lib_dir in "$runtime_dir"/var/tmp-*/usr/lib/i386-linux-gnu; do
          if [ -d "$lib_dir" ]; then
            cp -Lf "$PW_JACK32/lib/libjack.so.0" "$lib_dir/libjack.so.0"
            cp -Lf "$PW_JACK32/lib/libjackserver.so.0" "$lib_dir/libjackserver.so.0"
            cp -Lf "$PW_JACK32/lib/libjacknet.so.0" "$lib_dir/libjacknet.so.0"
            printf 'Patched 32-bit JACK in %s\n' "$lib_dir" >&3
          fi
        done
        for lib_dir in "$runtime_dir"/var/tmp-*/usr/lib/x86_64-linux-gnu; do
          if [ -d "$lib_dir" ]; then
            cp -Lf "$PW_JACK64/lib/libjack.so.0" "$lib_dir/libjack.so.0"
            cp -Lf "$PW_JACK64/lib/libjackserver.so.0" "$lib_dir/libjackserver.so.0"
            cp -Lf "$PW_JACK64/lib/libjacknet.so.0" "$lib_dir/libjacknet.so.0"
            printf 'Patched 64-bit JACK in %s\n' "$lib_dir" >&3
          fi
        done
      done

      export WINEDLLOVERRIDES="wineasio32=n,b;wineasio=n,b''${WINEDLLOVERRIDES:+;$WINEDLLOVERRIDES}"
      export WINEDLLPATH="$WINEASIO/lib/wine/i386-unix''${WINEDLLPATH:+:$WINEDLLPATH}"
      export PIPEWIRE_LATENCY="256/48000"
      export WINEASIO_NUMBER_INPUTS=2
      export WINEASIO_NUMBER_OUTPUTS=2
      export WINEASIO_FIXED_BUFFERSIZE=1
      export WINEASIO_PREFERRED_BUFFERSIZE=256

      printf 'Launching: %s\n' "$*" >&3
      exec "$@"
    '';
  };
in
{
  home.packages = [ launchScript ];
}
