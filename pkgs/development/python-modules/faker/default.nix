{ lib
, buildPythonPackage
, fetchPypi
, dateutil
, text-unidecode
, freezegun
, pytestCheckHook
, ukpostcodeparser
, pillow
, validators
}:

buildPythonPackage rec {
  pname = "Faker";
  version = "8.8.2";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-IlNMOqbS7584QDojTcm3G1y4ePt2XHKZS+Xce06vCGU=";
  };

  propagatedBuildInputs = [
    dateutil
    text-unidecode
  ];

  checkInputs = [
    freezegun
    pillow
    pytestCheckHook
    ukpostcodeparser
    validators
  ];

  # avoid tests which import random2, an abandoned library
  pytestFlagsArray = [
    "--ignore=tests/providers/test_ssn.py"
  ];
  pythonImportsCheck = [ "faker" ];

  meta = with lib; {
    description = "Python library for generating fake user data";
    homepage = "http://faker.rtfd.org";
    license = licenses.mit;
    maintainers = with maintainers; [ lovek323 ];
  };
}
