{
        flake.homeModules.development = { pkgs, ... }: {
                home.packages = with pkgs; [
                        cargo
                        rustc
                        rustfmt
                        cargo
                        clippy
                        rust-analyzer

                        gnumake
                        clang
                        cmake
                        meson
                ];
        };
}
