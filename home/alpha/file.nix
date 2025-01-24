{ ... }: 

{
  home.file = {
    ".local/share/gnome-shell/extensions/no-switcher-delay@illegal.charity" = {
      source = (./files + "/no-switcher-delay@illegal.charity");
      recursive = true;
    };
  };
}
