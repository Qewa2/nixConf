{ inputs, ... }: {
        perSystem = { pkgs, ... }: {
                packages.myNvim = (inputs.nvf.lib.neovimConfiguration {
                        inherit pkgs;
                        modules = [
                                {
                                        config.vim = {
                                                options = {
                                                        shiftwidth = 8;
                                                        tabstop = 8;
                                                };

                                                clipboard = {
                                                        enable = true;
                                                        providers.wl-copy.enable = true;
                                                        registers = "unnamedplus";
                                                };

                                                dashboard.alpha = {
                                                        enable = true;
                                                        theme = null;

                                                        layout = [
                                                                { type = "padding"; val = 4; }

                                                                {
                                                                        type = "text";
                                                                        val = [
                                                                                "███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗"
                                                                                "████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║"
                                                                                "██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║"
                                                                                "██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║"
                                                                                "██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║"
                                                                                "╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝"
                                                                        ];
                                                                        opts = { position = "center"; hl = "Type"; };
                                                                }
                                                        ];
                                                };

                                                git = {
                                                        enable = true;
                                                        git-conflict.enable = true;
                                                        gitlinker-nvim.enable = true;
                                                        gitsigns.enable = true;
                                                        hunk-nvim.enable = true;
                                                        neogit.enable = true;
                                                };

                                                theme = {
                                                        enable = true;
                                                };

                                                visuals = {
                                                        highlight-undo.enable = true;
                                                        fidget-nvim.enable = true;
                                                        indent-blankline.enable = true;
                                                };

                                                filetree.nvimTree = {
                                                        enable = true;
                                                        openOnSetup = false;
                                                        setupOpts = {
                                                                actions.open_file = {
                                                                        eject = true;
                                                                        quit_on_open = true;
                                                                        window_picker.enable = true;
                                                                };

                                                                diagnostics = {
                                                                        enable = true;
                                                                        show_on_dirs = false;
                                                                };

                                                                filesystem_watchers = {
                                                                        enable = true;
                                                                        debounce_delay = 50;
                                                                };

                                                                git = {
                                                                        enable = true;
                                                                        show_on_dirs = true;
                                                                        show_on_open_dirs = true;
                                                                };
                                                        };
                                                };

                                                statusline.lualine.enable = true;
                                                telescope = {
                                                        enable = true;
                                                        extensions = [
                                                                {
                                                                        name = "fzf";
                                                                        packages = [pkgs.vimPlugins.telescope-fzf-native-nvim];
                                                                        setup = { fzf = {fuzzy = true;};};
                                                                }
                                                        ];
                                                };

                                                binds = {
                                                        cheatsheet.enable = true;
                                                        whichKey = {
                                                                enable = true;
                                                                setupOpts.preset = "classic";
                                                        };
                                                        hardtime-nvim.enable = true;
                                                };

                                                autopairs.nvim-autopairs.enable = true;

                                                autocomplete = {
                                                        blink-cmp.enable = true;
                                                        enableSharedCmpSources = true;
                                                };

                                                lsp.enable = true;
                                                languages = {
                                                        enableTreesitter = true;
                                                        clang.enable = true;
                                                        python.enable = true;
                                                        nix = {
                                                                enable = true;
                                                                extraDiagnostics.enable = true;
                                                                lsp = {
                                                                        enable = true;
                                                                        servers = [ "nil" "nixd" ];
                                                                };
                                                        };
                                                };
                                        };
                                }
                        ];
                }).neovim;
        };
}
