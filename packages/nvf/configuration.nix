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

                statusline.lualine.enable = true;
                telescope.enable = true;
                autocomplete.nvim-cmp.enable = true;

                lsp.enable = true;
                languages = {
			enableTreesitter = true;
                        clang.enable = true;
			nix.enable = true;
			python.enable = true;
                };
        };

}
