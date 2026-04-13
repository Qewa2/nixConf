{ self, ... }: {
        perSystem = { pkgs, ... }: {
                packages.launcher = pkgs.writeShellApplication {
                        name = "launcher";

                        runtimeInputs = with pkgs; [
                                coreutils
                                bash
                                kitty
                        ];

                        text = ''
                                #!${pkgs.bash}
                                kitty --app-id="launcher" --title="otter-launcher" -e otter-launcher
                        '';
                };
        };
}
