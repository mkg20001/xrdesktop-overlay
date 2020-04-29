hashes: self: super: {
  openvr = super.callPackage ./openvr {};
  openvrSamples = super.callPackage ./openvr-samples {};

  gulkan = super.callPackage ./gulkan {};
  gxr = super.callPackage ./gxr {};
  libinputsynth = super.callPackage ./libinputsynth {};
  xrdesktop = super.callPackage ./xrdesktop {};

  plasma5 = super.plasma5.overrideScope' (plasma-self: plasma-super: rec {
    # Ensure the kwin-effect-xrdesktop plugin runnin in kwin has access to xrdesktop gsettings-schemas
    kwin = plasma-super.kwin.overrideAttrs (attrs: {
      qtWrapperArgs = [ ''--prefix XDG_DATA_DIRS  : ${self.xrdesktop}/share/gsettings-schemas/${self.xrdesktop.name}'' ];
    });

    kwin-effect-xrdesktop = super.libsForQt5.callPackage ./kwin-effect-xrdesktop {};
    kdeplasma-applets-xrdesktop = super.libsForQt5.callPackage ./kdeplasma-applets-xrdesktop { inherit kwin-effect-xrdesktop; }; # Probably not the right way to do this.
  });

  gnome3 = super.gnome3.overrideScope' (gnome-self: gnome-super: {
    gnome-shell = gnome-super.gnome-shell.overrideAttrs (attrs: rec {
      version = "${gnome-super.gnome-shell.version}-xrdesktop-${import ./version.nix}";

      src = super.fetchgit { # fetchFromGitLab doesn't accept fetchSubmodules?
        url = "https://gitlab.freedesktop.org/xrdesktop/gnome-shell";
        rev = version;
        sha256 = hashes.patched;
        fetchSubmodules = true;
      };

      nativeBuildInputs = attrs.nativeBuildInputs ++ [ self.xrdesktop self.libinputsynth ];
    });
  });

  gnomeExtensions = super.gnomeExtensions // {
    xrdesktop = super.callPackage ./gnome-shell-extension-xrdesktop {};
  };
}
