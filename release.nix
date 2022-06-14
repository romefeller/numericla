{ mkDerivation, base, bytestring, cassava, gnuplot, hmatrix
, hmatrix-csv, lib
}:
mkDerivation {
  pname = "numericla";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [
    base bytestring cassava gnuplot hmatrix hmatrix-csv
  ];
  license = "unknown";
  hydraPlatforms = lib.platforms.none;
}
