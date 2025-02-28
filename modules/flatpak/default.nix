{
  services.flatpak = {
    enable = true;
    packages = [
      "com.spotify.Client"
      "org.quassel_irc.QuasselClient"
    ];
  };
}
