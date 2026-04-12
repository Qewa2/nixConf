{ self, ... }: {
        perSystem = { pkgs, ... }: {
                packages.launcher = pkgs.writeShellApplication {
                        name = "launcher";

                        runtimeInputs = with pkgs; [
                                coreutils
                                bash
                                kitty
                                self.packages.${pkgs.stdenv.hostPlatform.system}.launch
                        ];

                        text = ''
                                #!${pkgs.bash}
                                kitty -e launch
                        '';
                };
        };
}
