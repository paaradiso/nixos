{
  services.udev.enable = true;

  # map fn1 (scancode 90006) to middle click
  services.udev.extraHwdb = ''
    evdev:input:b0003v056Ep010C*
     KEYBOARD_KEY_90006=btn_middle
  '';
}
