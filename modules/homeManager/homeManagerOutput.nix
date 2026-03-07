{ lib, ... }: {
        options.flake.homeManagerModules = lib.mkOption {
                type = lib.types.attrsOf lib.types.anything;
                default = {};
        };
}
