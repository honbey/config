# Reference

- https://github.com/leslie255/nvim-config
- https://zhuanlan.zhihu.com/p/467428462
- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
- https://www.cnblogs.com/dragonud/p/16201492.html

# My personal modern NeoVim config

# Some configs not used
```lua
-- GrammarousCheck
   vim.cmd([[
      let g:grammarous#languagetool_cmd = 'languagetool'
   nmap <leader>ec :GrammarousCheck<cr>
   nmap <leader>eR :GrammarousReset<cr>
   nmap <leader>er <Plug>(grammarous-reset)
   nmap <leader>eo <Plug>(grammarous-open-info-window)
   nmap <leader>ex <Plug>(grammarous-close-info-window)
   nmap <leader>ef <Plug>(grammarous-fixit)
   nmap <leader>en <Plug>(grammarous-move-to-next-error)
   nmap <leader>ep <Plug>(grammarous-move-to-previous-error)
      let g:grammarous#disabled_rules = {
          \ '*' : ['WHITESPACE_RULE', 'EN_QUOTES', 'ARROWS', 'SENTENCE_WHITESPACE',
          \        'WORD_CONTAINS_UNDERSCORE', 'COMMA_PARENTHESIS_WHITESPACE',
          \        'EN_UNPAIRED_BRACKETS', 'UPPERCASE_SENTENCE_START',
          \        'ENGLISH_WORD_REPEAT_BEGINNING_RULE', 'DASH_RULE', 'PLUS_MINUS',
          \        'PUNCTUATION_PARAGRAPH_END', 'MULTIPLICATION_SIGN', 'PRP_CHECKOUT',
          \        'CAN_CHECKOUT', 'SOME_OF_THE', 'DOUBLE_PUNCTUATION', 'HELL',
          \        'CURRENCY', 'POSSESSIVE_APOSTROPHE', 'ENGLISH_WORD_REPEAT_RULE',
          \        'NON_STANDARD_WORD'],
          \ }
 ]]);

-- https://www.jmaguire.tech/posts/treesitter_folding/
-- function to create a list of commands and convert them to autocommands
-------- This function is taken from https://github.com/norcalli/nvim_utils
 local api = vim.api
 function M.nvim_create_augroups(definitions)
     for group_name, definition in pairs(definitions) do
         api.nvim_command("augroup " .. group_name)
         api.nvim_command("autocmd!")
         for _, def in ipairs(definition) do
             local command = table.concat(vim.tbl_flatten {"autocmd", def}, " ")
             api.nvim_command(command)
         end
         api.nvim_command("augroup END")
     end
 end

 local autoCommands = {
     -- other autocommands
     open_folds = {
         {"BufReadPost,FileReadPost", "*", "normal zR"}
     }
 }

 M.nvim_create_augroups(autoCommands)

        -- TODO GTD
        -- https://github.com/nvim-neorg/neorg/issues/695

        -- TODO add below plugins
        -- 3rd/image.nvim
        -- monaqa/dial.nvim
        -- folke/noice.nvim
        -- dhruvasagar/vim-table-mode
```
