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

    extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        name = "gruber-darker";
        src = pkgs.fetchFromGitHub {
          owner = "blazkowolf";
          repo = "gruber-darker.nvim";
          rev = "a2dda61d9c1225e16951a51d6b89795b0ac35cd6";
          hash = "sha256-dMs2gdzhS8DLg6P0+msJ+cYluV9LoXE5cW3rI2i+tus=";
        };
      })
    ];
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

      # Harpoon
      {
        key = "<leader>a";
        action.__raw = "function() require('harpoon'):list():add() end";
      }
      {
        key = "<leader>e";
        action.__raw = "function() require('harpoon').ui:toggle_quick_menu(require('harpoon'):list()) end";
      }
      {
        key = "<C-j>";
        action.__raw = "function() require('harpoon'):list():select(1) end";
      }
      {
        key = "<C-k>";
        action.__raw = "function() require('harpoon'):list():select(2) end";
      }
      {
        key = "<C-l>";
        action.__raw = "function() require('harpoon'):list():select(3) end";
      }
      {
        key = "<C-m>";
        action.__raw = "function() require('harpoon'):list():select(4) end";
      }
      # Luasnip
      {
        key = "<Tab>";
        action = " <cmd>lua require('luasnip').jump(1)<cr>";
        mode = [
          "i"
          "s"
        ];
      }
      {
        key = "<S-Tab>";
        action = " <cmd>lua require('luasnip').jump(-1)<cr>";
        mode = [
          "i"
          "s"
        ];
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
          ltex.enable = true; # latex, markdown, bibtex...
          ltex.package = pkgs.ltex-ls;
          ltex.settings.language = "en-US";
          lua_ls.enable = true;
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
      harpoon = {
        enable = true;
        enableTelescope = true;
      };
      lazygit = {
        enable = true;
      };
      vimtex = {
        enable = true;
        texlivePackage = pkgs.texlive.combined.scheme-full;
      };
      luasnip = {
        enable = true;
        settings = {
          enable_autosnippets = true;
        };
        fromLua = [
          { }
          {
            paths = ./nvim-snippets;
          }
        ];
      };
      gitsigns = {
        enable = true;
      };
      render-markdown = {
        enable = true;
      };
      markdown-preview = {
        enable = true;
      };
    };

  };
}
