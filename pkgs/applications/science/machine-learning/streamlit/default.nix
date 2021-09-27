{ lib, buildPythonApplication, fetchPypi, python3Packages }:

buildPythonApplication rec {
  pname = "streamlit";
  version = "0.89.0";
  format = "wheel"; # the only distribution available

  src = fetchPypi {
    inherit pname version format;
    sha256 = "1ay2xr6vw57haag8gq87akmbh80iblcq535i2wialbzgs4adgqrh";
  };

  propagatedBuildInputs = with python3Packages; [
    altair astor base58 blinker boto3 botocore enum-compat
    future pillow protobuf requests toml tornado tzlocal validators watchdog
    jinja2 setuptools wheel pip numpy traitlets cachetools pyarrow
    GitPython pydeck click
  ];

  pydeck = (buildPythonApplication rec {
    pname = "pydeck";
    version = "0.7.0";

    src = fetchPypi {
      inherit pname version;
      sha256 = "1zi0gqzd0byj16ja74m2dm99a1hmrlhk26y0x7am07vb1d8lvvsy";
    };

    pythonImportsCheck = [ "pydeck" ];

    checkInputs = with python3Packages; [ pytestCheckHook pandas ];
    # tries to start a jupyter server
    disabledTests = [ "test_nbconvert" ];

    propagatedBuildInputs = with python3Packages; [
      ipykernel
      ipywidgets
    ];
  });

  click = (buildPythonApplication rec {
    pname = "click";
    version = "7.1.2";

    src = fetchPypi {
      inherit pname version;
      sha256 = "06kbzd6sjfkqan3miwj9wqyddfxc2b6hi7p5s4dvqjb3gif2bdfj";
    };
  });

  postInstall = ''
    rm $out/bin/streamlit.cmd # remove windows helper
  '';

  meta = with lib; {
    homepage = "https://streamlit.io/";
    description = "The fastest way to build custom ML tools";
    maintainers = with maintainers; [ yrashk ];
    license = licenses.asl20;
  };
}
