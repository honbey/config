-- snacks.vim has many configs need to set
return {
  {
    "folke/snacks.nvim",
    dependencies = { "LazyVim/LazyVim" },
    priority = 1000,
    lazy = false,
    opts = {
      statuscolumn = { enabled = false }, -- we set this in options.lua
      indent = { enabled = true },
      input = { enabled = true },
      notifier = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
      bigfile = { enabled = true },
      quickfile = { enabled = true },
      words = { enabled = true },
      terminal = { enabled = true },
      explorer = {},
      toggle = {
        map = function(mode, lhs, rhs, opts)
          local keys = require("lazy.core.handler").handlers.keys
          ---@cast keys LazyKeysHandler
          local modes = type(mode) == "string" and { mode } or mode

          ---@param m string
          modes = vim.tbl_filter(function(m)
            return not (keys.have and keys:have(lhs, m))
          end, modes)

          -- do not create the keymap if a lazy keys handler exists
          if #modes > 0 then
            opts = opts or {}
            opts.silent = opts.silent ~= false
            if opts.remap and not vim.g.vscode then
              ---@diagnostic disable-next-line: no-unknown
              opts.remap = nil
            end
            vim.keymap.set(modes, lhs, rhs, opts)
          end
        end,
      },
      picker = {
        win = {
          input = {
            keys = {
              ["?"] = "toggle_help_input",
              ["<esc>"] = { "cancel", desc = "escape" },
              ["<tab>"] = { "cycle_win", mode = { "i", "n" } }, -- { "select_and_next", mode = { "i", "n" } },
              ["<cr>"] = { "confirm", mode = { "i", "n" } },
              ["<down>"] = { "preview_scroll_down", mode = { "i", "n" } }, -- { "list_down", mode = { "i", "n" } },
              ["<up>"] = { "preview_scroll_up", mode = { "i", "n" } }, -- { "list_up", mode = { "i", "n" } },
              ["<c-c>"] = { "cancel", mode = "i" },
              ["<c-w>"] = { "<c-s-w>", mode = "i", expr = true, desc = "delete word" },
              ["<c-p>"] = { "list_up", mode = { "i", "n" } },
              ["<c-n>"] = { "list_down", mode = { "i", "n" } },
              ["<c-b>"] = { "history_back", mode = { "i", "n" } }, -- { "preview_scroll_up", mode = { "i", "n" } },
              ["<c-f>"] = { "history_forward", mode = { "i", "n" } }, -- { "preview_scroll_down", mode = { "i", "n" } },
              ["<c-u>"] = { "preview_scroll_up", mode = { "i", "n" } }, -- { "list_scroll_up", mode = { "i", "n" } },
              ["<c-d>"] = { "preview_scroll_down", mode = { "i", "n" } }, -- { "list_scroll_down", mode = { "i", "n" } },
              ["<c-g>"] = { "<c-[>", mode = { "i", "n" }, expr = true }, -- { "toggle_live", mode = { "i", "n" } },
              -- compare to raw trouble_open, i removed vim.tbl_deep_extend
              ["<c-t>"] = { "trouble_open", mode = { "i", "n" } }, -- { "tab", mode = { "n", "i" } },
              ["<c-q>"] = { "qflist", mode = { "i", "n" } },
              ["."] = "toggle_focus",
              ["s"] = { "select_and_next", desc = "select and next" },
              ["S"] = { "select_and_prev", desc = "select and prev" },
              ["G"] = "list_bottom",
              ["gg"] = "list_top",
              ["j"] = "list_down",
              ["k"] = "list_up",
              ["f"] = "flash",
              ["q"] = "close",
              -- disabled-keys
              -- cmd: 100,100s/= \(.*\)/= false, -- \1
              ["/"] = false, -- "toggle_focus",
              ["<c-j>"] = false, -- { "list_down", mode = { "i", "n" } },
              ["<c-k>"] = false, -- { "list_up", mode = { "i", "n" } },
              ["<c-down>"] = false, -- { "history_forward", mode = { "i", "n" } },
              ["<c-up>"] = false, -- { "history_back", mode = { "i", "n" } },
              ["<s-cr>"] = false, -- { { "pick_win", "jump" }, mode = { "n", "i" } },
              ["<s-tab>"] = false, -- { "select_and_prev", mode = { "i", "n" } },
              ["<a-d>"] = false, -- { "inspect", mode = { "n", "i" } },
              ["<a-f>"] = false, -- { "toggle_follow", mode = { "i", "n" } },
              ["<a-h>"] = false, -- { "toggle_hidden", mode = { "i", "n" } },
              ["<a-i>"] = false, -- { "toggle_ignored", mode = { "i", "n" } },
              ["<a-m>"] = false, -- { "toggle_maximize", mode = { "i", "n" } },
              ["<a-p>"] = false, -- { "toggle_preview", mode = { "i", "n" } },
              ["<a-w>"] = false, -- { "cycle_win", mode = { "i", "n" } },
              ["<c-a>"] = false, -- { "select_all", mode = { "n", "i" } },
              ["<c-s>"] = false, -- { "edit_split", mode = { "i", "n" } },
              ["<c-v>"] = false, -- { "edit_vsplit", mode = { "i", "n" } },
              ["<c-r>#"] = false, -- { "insert_alt", mode = "i" },
              ["<c-r>%"] = false, -- { "insert_filename", mode = "i" },
              ["<c-r><c-a>"] = false, -- { "insert_cWORD", mode = "i" },
              ["<c-r><c-f>"] = false, -- { "insert_file", mode = "i" },
              ["<c-r><c-l>"] = false, -- { "insert_line", mode = "i" },
              ["<c-r><c-p>"] = false, -- { "insert_file_full", mode = "i" },
              ["<c-r><c-w>"] = false, -- { "insert_cword", mode = "i" },
              ["<c-w>H"] = false, -- "layout_left",
              ["<c-w>J"] = false, -- "layout_bottom",
              ["<c-w>K"] = false, -- "layout_top",
              ["<c-w>L"] = false, -- "layout_right",
            },
          },
          list = {
            keys = {
              ["?"] = "toggle_help_list",
              ["<esc>"] = "cancel",
              ["<2-LeftMouse>"] = "confirm",
              ["<cr>"] = "confirm",
              ["<tab>"] = { "cycle_win", mode = "n", "x" }, -- { "select_and_next", mode = { "n", "x" } },
              ["<down>"] = "list_down",
              ["<up>"] = "list_up",
              ["<c-q>"] = "qflist",
              ["."] = "toggle_focus",
              ["s"] = { "select_and_next", desc = "select and next" },
              ["S"] = { "select_and_prev", desc = "select and prev" },
              ["G"] = "list_bottom",
              ["gg"] = "list_top",
              ["i"] = "focus_input",
              ["j"] = "list_down",
              ["k"] = "list_up",
              ["f"] = "flash",
              ["zb"] = "list_scroll_bottom",
              ["zt"] = "list_scroll_top",
              ["zz"] = "list_scroll_center",
              ["q"] = "close",
              -- disabled keys
              ["/"] = false, -- "toggle_focus",
              ["<s-cr>"] = false, -- { { "pick_win", "jump" } },
              ["<s-tab>"] = false, -- { "select_and_prev", mode = { "n", "x" } },
              ["<a-d>"] = false, -- "inspect",
              ["<a-f>"] = false, -- "toggle_follow",
              ["<a-h>"] = false, -- "toggle_hidden",
              ["<a-i>"] = false, -- "toggle_ignored",
              ["<a-m>"] = false, -- "toggle_maximize",
              ["<a-p>"] = false, -- "toggle_preview",
              ["<a-w>"] = false, -- "cycle_win",
              ["<c-a>"] = false, -- "select_all",
              ["<c-b>"] = false, -- "preview_scroll_up",
              ["<c-d>"] = false, -- "list_scroll_down",
              ["<c-f>"] = false, -- "preview_scroll_down",
              ["<c-j>"] = false, -- "list_down",
              ["<c-k>"] = false, -- "list_up",
              ["<c-n>"] = false, -- "list_down",
              ["<c-p>"] = false, -- "list_up",
              ["<c-s>"] = false, -- "edit_split",
              ["<c-t>"] = false, -- "tab",
              ["<c-u>"] = false, -- "list_scroll_up",
              ["<c-v>"] = false, -- "edit_vsplit",
              ["<c-w>H"] = false, -- "layout_left",
              ["<c-w>J"] = false, -- "layout_bottom",
              ["<c-w>K"] = false, -- "layout_top",
              ["<c-w>L"] = false, -- "layout_right",
            },
          },
          preview = {
            keys = {
              ["?"] = "toggle_help_list",
              ["<esc>"] = "cancel",
              ["<tab>"] = "cycle_win",
              ["i"] = "focus_input",
              ["q"] = "close",
              ["I"] = "inspect",
              ["E"] = "edit_split",
              ["V"] = "edit_vsplit",
              ["L"] = "toggle_live",
              ["F"] = "toggle_follow",
              ["H"] = "toggle_hidden",
              ["G"] = "toggle_ignored",
              ["M"] = "toggle_maximize",
              ["P"] = "toggle_preview",
              -- disabled keys
              ["<a-w>"] = false, -- "cycle_win",
            },
          },
        },
        actions = {
          ---@param p snacks.Picker
          toggle_cwd = function(p)
            local root = LazyVim.root({ buf = p.input.filter.current_buf, normalize = true })
            local cwd = vim.fs.normalize((vim.uv or vim.loop).cwd() or ".")
            local current = p:cwd()
            p:set_cwd(current == root and cwd or root)
            p:find()
          end,
          trouble_open = function(...)
            return require("trouble.sources.snacks").actions.trouble_open.action(...)
          end,
          flash = function(picker)
            require("flash").jump({
              pattern = "^",
              label = { after = { 0, 0 } },
              search = {
                mode = "search",
                exclude = {
                  function(win)
                    return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "snacks_picker_list"
                  end,
                },
              },
              action = function(match)
                local idx = picker.list:row2idx(match.pos[1])
                picker.list:_move(idx, true, true)
              end,
            })
          end,
        },
        sources = {
          explorer = {
            layout = {
              preview = false,
              layout = {
                backdrop = false,
                width = 0.25,
                min_width = 2,
                height = 0,
                position = "left",
                border = "none",
                box = "vertical",
                {
                  win = "list",
                  border = "none",
                  -- title = "{title} {live} {flags}",
                  -- title_pos = "center",
                },
                { win = "preview", title = "{preview}", height = 0.4, border = "rounded" },
              },
            },
            win = {
              list = {
                keys = {
                  ["a"] = { "explorer_add", desc = "add" },
                  ["d"] = { "explorer_del", desc = "delete" },
                  ["r"] = { "explorer_rename", desc = "rename" },
                  ["c"] = { "explorer_copy", desc = "copy" },
                  ["m"] = { "explorer_move", desc = "move" },
                  ["O"] = { "explorer_open", desc = "open with system app" },
                  ["y"] = { "explorer_yank", mode = { "n", "x" }, desc = "yank" },
                  ["p"] = { "explorer_paste", desc = "paste" },
                  ["u"] = { "explorer_update", desc = "update" },
                  ["C"] = { "tcd", desc = "change dir" },
                  ["P"] = { "toggle_preview", desc = "toggle preview" },
                  ["I"] = { "toggle_ignored", desc = "toggle ignored" },
                  ["H"] = { "toggle_hidden", desc = "toggle hidden" },
                  ["Z"] = { "explorer_close_all", desc = "fold all dirs" },
                  ["<Tab>"] = { "confirm", desc = "󰳽 confirm" },
                  ["<BS>"] = { "explorer_up", desc = " parent dir" },
                  ["<C-/>"] = { "picker_grep", desc = "󱁴 grep" },
                  ["]g"] = { "explorer_git_next", desc = "󰒭 next git" },
                  ["[g"] = { "explorer_git_prev", desc = "󰒮 prev git" },
                  ["]d"] = { "explorer_diagnostic_next", desc = "󰒭 next diagnostic" },
                  ["[d"] = { "explorer_diagnostic_prev", desc = "󰒮 prev diagnostic" },
                  ["]w"] = { "explorer_warn_next", desc = "󰒭 next warn" },
                  ["[w"] = { "explorer_warn_prev", desc = "󰒮 prev warn" },
                  ["]e"] = { "explorer_error_next", desc = "󰒭 next error" },
                  ["[e"] = { "explorer_error_prev", desc = "󰒮 prev error" },
                  -- disabled keys
                  -- https://github.com/folke/snacks.nvim/discussions/582
                  ["zb"] = false,
                  ["zt"] = false,
                  ["zz"] = false,
                  ["i"] = false,
                  ["l"] = false,
                  ["o"] = false,
                  ["h"] = false,
                  ["q"] = false,
                  ["."] = false,
                  ["<C-t>"] = false,
                  ["<C-c>"] = false,
                  ["<leader>/"] = false,
                  ["<Esc>"] = false,
                },
              },
            },
          },
        },
      },
      dashboard = {
        preset = {
          pick = function(cmd, opts)
            return LazyVim.pick(cmd, opts)()
          end,
          -- stylua: ignore
          ---@type snacks.dashboard.Item[]
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick()" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "p", desc = "Projects", action = ":lua Snacks.picker.projects()" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
      },
    },
    config = function(_, opts)
      -- delay notifications till vim.notify was replaced or after 500ms
      LazyVim.lazy_notify()

      -- picker for LazyVim
      ---@type LazyPicker
      local picker = {
        name = "snacks",
        commands = {
          files = "files",
          live_grep = "grep",
          oldfiles = "recent",
        },

        ---@param source string
        ---@param options? snacks.picker.Config
        open = function(source, options)
          return Snacks.picker.pick(source, options)
        end,
      }
      LazyVim.pick.register(picker)

      -- noise.nvim
      local notify = vim.notify
      require("snacks").setup(opts)
      vim.notify = notify
    end,
  },
}
