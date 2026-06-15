{
  services.flatpak = {
    enable = true;
    packages = [
      "com.github.tchx84.Flatseal"
      "com.spotify.Client"
      "org.quassel_irc.QuasselClient"
    ];
    update.onActivation = true;
  };
}
