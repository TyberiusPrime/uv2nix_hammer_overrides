with pkgs;
{
  nativeBuildInputs = [ pkg-config ];
  buildInputs = [
    libinput
    libxkbcommon
    pixman
    xorg.libxcb
    xorg.xcbutilwm
    udev
    wayland
    wlroots
  ];
}
