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
    autoCmd = [
      {
        command = "silent !nixfmt %";
        event = [
          "BufWritePost"
        ];
        pattern = [
          "*.nix"
        ];
      }
    ];
    keymaps = [
      {
        key = "<leader>lg";
        action = "<cmd>LazyGit<cr>";
        options.desc = "[L]azy [G]it";
      }
    ];

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
        keymaps = {
          lspBuf = {
            K = "hover";
            gD = "references";
            gd = "definition";
            gi = "implementation";
            gt = "type_definition";
            "<leader>rn" = "rename";
            "<leader>ca" = "code_action";
          };
          diagnostic = {
            "<leader>j" = "goto_next";
            "<leader>k" = "goto_prev";
          };
        };
        servers = {
          jedi_language_server.enable = true; # python
          nixd.enable = true; # nix
          ccls.enable = true; # c/cpp
        };
      };
      web-devicons = {
        # required for telescope
        enable = true;
      };
      telescope = {
        enable = true;
        keymaps = {
          "<leader>sf" = {
            action = "find_files";
            options.desc = "[S]earch [F]iles";
          };
          "<leader>sg" = {
            action = "live_grep";
            options.desc = "[S]earch by [G]rep";
          };
          "<leader>sk" = {
            action = "keymaps";
            options.desc = "[S]earch [K]eymaps";
          };
          "<leader><leader>" = {
            action = "buffers";
            options.desc = "[ ] Find existing buffers";
          };
        };
      };
      lazygit = {
        enable = true;
      };
      vimtex = {
        enable = true;
        texlivePackage = pkgs.texlive.combined.scheme-full;
      };
      gitsigns = {
        enable = true;
      };
    };

  };
}
