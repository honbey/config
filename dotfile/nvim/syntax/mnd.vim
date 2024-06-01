" Mindcode syntax file
" Language:     mindcode
" Maintainer:   Honbey
" Last Change:  2024-06-01
" Remark:       Mindcode to Mindustry Logic
" Reference:....
"   https://vimcdoc.sourceforge.net/doc/usr_44.html#44.3
"   https://vimdoc.sourceforge.net/
"   https://github.com/fatih/vim-go/blob/master/syntax/go.vim
"   https://github.com/vim-python/python-syntax/blob/master/syntax/python.vim
"   https://thoughtbot.com/blog/writing-vim-syntax-plugins
"   https://github.com/cardillan/mindcode/tree/main/doc/syntax

clear

if exists("b:current_syntax")
  finish
endif

syn case match

syn match mndComment /\/\/.*/
syn match mndComment /\/\/.*/ contains=mndTodo
syn region mndComment start=/\/\// end=/$/ contained

syn keyword mndTodo TODO FIXME XXX BUG contained
syn region mndPreproc start=/#/ end=/$/ contains=mndComment keepend

hi def link mndComment Comment
hi def link mndPreProc PreProc

syn keyword mndType const
syn keyword mndMemory heap stack

syn keyword mndFunctionKey def skipwhite nextgroup=mndFuncName

syn keyword mndConditional if else elsif case
syn keyword mndRepeat while do loop for
syn keyword mndLabel when then break continue
syn keyword mndInlineFunc inline
syn keyword mndAllocateMem allocate
syn keyword mndKeyword end
syn keyword mndLogicControl contained end

hi def link mndInlineFunc mndStatement
hi def link mndAllocateMem mndStatement

hi def link mndType Type
hi def link mndMemory Structure
hi def link mndConditional Conditional
hi def link mndRepeat Repeat
hi def link mndLabel Label
hi def link mndKeyword Keyword
hi def link mndStatement Statement

syn cluster mndExpression contains=mndNumber,mndFloat,mndOperator
syn cluster mndExpValue contains=mndNumber,mndFloat,mndVariable,mndNull
syn cluster mndExpValue add=mndGlobalVar,mndInnerVar,mndExterVar

syn keyword mndBooleanOp and or not in
syn match mndBooleanOp /[!<>]=\=\|[!=]==/
syn match mndBooleanOp /!\|\([&|=]\)\1/
syn match mndBinaryOp /<<\|>>\|[&|^]/
syn match mndArithmeticOp /[-+\\%]\|\*\=\*/
syn match mndArithmeticOp /\/\%(=\|\ze[^/*]\)/
syn match mndVarAssign /=/ skipwhite nextgroup=mndExpValue
syn match mndVarAssign /[-+\\%&|^]=/
syn match mndVarAssign /\([*<>&|]\)\1\==/
" TODO: improve accuracy
syn match mndTernaryOp /?\(\_s\S\)\@=/

hi def link mndBooleanOp mndOperator
hi def link mndBinaryOp mndOperator
hi def link mndArithmeticOp mndOperator
hi def link mndVarAssign mndOperator
hi def link mndTernaryOp mndOperator

hi def link mndOperator Operator

" syn region mndParen start=/(/ end=/)/ transparent

" TODO: skip... nextgroup
syn match mndVariable /[^.$@]\<\zs\h\w*\ze\>/ skipwhite nextgroup=mndVarAssign
syn match mndGlobalVar /\<\u\%(\u\|[_0-9]\)*\>/
syn match mndInnerVar /\<\l\+\d\+\>/
syn match mndInnerVar /\zs@\l\h*\ze\>/
syn match mndExterVar /$\h\w*\>/

hi def link mndVariable Identifier
hi def link mndGlobalVar Identifier
hi! def link mndInnerVar Tag
hi! def link mndExterVar Delimiter

syntax match mndFuncName /\<\zs\h\w*\ze\s*(/
syntax match mndFuncParams /\<\h\w*(\zs[^()]*\ze)/

hi def link mndFunctionKey Function
hi def link mndFuncName Function

syn keyword mndNull null
syn match mndNumber /\v<\d+>/
syn match mndNumber /\v<0x\x+([Pp]-?)?\x+>/
syn match mndFloat /\v<\d+\.\d+>/
syn match mndFloat /\v<\d*\.?\d+([Ee]-?)?\d+>/
syn match mndBoolean /true\|false/

hi def link mndNull Constant
hi def link mndNumber Number
hi def link mndFloat Float
hi def link mndBoolean Boolean

syn region mndString start=/"/ skip=/\\"/ end =/"/
syn region mndString start=/'/ skip=/\\'/ end =/'/
syn match mndInnerIcon /\<\(BLOCK\|ITEM\|LIQUID\|STATUS\|TEAM\|UNIT\)-\%(\u\|-\)\+\>/
syn match mndInnerIcon /ALPHAAAA\|CRATER/

hi def link mndString String
hi def link mndPattern String
hi def link mndInnerIcon Character

syn region mndList start=/\[/ end=/\]/ contains=ALLBUT,mndString

let b:current_syntax = 'mnd'
