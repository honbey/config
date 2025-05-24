-- manage plugins's keymaps if the plugin not loaded by keys
-- :group:plugin: show which plugin use the keymap, orgmode-like tags
-- (^use) what is the Capital key do

return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts_extend = { "spec" },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Keymaps (which-key)",
      },
      {
        "<c-w><space>",
        function()
          require("which-key").show({ keys = "<c-w>", loop = true })
        end,
        desc = "Window Hydra Mode (which-key)",
      },
    },
    config = function()
      local opts = {
        preset = "helix",
        defaults = {},
        spec = {
          -- stylua: ignore
          {
            -- tabs
            { "<leader><tab>", group = "tabs", mode = { "n", "v"} },

            -- code
            { "<leader>c", group = "code", mode = { "n", "v"} },

            -- debug
            { "<leader>d", group = "debug", mode = { "n", "v"} },

            -- profiler
            { "<leader>dp", group = "profiler", mode = { "n", "v"} },

            -- f :file:find:snacks:
            { "<leader>f", group = "file/find", mode = { "n", "v"} },

            -- s :search:snacks:todo_comment:
            { "<leader>s", group = "search", mode = { "n", "v"} },
            -- S :Session:persistence:
            { "<leader>S", group = "session", mode = { "n", "v"} },
            -- search in picker :snacks:
            { "<leader>p", group = "picker", mode = { "n", "v"} },

            -- g :git:git_signs:neogit:
            { "<leader>g", group = "git", mode = { "n", "v"} },
            { "<leader>gh", group = "hunks", mode = { "n", "v"} },

            -- q :quit:sestion:
            { "<leader>q", group = "quit", mode = { "n", "v"} },
            { "<leader>sq", "<esc>", hidden = true },
            { "<leader>pq", "<esc>", hidden = true },

            -- u :ui:
            { "<leader>u", group = "ui", icon = { icon = "󰙵 ", color = "cyan" }, mode={ "n", "v"} },

            -- x :diagnostics:quickfix:
            { "<leader>x", group = "diagnostics/quickfix", icon = { icon = "󱖫 ", color = "green" }, mode={ "n", "v"} },

            -- [/] :prev:next:
            { "[", group = "prev", mode={ "n", "v"} },
            { "]", group = "next", mode={ "n", "v"} },

            -- g :goto:
            { "g", group = "goto", mode={ "n", "v"} },
            -- { "gs", group = "surround", mode={ "n", "v"} },

            -- z :fold:
            { "z", group = "fold", mode={ "n", "v"} },

            -- b :buffer:bufferline:
            { "<leader>b", group = "buffer", expand = function() return require("which-key.extras").expand.buf() end, mode={ "n", "v"} },

            -- w :windows:
            { "<leader>w", group = "windows", proxy = "<c-w>", expand = function() return require("which-key.extras").expand.win() end, mode={ "n", "v"} },

            -- N :noice:
            { "<leader>N", group = "N", mode={ "n", "v"} },

            -- :neogit:
            { "<leader>gm", "<cmd>Neogit<cr>", desc = "Open Neogit(magit-like)" },

            -- :bufferline:
            { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
            { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
            { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
            { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
            { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
            { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
            { "[B", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
            { "]B", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
            { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
            { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
            -- :noice:
            { "<leader>Nl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
            { "<leader>Nh", function() require("noice").cmd("history") end, desc = "Noice History" },
            { "<leader>Na", function() require("noice").cmd("all") end, desc = "Noice All" },
            { "<leader>Nd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
            { "<leader>Nt", function() require("noice").cmd("pick") end, desc = "Noice Picker (Telescope/FzfLua)" },
            { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
            { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll Forward", mode = {"i", "n", "s"} },
            { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll Backward", mode = {"i", "n", "s"}},
            -- :snacks:
            ---@diagnostic disable: undefined-field
            { "<leader>n", function() if Snacks.config.picker and Snacks.config.picker.enabled then Snacks.picker.notifications() else Snacks.notifier.show_history() end end, desc = "Notification History" },
            { "<leader>sn", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
            -- buffer
            { "<leader>bb", function() Snacks.picker.buffers() end, desc = "Buffers" },
            -- (hidden)
            { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History", hidden = true },
            { "<leader>/", LazyVim.pick("grep"), desc = "Grep (Root Dir)", hidden = true },
            { "<leader><space>", LazyVim.pick("files"), desc = "Find Files (Root Dir)", hidden = true },
            -- find
            { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers (^all)" },
            { "<leader>fB", function() Snacks.picker.buffers({ hidden = true, nofile = true }) end, desc = "Buffers (all)", hidden = true },
            { "<leader>fc", LazyVim.pick.config_files(), desc = "Find Config File" },
            ---@diagnostic disable-next-line: missing-fields
            { "<leader>fe", function() Snacks.explorer({ cwd = LazyVim.root() }) end, desc = "Explorer (root dir ^cwd)" },
            { "<leader>fE", function() Snacks.explorer() end, desc = "Explorer (root dir)", hidden = true },
            { "<leader>ff", LazyVim.pick("files"), desc = "Find Files (^cwd)" },
            { "<leader>fF", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)", hidden = true },
            { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files)" },
            { "<leader>fr", LazyVim.pick("oldfiles"), desc = "Recent (^cwd)" },
            { "<leader>fR", function() Snacks.picker.recent({ filter = { cwd = true }}) end, desc = "Recent (cwd)", hidden = true },
            { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
            -- git
            { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (hunks)" },
            { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
            { "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
            -- grep
            { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
            { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
            { "<leader>sg", LazyVim.pick("live_grep"), desc = "Grep (Root Dir ^cw)" },
            { "<leader>sG", LazyVim.pick("live_grep", { root = false }), desc = "Grep (cwd)", hidden = true },
            { "<leader>sw", LazyVim.pick("grep_word"), desc = "Visual selection or word (Root Dir ^cwd)", mode = { "n", "x" } },
            { "<leader>sW", LazyVim.pick("grep_word", { root = false }), desc = "Visual selection or word (cwd)", mode = { "n", "x" }, hidden = true },
            -- picker
            { '<leader>p"', function() Snacks.picker.registers() end, desc = "Registers" },
            { '<leader>p/', function() Snacks.picker.search_history() end, desc = "Search History" },
            { "<leader>pa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
            { "<leader>pc", function() Snacks.picker.command_history() end, desc = "Command History" },
            { "<leader>pC", function() Snacks.picker.commands() end, desc = "Commands" },
            { "<leader>pd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
            { "<leader>pD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
            { "<leader>pf", function() Snacks.picker.qflist() end, desc = "quickFix List" },
            { "<leader>ph", function() Snacks.picker.help() end, desc = "Help Pages" },
            { "<leader>pH", function() Snacks.picker.highlights() end, desc = "Highlights" },
            -- icons picker startup need long time
            -- { "<leader>pi", function() Snacks.picker.icons() end, desc = "Icons" },
            { "<leader>pj", function() Snacks.picker.jumps() end, desc = "Jumps" },
            { "<leader>pk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
            { "<leader>pl", function() Snacks.picker.loclist() end, desc = "Location List" },
            { "<leader>pL", function() Snacks.picker.lazy() end, desc = "Lazy Plugin Spec" },
            { "<leader>pm", function() Snacks.picker.marks() end, desc = "Marks" },
            { "<leader>pM", function() Snacks.picker.man() end, desc = "Man Pages" },
            { "<leader>pR", function() Snacks.picker.resume() end, desc = "Resume Last Picker" },
            { "<leader>pu", function() Snacks.picker.undo() end, desc = "Undotree" },
            { "<leader>pU", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
            -- :treesitter:
            { "<c-space>", desc = "Increment Selection" },
            { "<bs>", desc = "Decrement Selection", mode = "x" },
            -- :presistence:
            { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
            { "<leader>qS", function() require("persistence").select() end,desc = "Select Session" },
            { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
            { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
            -- :todo_comment:
            ---@diagnostic disable: undefined-field
            { "<leader>st", function() Snacks.picker.todo_comments() end, desc = "Todo" },
            { "<leader>sT", function () Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "Todo/Fix/Fixme" },
            -- :conform:
            { "<leader>cf", function() LazyVim.format({ force = true }) end, mode = { "n", "v" }, desc = "Format " },
            { "<leader>cF", function() require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 }) end, mode = { "n", "v" }, desc = "Format Injected Langs" },

            -- other
            { "gx", desc = "Open with system app" },
            { "<leader>l", "<cmd>Lazy<cr>", desc = "LazyNvim", hidden = true },
            { "<leader>fs", "<cmd>w<cr>", desc = "Save" },
            { "<leader>qa", "<cmd>qa<cr>", desc = "Quit All" },
            { "\\", "q" },
            { "q", "<nop>", noremap = true },
            { "Q", "<nop>", noremap = true },
            { "_", '"_' },
            { "<c-g>", "<c-\\><c-n>", mode = { "n", "i", "t" } },
            { "<c-[>", "<c-\\><c-n>", mode = "t" },
          },
        },
      }
      require("which-key").setup(opts)
    end,
  },
}
