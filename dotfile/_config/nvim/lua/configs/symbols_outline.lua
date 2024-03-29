local M = {}

function M.config()
    require("symbols-outline").setup {
        highlight_hovered_item = true,
        show_guides = true,
        auto_preview = true,
        position = "right",
        relative_width = true,
        width = 20,
        auto_close = false,
        show_numbers = false,
        show_relative_numbers = false,
        show_symbol_details = true,
        preview_bg_highlight = "Pmenu",
        autofold_depth = nil,
        auto_unfold_hover = true,
        fold_markers = {"", ""},
        keymaps = {
            -- These keymaps can be a string or a table for multiple keys
            close = {"<Esc>", "q"},
            goto_location = "<Cr>",
            focus_location = "o",
            hover_symbol = "<C-space>",
            toggle_preview = "K",
            rename_symbol = "r",
            code_actions = {"<f12>", "a"},
            fold = "h",
            unfold = "l",
            fold_all = "H",
            unfold_all = "L",
            fold_reset = "R"
        },
        lsp_blacklist = {},
        symbol_blacklist = {},
        --String         xxx ctermfg=107 guifg=#a0c980
        --Constant       xxx ctermfg=179 guifg=#deb974
        --Character      xxx ctermfg=107 guifg=#a0c980
        --Number         xxx ctermfg=107 guifg=#a0c980
        --Boolean        xxx ctermfg=107 guifg=#a0c980
        --Float          xxx ctermfg=107 guifg=#a0c980
        --Function       xxx ctermfg=110 guifg=#6cb6eb
        --Identifier     xxx ctermfg=72 guifg=#5dbbc1
        --Conditional    xxx ctermfg=176 guifg=#d38aea
        --Statement      xxx ctermfg=176 guifg=#d38aea
        --Repeat         xxx ctermfg=176 guifg=#d38aea
        --Label          xxx ctermfg=179 guifg=#deb974
        --Operator       xxx ctermfg=176 guifg=#d38aea
        --Keyword        xxx ctermfg=176 guifg=#d38aea
        --Exception      xxx ctermfg=176 guifg=#d38aea
        --Include        xxx ctermfg=176 guifg=#d38aea
        --PreProc        xxx ctermfg=176 guifg=#d38aea
        --Define         xxx ctermfg=176 guifg=#d38aea
        --Macro          xxx ctermfg=179 guifg=#deb974
        --PreCondit      xxx ctermfg=176 guifg=#d38aea
        --StorageClass   xxx ctermfg=203 guifg=#ec7279
        --Type           xxx ctermfg=203 guifg=#ec7279
        --Structure      xxx ctermfg=203 guifg=#ec7279
        --Typedef        xxx ctermfg=176 guifg=#d38aea
        --Tag            xxx ctermfg=179 guifg=#deb974
        --Special        xxx ctermfg=179 guifg=#deb974
        --SpecialChar    xxx ctermfg=179 guifg=#deb974
        --Delimiter      xxx ctermfg=250 guifg=#c5cdd9
        --SpecialComment xxx cterm=italic ctermfg=246 gui=italic guifg=#758094
        symbols = {
            File = {icon = "", hl = "Special"},
            Module = {icon = "", hl = "Special"},
            Namespace = {icon = "", hl = "Special"},
            Package = {icon = "", hl = "Special"},
            Class = {icon = "𝓒", hl = "Structure"},
            Method = {icon = "ƒ", hl = "Function"},
            Property = {icon = "", hl = "Identifier"},
            Field = {icon = "", hl = "Identifier"},
            Constructor = {icon = "", hl = "Function"},
            Enum = {icon = "ℰ", hl = "Structure"},
            Interface = {icon = "ﰮ", hl = "Structure"},
            Function = {icon = "", hl = "Function"},
            Variable = {icon = "", hl = "Identifier"},
            Constant = {icon = "", hl = "Identifier"},
            String = {icon = "𝓐", hl = "String"},
            Number = {icon = "#", hl = "Number"},
            Boolean = {icon = "⊨", hl = "Boolean"},
            Array = {icon = "", hl = "Structure"},
            Object = {icon = "⦿", hl = "Structure"},
            Key = {icon = "", hl = "Keyword"},
            Null = {icon = "NULL", hl = "Normal"},
            EnumMember = {icon = "", hl = "Variable"},
            Struct = {icon = "𝓢", hl = "Structure"},
            Event = {icon = "", hl = "Special"},
            Operator = {icon = "+", hl = "Operator"},
            TypeParameter = {icon = "𝙏", hl = "Type"}
        }
    }
end

return M
