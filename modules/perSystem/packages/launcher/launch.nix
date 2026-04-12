{ self, ... }: {
        perSystem = { pkgs, ... }: {
                packages.launch = pkgs.writeShellApplication {
                        name = "launch";

                        runtimeInputs = with pkgs; [
                                coreutils
                                bash
                                self.packages.${pkgs.stdenv.hostPlatform.system}.otter-launcher
                        ];

                        text = ''
                                #!${pkgs.bash}
                                mmsg -d togglefloating
                                mmsg -d resizewin,-10000,-10000
                                mmsg -d resizewin,+400,+600
                                mmsg -d centerwin
                                sleep 0.2
                                clear
                                otter-launcher
                        '';
                };
        };
}
