{
  lib,
  appimageTools,
  fetchurl,
  writeText,
}:

let
  pname = "qlcplus-appimage";
  version = "5.3.0";

  src = fetchurl {
    url = "https://www.qlcplus.org/downloads/${version}/QLC%2B_${version}_x86_64.AppImage";
    hash = "sha256-imUzZKG28K0JJbhhYQKaLit9UglwH0Z6D/ewmSxe84A=";
  };

  contents = appimageTools.extract {
    inherit pname version src;
  };

  # QLC+ requests normal weight but bundles Solid icons. The system's Regular
  # Font Awesome face otherwise takes precedence and leaves many icons blank.
  fontconfig = writeText "qlcplus-fonts.conf" ''
    <?xml version="1.0"?>
    <!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
    <fontconfig>
      <include>/etc/fonts/fonts.conf</include>
      <selectfont>
        <rejectfont>
          <glob>*/Font Awesome 7 Free-Regular-400.otf</glob>
        </rejectfont>
      </selectfont>
    </fontconfig>
  '';
in
appimageTools.wrapType2 {
  inherit pname version src;

  extraPkgs = pkgs: with pkgs; [
    fftw
    libftdi1
    libva
    libxcb-cursor
    zstd
  ];

  profile = ''
    export FONTCONFIG_FILE=${fontconfig}
    # Use the platform and style shipped in the AppImage, not host Qt plugins.
    export QT_QPA_PLATFORM=xcb
    export QT_STYLE_OVERRIDE=Fusion
  '';

  extraInstallCommands = ''
    install -Dm644 ${contents}/qlcplus.desktop $out/share/applications/${pname}.desktop
    substituteInPlace $out/share/applications/${pname}.desktop \
      --replace-fail 'Exec=qlcplus5' 'Exec=${pname} %f' \
      --replace-fail 'Name=Q Light Controller Plus - QLC+' 'Name=QLC+ (AppImage)' \
      --replace-fail 'Icon=qlcplus' 'Icon=${pname}'
    install -Dm644 ${contents}/qlcplus.svg $out/share/icons/hicolor/scalable/apps/${pname}.svg
  '';

  meta = {
    description = "QLC+ upstream AppImage with corrected icon font selection";
    homepage = "https://www.qlcplus.org/";
    license = lib.licenses.asl20;
    platforms = [ "x86_64-linux" ];
    mainProgram = pname;
  };
}
