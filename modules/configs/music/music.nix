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
                        mpd
                        mpc
                        mpv
                        yt-dlp
                        ncpamixer
                        rmpc
                        cfg.getScript
                ];

                services.mpd = {
                        enable = true;

                        user = "mpd";
                        group = "audio";
                        
                        settings = {
                                music_directory = "/Music/";
                                bind_to_address = "127.0.0.1";
                                port = 6600;
                                
                                audio_output = [
                                        {
                                                type = "pipewire";
                                                name = "PipeWire";
                                        }
                                ];
                        };
                };
        };
}
