(
  let
    urdfdom = pkgs.stdenv.mkDerivation rec {
      pname = "urdfdom";
      version = "3.1.1";

      src = pkgs.fetchFromGitHub {
        owner = "ros";
        repo = pname;
        rev = version;
        hash = "sha256-UdkGJAXK3Q8QJaqMZBA5/FKUgWq9EVeqkqwVewTlTD8=";
      };

      patches = [
        # Fix CMake relative install dir assumptions (https://github.com/ros/urdfdom/pull/142)
        (pkgs.fetchpatch {
          url = "https://github.com/ros/urdfdom/commit/cbe6884d267779463bb444be851f6404e692cc0a.patch";
          hash = "sha256-1gTRKIGqiSRion76bGecSfFJSBskYUJguUIa6ePIiX4=";
        })
      ];

      nativeBuildInputs = with pkgs; [
        cmake
        pkg-config
        validatePkgConfig
      ];
      propagatedBuildInputs = with pkgs; [
        urdfdom-headers
        console-bridge
        tinyxml
      ];

      inherit (pkgs.urdfdom) meta;
    };
  in
  {
    buildInputs = old.buildInputs or [ ] ++ [ urdfdom ];
  }
)
