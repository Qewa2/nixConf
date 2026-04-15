{ inputs, ... }: {
        flake.homeModules.mango = { pkgs, ... }: {
                imports = [
                        inputs.mangowm.hmModules.mango
                ];

                wayland.windowManager.mango = {
                        enable = true;
                        package = inputs.mangowm.packages.${pkgs.stdenv.hostPlatform.system}.mango;
                };
        };
}
