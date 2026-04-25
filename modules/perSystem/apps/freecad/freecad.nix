{ self, ... }: {
        perSystem = { pkgs, lib, ... }: {
                apps.freecad = {
                        type = "app";
                        program = "${lib.getExe self.packages.${pkgs.stdenv.hostPlatform.system}.freecad}";
                        meta.description = "desktop app for things like rofi and fsel";
                };
        };
}
