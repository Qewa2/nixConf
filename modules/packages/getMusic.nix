{
        perSystem = { pkgs, ... }: {
                packages.getMusic = pkgs.writeShellApplication {
                        name = "getMusic";

                        runtimeInputs = with pkgs; [
                                yt-dlp
                                coreutils
                        ];

                        text = ''
                                ${pkgs.lib.getExe pkgs.yt-dlp} "ytsearch:$*" \
                                        -x --audio-format wav \
                                        -o "%(title)s.%(ext)s" \
                                        -f bestaudio \
                                        -q --no-playlist
                        '';
                };
        };
}
