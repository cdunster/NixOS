final: prev:

let
  lib = prev.lib;

  nixWrapper = with builtins; wrapper: postFix: package:
    let
      getBinFiles = pkg:
        lib.pipe "${lib.getBin pkg}/bin" [
          readDir
          attrNames
          (filter (n: match "^\\..*" n == null))
        ];

      wrapperBin = lib.pipe wrapper [
        getBinFiles
        (filter (n: n == (lib.getName wrapper)))
        head
        (x: "${wrapper}/bin/${x}")
      ];

      binFiles = getBinFiles package;
      wrapBin = name:
        final.writeShellScriptBin name ''
          exec ${wrapperBin} ${package}/bin/${name} "$@"
        '';
    in
    final.symlinkJoin {
      name = "${package.name}${postFix}";
      paths = (map wrapBin binFiles) ++ [ package ];
    };

in
{
  wrapWithNixGLIntel = nixWrapper prev.nixgl.nixGLIntel "-nixgl";
  wrapWithNixVulkanIntel = nixWrapper prev.nixgl.nixVulkanIntel "-nixvulkan";
}
