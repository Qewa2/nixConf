{ self, ... }: {
        perSystem = { pkgs, ... }: {
                packages.launcher = pkgs.writeShellApplication {
                        name = "launcher";

                        runtimeInputs = with pkgs; [
                                coreutils
                                bash
                                kitty
                                self.packages.${pkgs.stdenv.hostPlatform.system}.otter-launcher
                        ];

                        text = ''
                                #!${pkgs.bash}
                                kitty --app-id="launcher" --title="otter-launcher" -e otter-launcher
                        '';
                };
        };
}
