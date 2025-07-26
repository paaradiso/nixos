let
  personalSystemKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEDy1PeU5A7Y1Wkp+rWUiIsB3ZhNZHqNLiLtgwNLfIEt root@dearth"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINbuKy6SVj5pIgO+oZ3B5pvKS9My2xvLWCTwslBsH5GU alpha@dearth"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILoVuWfkMp3gOTKO0Q8QREy78uzf3V/vhCQh5IT0kLl9 root@phosphene"
  ];
  serverKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFDwSXaXRFcHekx00ASHWowaWmBb21C1hQz0wUpqu+dM root@synarchy"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICkh5tUOVV9ErPoRyB1Ygq00Cg6SNPg8LtffRLAo8tWT alpha@synarchy"
  ];
  allKeys = personalSystemKeys ++ serverKeys;
in {
  "git_key.age".publicKeys = allKeys;
  "caddy_env.age".publicKeys = allKeys;
  "podman_vaultwarden_env.age".publicKeys = allKeys;
  "podman_redis_env.age".publicKeys = allKeys;
  "podman_immich_env.age".publicKeys = allKeys;
  "podman_jellyseerr_env.age".publicKeys = allKeys;
  "podman_postgresql_env.age".publicKeys = allKeys;
  "podman_outline_env.age".publicKeys = allKeys;
  "podman_wrtag_env.age".publicKeys = allKeys;
  "podman_minio_env.age".publicKeys = allKeys;
}
