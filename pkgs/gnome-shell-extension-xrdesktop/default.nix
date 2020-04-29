{ stdenv, fetchFromGitLab, glib, gdk_pixbuf, vulkan-loader, vulkan-headers, graphene, cairo, meson, ninja, pkgconfig, glslang, gtk-doc, docbook_xsl, gnome3, hashes }:

stdenv.mkDerivation rec {
  pname = "gnome-shell-extension-xrdesktop";
  version = "${stdenv.lib.versions.majorMinor gnome3.gnome-shell.version}.0-xrdesktop-${import ../version.nix}";

  src = fetchFromGitLab {
    domain = "gitlab.freedesktop.org";
    owner = "xrdesktop";
    repo = "gnome-shell-extension-xrdesktop";
    rev = version;
    sha256 = hashes.extension; # gnome-shell
  };

  nativeBuildInputs = [ pkgconfig meson ninja ];
}
