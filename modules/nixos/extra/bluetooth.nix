{ ... }: {
        flake.nixosModules.bluetooth = { pkgs, ... }: {
                hardware.bluetooth = {
                        enable = true;
                        powerOnBoot = true;
                        settings =  {
                                General = {
                                        Experimental = true;
                                        FastConnectable = true;
                                };

                                Policy = {
                                        AutoEnable = false;
                                };
                        };
                };

                environment.systemPackages = with pkgs; [
                        bluetui
                ];
        };
}
