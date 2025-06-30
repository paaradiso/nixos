let
  personalSystemKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEDy1PeU5A7Y1Wkp+rWUiIsB3ZhNZHqNLiLtgwNLfIEt root@dearth"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINbuKy6SVj5pIgO+oZ3B5pvKS9My2xvLWCTwslBsH5GU alpha@dearth"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILoVuWfkMp3gOTKO0Q8QREy78uzf3V/vhCQh5IT0kLl9 root@phosphene"
  ];
  serverKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG2P8/nbOzy5vpo8Y2RUMxfkd/6aAd25cceO9qjVWCdx root@synarchy"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMorgVpd+qUc7IuiaMUVHOeJ21Q44Iu1TU+TMkgfeLk9 alpha@synarchy"
  ];
  allKeys = personalSystemKeys ++ serverKeys;
in {
  "git_key.age".publicKeys = allKeys;
  "podman_vaultwarden_env.age".publicKeys = serverKeys;
  "podman_redis_env.age".publicKeys = serverKeys;
}
