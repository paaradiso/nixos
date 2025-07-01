{
  config,
  pkgs,
  secrets,
  ...
}: {
  age.secrets.caddy_env.file = ../../../modules/secrets/caddy_env.age;
  networking.firewall.allowedTCPPorts = [80 443];

  services.caddy = {
    enable = true;
    package = pkgs.caddy.withPlugins {
      plugins = [
        "github.com/caddy-dns/cloudflare@v0.2.2-0.20250506153119-35fb8474f57d"
        # "github.com/hslatman/caddy-crowdsec-bouncer"
        # "github.com/WeidiDeng/caddy-cloudflare-ip"
      ];
      hash = "sha256-1LgYTfzitHBd70kQzqU9G7EA8/SGkg5h19jrF2/dYtI=";
    };

    environmentFile = config.age.secrets.caddy_env.path;

    globalConfig = ''
      email ${secrets.email}
      order log before reverse_proxy
    '';

    extraConfig = ''
      (auth) {
              forward_auth localhost:9091 {
                      uri /api/authz/forward-auth?authelia_url=https://auth.${secrets.domain}/
                      copy_headers Remote-User Remote-Groups Remote-Email Remote-Name
              }
      }

      (cloudflare) {
              tls {
                      dns cloudflare {env.CF_API_TOKEN}
              }
      }

      (private) {
              @denied not remote_ip private_ranges
              abort @denied
      }
    '';

    virtualHosts.":80".extraConfig = ''
      respond "hello"
    '';
  };
}
