{
        perSystem = { pkgs, lib, ... }: {
                packages.blender = pkgs.blender;
                apps.blender = {
                        type = "app";
                        program = "${lib.getExe pkgs.blender}";
                        meta.description = "desktop app for things like rofi and fsel";
                };
        };
}
