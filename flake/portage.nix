{
  python3,
  fetchFromGitHub,
  lib,
}: let
  attrs = {
    pname = "portage";
    version = "3.0.68";

    pyproject = true;
    build-system = [python3.pkgs.meson-python];
    src = fetchFromGitHub {
      owner = "gentoo";
      repo = "portage";
      tag = "portage-${attrs.version}";
      hash = "sha256-9rRN1FODw2t1W79inotfHMbJx7E92AP9cZOovcUIcbk=";
    };

    mesonOptions = ["-Dsystem-wide=false" "-portage-base=$out"];

    doCheck = true;
    meta = {
      description = "Package management system";
      longDescription = ''
        Portage is the official package manager and distribution system
        for Gentoo. It functions as the heart of Gentoo-based operating
        systems, providing advanced dependency resolution, flexible
        building and installation of software from source or from
        binary packages, and most other core distribution functionality.
      '';
      license = lib.licenses.gpl2;
      homepage = "https://wiki.gentoo.org/wiki/Portage";
      platforms = lib.platforms.linux;
      maintainers = with lib.maintainers; [amadaluzia];
    };
  };
in
  python3.withPackages (ps: [
    (ps.buildPythonPackage attrs)
  ])
