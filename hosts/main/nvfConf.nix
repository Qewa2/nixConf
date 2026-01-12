{ pkgs, ... }:
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

                theme = {
                        enable = true;
                        name = "gruvbox";
                        style = "dark";
                        transparent = false;
                };
                
                filetree.nvimTree = {
                        enable = true;
                        setupOpts = {
                                actions.open_file = {
                                        eject = true;
                                        quit_on_open = true;
                                        window_picker.enable = true;
                                };

                                diagnostics = {
                                        enable = true;
                                        show_on_dirs = true;
                                };
                                
                                filesystem_watchers = {
                                        enable = true;
                                        debounce_delay = 50;
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
                                        setup = {fzf = {fuzzy = true;};};
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

                autocomplete.blink-cmp.enable = true;

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
