{ lib, config, pkgs, ... }:
let
        cfg = config.myConfigs.music;
in
{
        options.myConfigs.music = {
                enable = lib.mkoption {
                        type = lib.types.bool;
                        default = false;
                };
                getscript = lib.mkoption {
                        type = lib.types.package;
                        readonly = true;
                        default = pkgs.writeshellscriptbin "getmusic" ''
                                yt-dlp "ytsearch:$*" \
                                        -x --audio-format mp3 \
                                        -o "%(title)s.%(ext)s" \
                                        -f bestaudio \
                                        -q --no-playlist

                                file=$(ls -t | head -n1)
                                mv "$file" /music/
                        '';
                };
        };

        config = lib.mkIf cfg.enable {
                environment.systempackages = with pkgs; [
                        mpv
                        yt-dlp
                        ncpamixer
                        cfg.getscript
                ];
        };
}
