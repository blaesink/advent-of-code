{ 
  stdenv,
  fetchurl,
  autoPatchelfHook,
  libgcc,
}:
stdenv.mkDerivation {
  name = "serve-d";

  src = fetchurl {
    url = "https://github.com/Pure-D/serve-d/releases/download/v0.7.5/serve-d_0.7.5-linux-x86_64.tar.xz";
    sha256 = "sha256-6/eUmxdxMUgvTICuN5Ezk0+7OZH0xJg3/UJ7NlJcAqU=";
  };

  nativeBuildInputs = [ autoPatchelfHook ];
  buildInputs = [ libgcc ];

  sourceRoot = ".";

  installPhase = ''
    runHook preInstall
    install -m755 -D serve-d $out/bin/serve-d
    runHook postInstall
  '';
}
