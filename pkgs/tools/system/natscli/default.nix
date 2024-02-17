{ lib
, buildGoModule
, fetchFromGitHub
}:

buildGoModule rec {
  pname = "natscli";
  version = "0.1.3";

  src = fetchFromGitHub {
    owner = "nats-io";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-40gKG47C8RvgPm3qJ5oNJP82efmCfrCSKVt+35jawlw=";
  };

  vendorHash = "sha256-d2JijN9OU/hQFU3Q2kEAWU0nRrPacfRWNIhEuLHjoIc=";

  meta = with lib; {
    description = "NATS Command Line Interface";
    homepage = "https://github.com/nats-io/natscli";
    license = with licenses; [ asl20 ];
    maintainers = with maintainers; [ fab ];
    mainProgram = "nats";
  };
}
