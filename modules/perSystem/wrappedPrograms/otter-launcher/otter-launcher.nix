{ inputs, self, ... }: {
        perSystem = { pkgs, ... }: {
                packages.otter-launcher = inputs.wrappers.lib.wrapPackage {
                        inherit pkgs;
                        package = inputs.otter-launcher.packages.${pkgs.stdenv.hostPlatform.system}.otter-launcher;
                        runtimeInputs = [
                                self.packages.${pkgs.stdenv.hostPlatform.system}.fsel
                        ];

                        preHook = ''
                                if [ -f "$HOME/.config/otter-launcher/config.toml" ]; then
                                        echo "otter configuration already exists"
                                        export SHOULD_DELETE_FILE=false
                                        export SHOULD_DELETE_DIR=false
                                else
                                        if [ -d "$HOME/.config/otter-launcher/" ]; then
                                                echo "otter configuration directory already exists"
                                                SHOULD_DELETE_DIR=false
                                        else
                                                SHOULD_DELETE_DIR=true
                                        fi

                                        mkdir -p "$HOME/.config/otter-launcher/"
                                        ln -s ${toString ./config.toml} "$HOME/.config/otter-launcher/config.toml"
                                        export SHOULD_DELETE_FILE=true
                                fi
                        '';

                        postHook = ''
                                if [ $SHOULD_DELETE_FILE == true ]; then
                                        rm -rf "$HOME/.config/otter-launcher/config.toml"
                                elif [ $SHOULD_DELETE_DIR == true ]; then
                                        rm -rf "$HOME/.config/otter-launcher/"
                                fi
                        '';
                };
        };
}
