<<<<<<< HEAD
<<<<<<< HEAD
{pkgs, final, ...}
        :
            old:
            let funcs = [(old: old // ( if ((old.format or "sdist") == "wheel") then {buildInputs = old.buildInputs or [] ++ [
             (pkgs.boost183.override {
                 python = final.python;
                 numpy = final.numpy;
                 enablePython = true;
             })
              final.eigenpy pkgs.boost183 pkgs.console-bridge pkgs.hpp-fcl pkgs.octomap pkgs.tinyxml pkgs.urdfdom];preFixup = ''addAutoPatchelfSearchPath ${final.eigenpy}/${final.python.sitePackages}/cmeel.prefix/${final.python.sitePackages}
'';} else {buildInputs = old.buildInputs or [] ++ [
             (pkgs.boost183.override {
                 python = final.python;
                 numpy = final.numpy;
                 enablePython = true;
             })
              final.eigenpy pkgs.boost183 pkgs.console-bridge pkgs.hpp-fcl pkgs.octomap pkgs.tinyxml pkgs.urdfdom];})) (old: old // ( (
=======
{pkgs, ...}
        : old: (
>>>>>>> 5c383aa62f2a51c963fa8574d2a80a6501ce804e
=======
{pkgs, ...}
        : old: (
>>>>>>> 885bd5ab485137d8e36245620bbceb4694647e57
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

      nativeBuildInputs = with pkgs; [cmake pkg-config validatePkgConfig];
      propagatedBuildInputs = with pkgs; [urdfdom-headers console-bridge tinyxml];

      meta = pkgs.urdfdom.meta;
    };
  in {
    buildInputs = old.buildInputs or [] ++ [urdfdom];
  }
)
<<<<<<< HEAD
<<<<<<< HEAD
))];
            in
            pkgs.lib.trivial.pipe old funcs
    
=======

        
>>>>>>> 5c383aa62f2a51c963fa8574d2a80a6501ce804e
=======

        
>>>>>>> 885bd5ab485137d8e36245620bbceb4694647e57
