{ lib, config, pkgs, ... }:
let
        cfg = config.myConfigs.music;
in
{
        options.myConfigs.music = {
                enable = lib.mkOption {
                        type = lib.types.bool;
                        default = false;
                };
                getScript = lib.mkOption {
                        type = lib.types.package;
                        readOnly = true;
                        default = pkgs.writeShellScriptBin "getMusic" ''
                                yt-dlp "ytsearch:$*" \
                                        -x --audio-format mp3 \
                                        -o "%(title)s.%(ext)s" \
                                        -f bestaudio \
                                        -q --no-playlist

                                file=$(ls -t | head -n1)
                                mv "$file" /Music/
                        '';
                };
        };

        config = lib.mkIf cfg.enable {
                environment.systemPackages = with pkgs; [
                        mpv
                        yt-dlp
                        ncpamixer
                        rmpc
                        cfg.getScript
                ];

                services.mpd = {
                        enable = true;
                        musicDirectory = "/Music/";

                        user = "mpd";
                        group = "audio";

                        network.listenAddress = "any";
                        network.port = 6600;
                };
        };
}
