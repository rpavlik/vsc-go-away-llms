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

  # 1. Remove any comments: lines starting with optional whitespace and //
  # 2. Remove the final trailing comma in an object { "key": "val", }
  postPatch = ''
    sed -i '/^\s*\/\//d' "$out/settings.json"
    sed -z -i 's/,\(\s*}\s*\)$/\1/' "$out/settings.json"
  '';

  meta = with lib; {
    homepage = "https://github.com/rpavlik/vsc-go-away-llms";
    description = "Go away copilot and other slop machines (in vscode)";
    license = licenses.mit;
    platforms = platforms.all;
  };
})
