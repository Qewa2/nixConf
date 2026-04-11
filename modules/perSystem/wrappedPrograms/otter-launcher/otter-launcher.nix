{ inputs, self, ... }: {
        perSystem = { pkgs, ... }: {
                packages.otter-launcher = inputs.wrappers.lib.wrapPackage {
                        inherit pkgs;
                        package = inputs.otter-launcher.packages.${pkgs.stdenv.hostPlatform.system}.otter-launcher;
                        runtimeInputs = [
                                self.packages.${pkgs.stdenv.hostPlatform.system}.fsel
                        ];

                        preHook = ''
                                export SHOULD_DELETE_DIR=true
                                export SHOULD_DELETE_FILE=true

                                if [ -d "$HOME/.config/otter-launcher/" ]; then
                                        echo "otter configuration directory already exists"
                                        SHOULD_DELETE_DIR=false
                                fi

                                if [ -f "$HOME/.config/otter-launcher/config.toml" ]; then
                                        echo "otter configuration already exists"
                                        SHOULD_DELETE_FILE=false
                                        SHOULD_DELETE_DIR=false
                                else
                                        mkdir -p "$HOME/.config/otter-launcher/"
                                        ln -s ${toString ./config.toml} "$HOME/.config/otter-launcher/config.toml"
                                fi
                        '';

                        postHook = ''
                                if [ $SHOULD_DELETE_FILE == true ]; then
                                        rm -rf "$HOME/.config/otter-launcher/config.toml"
                                fi

                                if [ $SHOULD_DELETE_DIR == true ]; then
                                        rm -rf "$HOME/.config/otter-launcher/"
                                fi
                        '';
                };
        };
}
