{
  config,
  pkgs,
  secrets,
  lib,
  ...
}:
with lib; {
  # options.services.caddy.wildcardServices = mkOption {
  #   type = types.attrsOf types.str;
  #   default = {};
  #   description = "Attribute set of service configurations for the wildcard domain block";
  # };

  # options.services.caddy.wildcardLanServices = mkOption {
  #   type = types.attrsOf types.str;
  #   default = {};
  #   description = "Attribute set of service configurations for the LAN wildcard domain block";
  # };

  config = {
    age.secrets.caddy_env.file = ../../../modules/secrets/caddy_env.age;
    networking.firewall.allowedTCPPorts = [80 443];

    services.caddy = {
      enable = true;
      package = pkgs.caddy.withPlugins {
        plugins = [
          "github.com/caddy-dns/cloudflare@v0.2.2-0.20250506153119-35fb8474f57d"
        ];
        hash = "sha256-itA0FvQw5hfOhpOOvIqhgL4yjD7COP2BLEVhnPCXdQg=";
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

        *.${secrets.domain} {
          import cloudflare

          # ''${builtins.concatStringsSep "\n" (builtins.attrValues config.services.caddy.wildcardServices)}

          handle {
            abort
          }
        }

        *.lan.${secrets.domain} {
          import cloudflare

          # ''${builtins.concatStringsSep "\n" (builtins.attrValues config.services.caddy.wildcardLanServices)}

          handle {
            abort
          }
        }

        *.${secrets.publicDomain} {
          import cloudflare

          handle {
            abort
          }
        }
      '';

      virtualHosts = {
        "ha.lan.${secrets.domain}".extraConfig = ''
          import private
          reverse_proxy 10.1.1.20:8123
        '';
        "uptime.lan.${secrets.domain}".extraConfig = ''
          import private
          reverse_proxy 10.1.40.3:3001
        '';
      };
    };
  };
}
