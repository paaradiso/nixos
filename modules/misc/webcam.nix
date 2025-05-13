{
  config,
  pkgs,
  ...
}: {
  boot.kernelModules = ["v4l2loopback"];
  boot.extraModulePackages = with config.boot.kernelPackages; [v4l2loopback.out];
  boot.extraModprobeConfig = ''
    options v4l2loopback exclusive_caps=1 card_label="Virtual Camera"
  '';

  environment.systemPackages = with pkgs; [
    gphoto2
    ffmpeg_6-full
    v4l-utils
    (pkgs.writeShellScriptBin "webcam" "gphoto2 --stdout --capture-movie | ffmpeg -i - -vcodec rawvideo -pix_fmt yuv420p -threads 0 -f v4l2 /dev/video0")
  ];
}
