self: super: {
  discord = super.discord.overrideAttrs (oldAttrs: {
    desktopItem = super.makeDesktopItem {
      name = oldAttrs.pname;
      exec = "Discord --enable-blink-features=MiddleClickAutoscroll";
      icon = oldAttrs.pname;
      desktopName = "Discord";
      genericName = oldAttrs.meta.description;
      categories = [
        "Network"
        "InstantMessaging"
      ];
      mimeTypes = ["x-scheme-handler/discord"];
      startupWMClass = "discord";
    };
  });
}
