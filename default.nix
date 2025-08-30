{
  lib,
  src ? ./.,
  buildPythonPackage,
  pytest,
  pybind11,
  pytestCheckHook,
  perl,
}: let
  version_file = builtins.readFile ./libparse/__version__.py;
  version_list = builtins.match ''.+''\n__version__ = "([^"]+)"''\n.+''$'' version_file;
  version = builtins.head version_list;
in
  buildPythonPackage {
    pname = "libparse";
    inherit version;

    inherit src;
    
    postPatch = ''
      perl -i -pe 'print "__attribute__((weak)) " if /LibertyParser::error/' yosys/passes/techmap/libparse.cc
    '';

    nativeBuildInputs = [
      perl
    ];

    buildInputs = [
      pybind11
    ];
    
    pythonImportsCheck = [ "libparse" ];
    
    doCheck = true;
    
    nativeCheckInputs = [
      pytestCheckHook
    ];

    meta = {
      description = "Python wrapper around Yosys's libparse";
      license = with lib.licenses; [asl20];
      homepage = "https://github.com/librelane/libparse-python";
      platforms = with lib.platforms; linux ++ darwin;
    };
  }
