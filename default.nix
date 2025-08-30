{
  lib,
  src ? ./.,
  buildPythonPackage,
  pytest,
  pybind11,
}: let
  version_file = builtins.readFile ./libparse/__version__.py;
  version_list = builtins.match ''.+''\n__version__ = "([^"]+)"''\n.+''$'' version_file;
  version = builtins.head version_list;
in
  buildPythonPackage {
    pname = "libparse";
    inherit version;

    inherit src;

    buildInputs = [
      pybind11
    ];
    
    pythonImportsCheck = [ "libparse" ];

    meta = with lib; {
      description = "Python wrapper around Yosys's libparse";
      license = with licenses; [asl20];
      homepage = "https://github.com/librelane/libparse-python";
      platforms = platforms.linux ++ platforms.darwin;
    };
  }
