{ pkgs, user, ... }:

{
  home-manager.users.${user} = {
    services.easyeffects.enable = true;
    dconf = {
      enable = true;
      settings = {
        "com/github/wwmm/easyeffects/streamoutputs" = {
          "plugins" = [ "equalizer#0" ];
        };

        "com/github/wwmm/easyeffects/streamoutputs/equalizer/0" = {
          "input-gain" = -3.1;
          "num-bands" = 10;
        };

        "com/github/wwmm/easyeffects/streamoutputs/equalizer/0/leftchannel" = {
          "band0-frequency" = 28.0;
          "band0-gain" = -9.4;
          "band0-q" = 0.35;
          "band1-frequency" = 105.0;
          "band1-gain" = 5.5;
          "band1-q" = 0.71;
          "band1-type" = "Lo-shelf";
          "band2-frequency" = 165.0;
          "band2-gain" = 3.0;
          "band2-q" = 0.55;
          "band3-frequency" = 1500.0;
          "band3-gain" = -3.8;
          "band3-q" = 1.4;
          "band4-frequency" = 1800.0;
          "band4-gain" = 8.0;
          "band4-q" = 0.71;
          "band4-type" = "Hi-shelf";
          "band5-frequency" = 2650.0;
          "band5-gain" = -4.9;
          "band5-q" = 1.7;
          "band6-frequency" = 5350.0;
          "band6-gain" = -9.2;
          "band6-q" = 2.5;
          "band7-frequency" = 8100.0;
          "band7-gain" = -5.1;
          "band7-q" = 5.0;
          "band8-frequency" = 10000.0;
          "band8-gain" = -8.0;
          "band8-q" = 0.71;
          "band8-type" = "Hi-shelf";
          "band9-frequency" = 10400.0;
          "band9-gain" = -2.0;
          "band9-q" = 7.0;
        };

        "com/github/wwmm/easyeffects/streamoutputs/equalizer/0/rightchannel" = {
          "band0-frequency" = 28.0;
          "band0-gain" = -9.4;
          "band0-mode" = "RLC (BT)";
          "band0-mute" = false;
          "band0-q" = 0.35;
          "band0-slope" = "x1";
          "band0-solo" = false;
          "band0-type" = "Bell";
          "band0-width" = 4.0;
          "band1-frequency" = 105.0;
          "band1-gain" = 5.5;
          "band1-mode" = "RLC (BT)";
          "band1-mute" = false;
          "band1-q" = 0.71;
          "band1-slope" = "x1";
          "band1-solo" = false;
          "band1-type" = "Lo-shelf";
          "band1-width" = 4.0;
          "band2-frequency" = 165.0;
          "band2-gain" = 3.0;
          "band2-mode" = "RLC (BT)";
          "band2-mute" = false;
          "band2-q" = 0.55;
          "band2-slope" = "x1";
          "band2-solo" = false;
          "band2-type" = "Bell";
          "band2-width" = 4.0;
          "band3-frequency" = 1500.0;
          "band3-gain" = -3.8;
          "band3-mode" = "RLC (BT)";
          "band3-mute" = false;
          "band3-q" = 1.4;
          "band3-slope" = "x1";
          "band3-solo" = false;
          "band3-type" = "Bell";
          "band3-width" = 4.0;
          "band4-frequency" = 1800.0;
          "band4-gain" = 8.0;
          "band4-mode" = "RLC (BT)";
          "band4-mute" = false;
          "band4-q" = 0.71;
          "band4-slope" = "x1";
          "band4-solo" = false;
          "band4-type" = "Hi-shelf";
          "band4-width" = 4.0;
          "band5-frequency" = 2650.0;
          "band5-gain" = -4.9;
          "band5-mode" = "RLC (BT)";
          "band5-mute" = false;
          "band5-q" = 1.7;
          "band5-slope" = "x1";
          "band5-solo" = false;
          "band5-type" = "Bell";
          "band5-width" = 4.0;
          "band6-frequency" = 5350.0;
          "band6-gain" = -9.2;
          "band6-mode" = "RLC (BT)";
          "band6-mute" = false;
          "band6-q" = 2.5;
          "band6-slope" = "x1";
          "band6-solo" = false;
          "band6-type" = "Bell";
          "band6-width" = 4.0;
          "band7-frequency" = 8100.0;
          "band7-gain" = -5.1;
          "band7-mode" = "RLC (BT)";
          "band7-mute" = false;
          "band7-q" = 5.0;
          "band7-slope" = "x1";
          "band7-solo" = false;
          "band7-type" = "Bell";
          "band7-width" = 4.0;
          "band8-frequency" = 10000.0;
          "band8-gain" = -8.0;
          "band8-mode" = "RLC (BT)";
          "band8-mute" = false;
          "band8-q" = 0.71;
          "band8-slope" = "x1";
          "band8-solo" = false;
          "band8-type" = "Hi-shelf";
          "band8-width" = 4.0;
          "band9-frequency" = 10400.0;
          "band9-gain" = -2.0;
          "band9-mode" = "RLC (BT)";
          "band9-mute" = false;
          "band9-q" = 7.0;
          "band9-slope" = "x1";
          "band9-solo" = false;
          "band9-type" = "Bell";
          "band9-width" = 4.0;
        };
      };
    };
  };
}
