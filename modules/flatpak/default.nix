{
  services.flatpak = {
    enable = true;
    packages = [
      "com.github.tchx84.Flatseal"
      "com.spotify.Client"
      "org.quassel_irc.QuasselClient"
      "com.github.iwalton3.jellyfin-media-player"
    ];
    update.onActivation = true;
  };
}
