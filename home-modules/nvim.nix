{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    #nixvim.homeManagerModules.nixvim
    inputs.nixvim.homeManagerModules.nixvim

  ];
  #home.packages = with pkgs; [
  #  nixvim.package  # Install nixvim as a package
  #];
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    colorschemes.gruvbox.enable = true;

    clipboard.register = "unnamedplus";

    globals.mapleader = " ";

    opts = {
      number = true;
      relativenumber = true;
    };

    plugins = {
      lualine.enable = true;

      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          sources = [
            { name = "nvim_lsp"; }
            { name = "path"; }
            { name = "buffer"; }
          ];
          mapping = {
            "<C-n>" = "cmp.mapping.select_next_item()";
            "<C-p>" = "cmp.mapping.select_prev_item()";
            "<C-b>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<C-y>" = "cmp.mapping.confirm { select = true }";
          };
        };
      };

      lsp = {
        enable = true;
        servers = {
          jedi_language_server.enable = true; # python
	  nixd.enable = true;                 # nix
        };
      };
    };

  };
}
