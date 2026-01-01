{ pkgs, lib, ... }:
{
        vim = {
                theme = {
                        enable = true;
                        name = "gruvbox";
                        style = "dark";
                };
                
                lsp.enable = true;
                languages = {
                        enableTreesitter = true;
                        nix.enable = true;
                        clang.enable = true;
                        pythone.enable = true;
                };
                
                statusline.lualine.enable = true;
                telescope.enable = true;
                autocomplete.nvim-cmp.enable = true;
        };
}
