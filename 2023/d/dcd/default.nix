{ 
  stdenv,
  fetchurl,
  autoPatchelfHook,
  libgcc,
}:
stdenv.mkDerivation {
  name = "dcd-server";

  src = fetchurl {
    url = "https://github.com/dlang-community/DCD/releases/download/v0.15.2/dcd-v0.15.2-linux-x86_64.tar.gz";
    sha256 = "sha256-0VkL0FgIS+GJo5ELP/joCfgxfA1SVgb1g0/RxVeO6PU=";
  };

  nativeBuildInputs = [ autoPatchelfHook ];
  buildInputs = [ libgcc ];

  sourceRoot = ".";

  installPhase = ''
    runHook preInstall
    install -m755 -D dcd-server $out/bin/dcd-server
    install -m755 -D dcd-client $out/bin/dcd-client
    runHook postInstall
  '';
}
