{ stdenvNoCC, gnused, lib, ... }:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "vsc-go-away-llms";
  version = "0.0.1";

  src = ./settings.json;

  nativeBuildInputs = [
    gnused
  ];

  unpackPhase = ''
    runHook preUnpack

    mkdir -p "$out"
    cp "$src" "$out/settings.json"

    runHook postUnpack
  '';

  postPatch = ''
    sed -i '/^\s*\/\//d' "$out/settings.json"
  '';

  meta = with lib; {
    homepage = "https://github.com/rpavlik/vsc-go-away-llms";
    description = "Go away copilot and other slop machines (in vscode)";
    license = licenses.mit;
    platforms = platforms.all;
  };
})
