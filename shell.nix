with import <nixpkgs> {};

let
  python = python310;
in stdenv.mkDerivation {
  name = "impurePythonEnv";
  buildInputs = [
    # these packages are required for virtualenv and pip to work:
    #
    python
    python.pkgs.virtualenv
    python.pkgs.pip
    poetry
    # the following packages are related to the dependencies of your python
    # project.
    # In this particular example the python modules listed in the
    # requirements.txt require the following packages to be installed locally
    # in order to compile any binary extensions they may require.
    #
    stdenv
    libffi
    libffi.dev
    openssl
  ];
  src = null;
  shellHook = ''
    # set SOURCE_DATE_EPOCH so that we can use python wheels
    SOURCE_DATE_EPOCH=$(date +%s)
    #virtualenv $PWD/venv
    #export PATH=$PWD/venv/bin:$PATH
    #export PYTHONPATH=$PWD/venv/lib/python3.7/site-packages/:$PYTHONPATH
    #python3 -m pip install poetry
  '';
}
