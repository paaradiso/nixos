let
  keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEDy1PeU5A7Y1Wkp+rWUiIsB3ZhNZHqNLiLtgwNLfIEt root@dearth"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILoVuWfkMp3gOTKO0Q8QREy78uzf3V/vhCQh5IT0kLl9 root@phosphene"
  ];
in {
  "git_key.age".publicKeys = keys;
}
