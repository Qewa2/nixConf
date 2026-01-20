{ config, ... }:
let
        dotfiles = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/modules/dotfiles";
in
{
        environment.etc = {
                "niri/config.kdl".source = "${dotfiles}/niri/config.kdl";
        };
}
