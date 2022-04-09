"enables 24-bit RGB color in the TUI
set termguicolors

" transparent cursorline
set cursorline

if (&background == 'light')
    " ----- light -----
    hi Normal guifg=#3c3836 guibg=NONE
    hi Terminal guifg=#3c3836 guibg=#f9f5d7
    hi Folded guifg=#928374 guibg=#f3eac7
    hi SignColumn guifg=#3c3836 guibg=NONE
    hi FoldColumn guifg=#928374 guibg=#f3eac7
    hi IncSearch guifg=#f9f5d7 guibg=#ae5858
    hi Search guifg=#f9f5d7 guibg=#6f8352
    hi ColorColumn guifg=NONE guibg=#f3eac7
    hi Conceal guifg=#ebdbb2
    hi DiffAdd guifg=NONE guibg=#e4edc8
    hi DiffChange guifg=NONE guibg=#e0e9d3
    hi DiffDelete guifg=NONE guibg=#f8e4c9
    hi DiffText guifg=#f9f5d7 guibg=#076678
    hi Directory guifg=#79740e
    hi ErrorMsg guifg=#9d0006 guibg=NONE gui=boldunderline
    hi WarningMsg guifg=#b57614 guibg=NONE gui=bold
    hi ModeMsg guifg=#3c3836 guibg=NONE gui=bold
    hi MoreMsg guifg=#b57614 guibg=NONE gui=bold
    hi MatchParen guifg=#af3a03 guibg=NONE gui=bold
    hi NonText guifg=#ebdbb2
    hi Whitespace guifg=#ebdbb2
    hi SpecialKey guifg=#ebdbb2
    hi Pmenu guifg=#3c3836 guibg=#f3eac7
    hi PmenuSel guifg=#f3eac7 guibg=#076678
    hi PmenuSbar guifg=#f3eac7 guibg=#f3eac7
    hi PmenuThumb guifg=#076678 guibg=#f3eac7
    hi NormalFloat guifg=#3c3836 guibg=#f3eac7
    hi Question guifg=#b57614
    hi SpellBad guifg=NONE gui=undercurl
    hi SpellCap guifg=NONE gui=undercurl
    hi SpellLocal guifg=NONE gui=undercurl
    hi SpellRare guifg=NONE gui=undercurl
    hi StatusLine guifg=#3c3836 guibg=#f5edca
    hi StatusLineTerm guifg=#3c3836 guibg=#f5edca
    hi StatusLineNC guifg=#928374 guibg=#f5edca
    hi StatusLineTermNC guifg=#928374 guibg=#f5edca
    hi TabLine guifg=#3c3836 guibg=#eee0b7
    hi TabLineFill guifg=#3c3836 guibg=#f5edca
    hi TabLineSel guifg=#f9f5d7 guibg=#7c6f64
    hi VertSplit guifg=#ebdbb2
    hi Visual guibg=#f9f5d7 gui=inverse
    hi VisualNOS guibg=#f9f5d7 gui=inverse
    hi QuickFixLine guifg=#8f3f71 gui=bold
    hi Debug guifg=#af3a03
    hi debugPC guifg=#f9f5d7 guibg=#79740e
    hi debugBreakpoint guifg=#f9f5d7 guibg=#9d0006
    hi ToolbarButton guifg=#f9f5d7 guibg=#7c6f64
    hi Substitute guifg=#f9f5d7 guibg=#b57614
    hi Boolean guifg=#8f3f71
    hi Number guifg=#8f3f71
    hi Float guifg=#8f3f71
    hi PreProc guifg=#8f3f71 gui=italic
    hi PreCondit guifg=#8f3f71 gui=italic
    hi Include guifg=#8f3f71 gui=italic
    hi Define guifg=#8f3f71 gui=italic
    hi Conditional guifg=#9d0006 gui=italic
    hi Repeat guifg=#9d0006 gui=italic
    hi Keyword guifg=#9d0006 gui=italic
    hi Typedef guifg=#9d0006 gui=italic
    hi Exception guifg=#9d0006 gui=italic
    hi Statement guifg=#9d0006 gui=italic
    hi Error guifg=#3c3836 guibg=NONE
    hi StorageClass guifg=#af3a03
    hi Tag guifg=#af3a03
    hi Label guifg=#af3a03
    hi Structure guifg=#af3a03
    hi Operator guifg=#af3a03
    hi Title guifg=#af3a03 gui=bold
    hi Special guifg=#b57614
    hi SpecialChar guifg=#b57614
    hi Type guifg=#b57614
    hi Function guifg=#79740e gui=bold
    hi String guifg=#79740e
    hi Character guifg=#79740e
    hi Constant guifg=#427b58
    hi Macro guifg=#427b58
    hi Identifier guifg=#076678 gui=italic
    hi Comment guifg=#928374 gui=italic
    hi SpecialComment guifg=#928374 gui=italic
    hi Todo guifg=#8f3f71 gui=italic
    hi Delimiter guifg=#3c3836
    hi Ignore guifg=#928374
    hi Underlined guifg=NONE gui=underline
    hi ErrorText guifg=NONE guibg=#f0ddc3 gui=undercurl
    hi WarningText guifg=NONE guibg=#f9eabf gui=undercurl
    hi InfoText guifg=NONE guibg=#d9e1cc gui=undercurl
    hi HintText guifg=#9d0006
    hi ErrorLine guifg=NONE guibg=#f0ddc3
    hi WarningLine guifg=NONE guibg=#f9eabf
    hi InfoLine guifg=NONE guibg=#d9e1cc
    hi HintLine guifg=NONE guibg=#dde5c2
    hi ErrorFloat guifg=#9d0006 guibg=#f2e5bc
    hi WarningFloat guifg=#b57614 guibg=#f2e5bc
    hi InfoFloat guifg=#076678 guibg=#f2e5bc
    hi HintFloat guifg=#79740e guibg=#f2e5bc
    hi LineNr guifg=#ebdbb2
    hi CursorLineNr guifg=#076678
    hi CursorLine guifg=NONE guibg=NONE
    hi CursorColumn guifg=NONE guibg=#f5edca
    hi healthError guifg=#9d0006
    hi healthSuccess guifg=#79740e
    hi healthWarning guifg=#b57614
    hi markdownH1 guifg=#9d0006 gui=bold
    hi markdownH2 guifg=#af3a03 gui=bold
    hi markdownH3 guifg=#b57614 gui=bold
    hi markdownH4 guifg=#79740e gui=bold
    hi markdownH5 guifg=#076678 gui=bold
    hi markdownH6 guifg=#8f3f71 gui=bold
    hi markdownUrl guifg=#076678 gui=underline
    hi markdownItalic guifg=NONE gui=italic
    hi markdownBold guifg=NONE gui=bold
    hi markdownItalicDelimiter guifg=#928374 gui=italic
    hi markdownCode guifg=#79740e
    hi markdownCodeBlock guifg=#427b58
    hi markdownCodeDelimiter guifg=#427b58
    hi markdownBlockquote guifg=#928374
    hi markdownListMarker guifg=#9d0006
    hi markdownOrderedListMarker guifg=#9d0006
    hi markdownRule guifg=#8f3f71
    hi markdownHeadingRule guifg=#928374
    hi markdownUrlDelimiter guifg=#928374
    hi markdownLinkDelimiter guifg=#928374
    hi markdownLinkTextDelimiter guifg=#928374
    hi markdownHeadingDelimiter guifg=#928374
    hi markdownLinkText guifg=#8f3f71
    hi markdownUrlTitleDelimiter guifg=#79740e
    hi markdownIdDeclaration guifg=#928374
    hi markdownBoldDelimiter guifg=#928374
    hi markdownId guifg=#b57614
    hi htmlH1 guifg=#9d0006 gui=bold
    hi htmlH2 guifg=#af3a03 gui=bold
    hi htmlH3 guifg=#b57614 gui=bold
    hi htmlH4 guifg=#79740e gui=bold
    hi htmlH5 guifg=#076678 gui=bold
    hi htmlH6 guifg=#8f3f71 gui=bold
    hi htmlLink guifg=NONE gui=underline
    hi htmlBold guifg=NONE gui=bold
    hi htmlBoldUnderline guifg=NONE gui=boldunderline
    hi htmlBoldItalic guifg=NONE gui=bolditalic
    hi htmlBoldUnderlineItalic guifg=NONE gui=boldunderlineitalic
    hi htmlUnderline guifg=NONE gui=underline
    hi htmlUnderlineItalic guifg=NONE gui=underlineitalic
    hi htmlItalic guifg=NONE gui=italic
    hi htmlTag guifg=#79740e
    hi htmlEndTag guifg=#076678
    hi htmlTagN guifg=#af3a03 gui=italic
    hi htmlTagName guifg=#af3a03 gui=italic
    hi htmlArg guifg=#427b58
    hi htmlScriptTag guifg=#8f3f71
    hi htmlSpecialTagName guifg=#9d0006 gui=italic
    hi helpNote guifg=#8f3f71 gui=bold
    hi helpHeadline guifg=#9d0006  gui=bold
    hi helpHeader guifg=#af3a03 gui=bold
    hi helpURL guifg=#79740e gui=underline
    hi helpHyperTextEntry guifg=#b57614 gui=bold
    hi helpHyperTextJump guifg=#b57614
    hi helpCommand guifg=#427b58
    hi helpExample guifg=#79740e
    hi helpSpecial guifg=#076678
    hi helpSectionDelim guifg=#928374
    hi pythonBuiltin guifg=#b57614
    hi pythonExceptions guifg=#8f3f71
    hi pythonDecoratorName guifg=#076678
    hi TSStrong guifg=NONE gui=bold
    hi TSEmphasis guifg=NONE gui=bold
    hi TSUnderline guifg=NONE gui=underline
    hi TSNote guifg=#f9f5d7 guibg=#076678 gui=bold
    hi TSWarning guifg=#f9f5d7 guibg=#b57614 gui=bold
    hi TSDanger guifg=#f9f5d7 guibg=#9d0006 gui=bold
    hi TSAnnotation guifg=#8f3f71
    hi TSAttribute guifg=#8f3f71
    hi TSBoolean guifg=#8f3f71
    hi TSCharacter guifg=#427b58
    hi TSComment guifg=#928374 gui=italic
    hi TSConditional guifg=#9d0006
    hi TSConstBuiltin guifg=#076678 gui=italic
    hi TSConstMacro guifg=#076678 gui=italic
    hi TSConstant guifg=#3c3836
    hi TSConstructor guifg=#3c3836
    hi TSException guifg=#9d0006
    hi TSField guifg=#79740e
    hi TSFloat guifg=#8f3f71
    hi TSFuncBuiltin guifg=#79740e gui=bold
    hi TSFuncMacro guifg=#79740e gui=bold
    hi TSFunction guifg=#79740e gui=bold
    hi TSInclude guifg=#9d0006
    hi TSKeyword guifg=#9d0006
    hi TSKeywordFunction guifg=#9d0006
    hi TSKeywordOperator guifg=#af3a03
    hi TSLabel guifg=#af3a03
    hi TSMethod guifg=#79740e gui=bold
    hi TSNamespace guifg=#b57614 gui=italic
    hi TSNone guifg=#3c3836
    hi TSNumber guifg=#8f3f71
    hi TSOperator guifg=#af3a03
    hi TSParameter guifg=#3c3836
    hi TSParameterReference guifg=#3c3836
    hi TSProperty guifg=#79740e
    hi TSPunctBracket guifg=#3c3836
    hi TSPunctDelimiter guifg=#928374
    hi TSPunctSpecial guifg=#076678
    hi TSRepeat guifg=#9d0006
    hi TSString guifg=#427b58
    hi TSStringEscape guifg=#79740e
    hi TSStringRegex guifg=#79740e
    hi TSStructure guifg=#076678 gui=italic
    hi TSSymbol guifg=#3c3836
    hi TSTag guifg=#af3a03
    hi TSTagDelimiter guifg=#79740e
    hi TSText guifg=#79740e
    hi TSStrike guifg=#928374
    hi TSMath guifg=#076678
    hi TSType guifg=#b57614
    hi TSTypeBuiltin guifg=#b57614 gui=italic
    hi TSURI guifg=#076678 gui=underline
    hi TSVariable guifg=#3c3836
    hi TSVariableBuiltin guifg=#076678 gui=italic
    hi LspDiagnosticsFloatingError guifg=#9d0006 guibg=#f2e5bc
    hi LspDiagnosticsFloatingWarning guifg=#b57614 guibg=#f2e5bc
    hi LspDiagnosticsFloatingInformation guifg=#076678 guibg=#f2e5bc
    hi LspDiagnosticsFloatingHint guifg=#79740e guibg=#f2e5bc
    hi LspDiagnosticsDefaultError guifg=NONE guibg=#f0ddc3 gui=undercurl
    hi LspDiagnosticsDefaultWarning guifg=NONE guibg=#f9eabf gui=undercurl
    hi LspDiagnosticsDefaultInformation guifg=NONE guibg=#d9e1cc gui=undercurl
    hi LspDiagnosticsDefaultHint guifg=NONE guibg=#dde5c2 gui=undercurl
    hi LspDiagnosticsVirtualTextError guifg=#9d0006
    hi LspDiagnosticsVirtualTextWarning guifg=#b57614
    hi LspDiagnosticsVirtualTextInformation guifg=#076678
    hi LspDiagnosticsVirtualTextHint guifg=#79740e
    hi LspDiagnosticsUnderlineError guifg=NONE guibg=#f0ddc3 gui=undercurl
    hi LspDiagnosticsUnderlineWarning guifg=NONE guibg=#f9eabf gui=undercurl
    hi LspDiagnosticsUnderlineInformation guifg=NONE guibg=#d9e1cc gui=undercurl
    hi LspDiagnosticsUnderlineHint guifg=#9d0006
    hi LspDiagnosticsSignError guifg=#9d0006 guibg=NONE
    hi LspDiagnosticsSignWarning guifg=#b57614 guibg=NONE
    hi LspDiagnosticsSignInformation guifg=#076678 guibg=NONE
    hi LspDiagnosticsSignHint guifg=#427b58 guibg=NONE
    hi DiagnosticError guifg=#9d0006
    hi DiagnosticWarn guifg=#b57614
    hi DiagnosticInfo guifg=#076678
    hi DiagnosticHint guifg=#79740e
    hi TelescopeMatching guifg=#79740e gui=bold
    hi TelescopeBorder guifg=#928374 guibg=NONE
    hi TelescopePromptPrefix guifg=#af3a03
    hi TelescopeSelection guifg=NONE guibg=#e4edc8
    hi IndentBlanklineContextChar guifg=#a89984
    hi IndentBlanklineChar guifg=#ebdbb2
    hi IndentBlanklineSpaceChar guifg=#ebdbb2
    hi IndentBlanklineSpaceCharBlankline guifg=#ebdbb2
else

    " ----- dark -----
    hi Normal guifg=#ebdbb2 guibg=NONE
    hi Terminal guifg=#ebdbb2 guibg=#10151a
    hi Folded guifg=#928374 guibg=#282828
    hi SignColumn guifg=#ebdbb2 guibg=NONE
    hi FoldColumn guifg=#928374 guibg=#282828
    hi IncSearch guifg=#282828 guibg=#cc241d
    hi Search guifg=#cc241d guibg=#282828
    hi ColorColumn guifg=NONE guibg=#282828
    hi Conceal guifg=#504945
    hi DiffAdd guifg=NONE guibg=#32361a
    hi DiffChange guifg=NONE guibg=#0d3138
    hi DiffDelete guifg=NONE guibg=#3c1f1e
    hi DiffText guifg=#10151a guibg=#83a598
    hi Directory guifg=#8ec07c
    hi MatchParen guifg=#cc241d guibg=#282828 gui=bold
    hi NonText guifg=#504945
    hi Whitespace guifg=#504945
    hi SpecialKey guifg=#504945
    hi Pmenu guifg=#ebdbb2 guibg=#282828
    hi PmenuSel guifg=#282828 guibg=#83a598
    hi PmenuSbar guifg=#282828 guibg=#282828
    hi PmenuThumb guifg=#83a598 guibg=#282828
    hi NormalFloat guifg=#ebdbb2 guibg=#282828
    hi Question guifg=#b8bb26
    hi SpellBad guifg=NONE gui=undercurl
    hi SpellCap guifg=NONE gui=undercurl
    hi SpellLocal guifg=NONE gui=undercurl
    hi SpellRare guifg=NONE gui=undercurl
    hi StatusLine guifg=#ebdbb2 guibg=#282828
    hi StatusLineTerm guifg=#ebdbb2 guibg=#282828
    hi StatusLineNC guifg=#928374 guibg=#282828
    hi StatusLineTermNC guifg=#928374 guibg=#282828
    hi TabLine guifg=#ebdbb2 guibg=#504945
    hi TabLineFill guifg=#ebdbb2 guibg=#282828
    hi TabLineSel guifg=#10151a guibg=#a89984
    hi VertSplit guifg=#504945
    hi Visual guibg=#10151a gui=inverse
    hi VisualNOS guibg=#10151a gui=inverse
    hi QuickFixLine guifg=#d3869b gui=bold
    hi Debug guifg=#fe8019
    hi debugPC guifg=#10151a guibg=#8ec07c
    hi debugBreakpoint guifg=#10151a guibg=#fabd2f
    hi ToolbarButton guifg=#10151a guibg=#a89984
    hi Substitute guifg=#10151a guibg=#b8bb26
    hi Boolean guifg=#d3869b
    hi Number guifg=#d3869b
    hi Float guifg=#d3869b
    hi PreProc guifg=#d3869b gui=italic
    hi PreCondit guifg=#d3869b gui=italic
    hi Include guifg=#d3869b gui=italic
    hi Define guifg=#d3869b gui=italic
    hi Conditional guifg=#fabd2f gui=italic
    hi Repeat guifg=#fabd2f gui=italic
    hi Keyword guifg=#fabd2f gui=italic
    hi Typedef guifg=#fabd2f gui=italic
    hi Exception guifg=#fabd2f gui=italic
    hi Statement guifg=#fabd2f gui=italic
    hi Error guifg=#ebdbb2 guibg=NONE
    hi StorageClass guifg=#fe8019
    hi Tag guifg=#fe8019
    hi Label guifg=#fe8019
    hi Structure guifg=#fe8019
    hi Operator guifg=#fe8019
    hi Title guifg=#fe8019 gui=bold
    hi Special guifg=#b8bb26
    hi SpecialChar guifg=#b8bb26
    hi Type guifg=#b8bb26
    hi Function guifg=#8ec07c gui=bold
    hi String guifg=#8ec07c
    hi Character guifg=#8ec07c
    hi Constant guifg=#b8bb26
    hi Macro guifg=#b8bb26
    hi Identifier guifg=#83a598 gui=italic
    hi Comment guifg=#928374 gui=italic
    hi SpecialComment guifg=#928374 gui=italic
    hi Todo guifg=#d3869b gui=italic
    hi Delimiter guifg=#ebdbb2
    hi Ignore guifg=#928374
    hi Underlined guifg=NONE gui=underline
    hi LineNr guifg=#504945
    hi CursorLineNr guifg=#83a598
    hi CursorLine guifg=NONE guibg=NONE
    hi CursorColumn guifg=NONE guibg=#282828
    hi markdownUrl guifg=#83a598 gui=underline
    hi markdownItalic guifg=NONE gui=italic
    hi markdownBold guifg=NONE gui=bold
    hi markdownItalicDelimiter guifg=#928374 gui=italic
    hi markdownCode guifg=#8ec07c
    hi markdownCodeBlock guifg=#b8bb26
    hi markdownCodeDelimiter guifg=#b8bb26
    hi markdownBlockquote guifg=#928374
    hi markdownListMarker guifg=#fabd2f
    hi markdownOrderedListMarker guifg=#fabd2f
    hi markdownRule guifg=#d3869b
    hi markdownHeadingRule guifg=#928374
    hi markdownUrlDelimiter guifg=#928374
    hi markdownLinkDelimiter guifg=#928374
    hi markdownLinkTextDelimiter guifg=#928374
    hi markdownHeadingDelimiter guifg=#928374
    hi markdownLinkText guifg=#d3869b
    hi markdownUrlTitleDelimiter guifg=#8ec07c
    hi markdownIdDeclaration guifg=#928374
    hi markdownBoldDelimiter guifg=#928374
    hi markdownId guifg=#b8bb26
    hi htmlLink guifg=NONE gui=underline
    hi htmlBold guifg=NONE gui=bold
    hi htmlBoldUnderline guifg=NONE gui=boldunderline
    hi htmlBoldItalic guifg=NONE gui=bolditalic
    hi htmlBoldUnderlineItalic guifg=NONE gui=boldunderlineitalic
    hi htmlUnderline guifg=NONE gui=underline
    hi htmlUnderlineItalic guifg=NONE gui=underlineitalic
    hi htmlItalic guifg=NONE gui=italic
    hi htmlTag guifg=#8ec07c
    hi htmlEndTag guifg=#83a598
    hi htmlTagN guifg=#fe8019 gui=italic
    hi htmlTagName guifg=#fe8019 gui=italic
    hi htmlArg guifg=#b8bb26
    hi htmlScriptTag guifg=#d3869b
    hi htmlSpecialTagName guifg=#fabd2f gui=italic
    hi helpNote guifg=#d3869b gui=bold
    hi helpHeadline guifg=#fabd2f  gui=bold
    hi helpHeader guifg=#fe8019 gui=bold
    hi helpURL guifg=#8ec07c gui=underline
    hi helpHyperTextEntry guifg=#b8bb26 gui=bold
    hi helpHyperTextJump guifg=#b8bb26
    hi helpCommand guifg=#b8bb26
    hi helpExample guifg=#8ec07c
    hi helpSpecial guifg=#83a598
    hi helpSectionDelim guifg=#928374
    hi pythonBuiltin guifg=#b8bb26
    hi pythonExceptions guifg=#d3869b
    hi pythonDecoratorName guifg=#83a598
    hi TSStrong guifg=NONE gui=bold
    hi TSEmphasis guifg=NONE gui=bold
    hi TSUnderline guifg=NONE gui=underline
    hi TSAnnotation guifg=#d3869b
    hi TSAttribute guifg=#d3869b
    hi TSBoolean guifg=#d3869b
    hi TSCharacter guifg=#b8bb26
    hi TSComment guifg=#928374 gui=italic
    hi TSConditional guifg=#fabd2f
    hi TSConstBuiltin guifg=#83a598 gui=italic
    hi TSConstMacro guifg=#83a598 gui=italic
    hi TSConstant guifg=#ebdbb2
    hi TSConstructor guifg=#ebdbb2
    hi TSException guifg=#fabd2f
    hi TSField guifg=#8ec07c
    hi TSFloat guifg=#d3869b
    hi TSFuncBuiltin guifg=#8ec07c gui=bold
    hi TSFuncMacro guifg=#8ec07c gui=bold
    hi TSFunction guifg=#8ec07c gui=bold
    hi TSInclude guifg=#fabd2f
    hi TSKeyword guifg=#fabd2f
    hi TSKeywordFunction guifg=#fabd2f
    hi TSKeywordOperator guifg=#fe8019
    hi TSLabel guifg=#fe8019
    hi TSMethod guifg=#8ec07c gui=bold
    hi TSNamespace guifg=#b8bb26 gui=italic
    hi TSNone guifg=#ebdbb2
    hi TSNumber guifg=#d3869b
    hi TSOperator guifg=#fe8019
    hi TSParameter guifg=#ebdbb2
    hi TSParameterReference guifg=#ebdbb2
    hi TSProperty guifg=#8ec07c
    hi TSPunctBracket guifg=#ebdbb2
    hi TSPunctDelimiter guifg=#928374
    hi TSPunctSpecial guifg=#83a598
    hi TSRepeat guifg=#fabd2f
    hi TSString guifg=#d3869b
    hi TSStringEscape guifg=#8ec07c
    hi TSStringRegex guifg=#8ec07c
    hi TSStructure guifg=#83a598 gui=italic
    hi TSSymbol guifg=#ebdbb2
    hi TSTag guifg=#fe8019
    hi TSTagDelimiter guifg=#8ec07c
    hi TSText guifg=#8ec07c
    hi TSStrike guifg=#928374
    hi TSMath guifg=#83a598
    hi TSType guifg=#b8bb26
    hi TSTypeBuiltin guifg=#b8bb26 gui=italic
    hi TSURI guifg=#83a598 gui=underline
    hi TSVariable guifg=#ebdbb2
    hi TSVariableBuiltin guifg=#83a598 gui=italic
    hi TSNote guifg=#10151a guibg=#83a598 gui=bold
    hi TSWarning guifg=#10151a guibg=#fabd2f gui=bold
    hi TSDanger guifg=#10151a guibg=#fb4934 gui=bold
    hi IndentBlanklineContextChar guifg=#7c6f64
    hi IndentBlanklineChar guifg=#504945
    hi IndentBlanklineSpaceChar guifg=#504945
    hi IndentBlanklineSpaceCharBlankline guifg=#504945
    hi TelescopeMatching guifg=#b8bb26 gui=bold
    hi TelescopeBorder guifg=#928374 guibg=NONE
    hi TelescopePromptPrefix guifg=#fe8019
    hi TelescopeSelection guifg=NONE guibg=#32361a
    hi LspDiagnosticsFloatingError guifg=#fb4934 guibg=#3c3836
    hi LspDiagnosticsFloatingWarning guifg=#fabd2f guibg=#3c3836
    hi LspDiagnosticsFloatingInformation guifg=#83a598 guibg=#3c3836
    hi LspDiagnosticsFloatingHint guifg=#b8bb26 guibg=#3c3836
    hi LspDiagnosticsDefaultError guifg=NONE guibg=#442e2d gui=undercurl
    hi LspDiagnosticsDefaultWarning guifg=NONE guibg=#473c29 gui=undercurl
    hi LspDiagnosticsDefaultInformation guifg=NONE guibg=#2e3b3b gui=undercurl
    hi LspDiagnosticsDefaultHint guifg=NONE guibg=#333e34 gui=undercurl
    hi LspDiagnosticsVirtualTextError guifg=#fb4934
    hi LspDiagnosticsVirtualTextWarning guifg=#fabd2f
    hi LspDiagnosticsVirtualTextInformation guifg=#83a598
    hi LspDiagnosticsVirtualTextHint guifg=#b8bb26
    hi LspDiagnosticsUnderlineError guifg=NONE guibg=#442e2d gui=undercurl
    hi LspDiagnosticsUnderlineWarning guifg=NONE guibg=#473c29 gui=undercurl
    hi LspDiagnosticsUnderlineInformation guifg=NONE guibg=#2e3b3b gui=undercurl
    hi LspDiagnosticsUnderlineHint guifg=#fb4934
    hi LspDiagnosticsSignError guifg=#fb4934 guibg=NONE
    hi LspDiagnosticsSignWarning guifg=#fabd2f guibg=NONE
    hi LspDiagnosticsSignInformation guifg=#83a598 guibg=NONE
    hi LspDiagnosticsSignHint guifg=#8ec07c guibg=NONE
    hi DiagnosticError guifg=#fb4934
    hi DiagnosticWarn guifg=#fabd2f
    hi DiagnosticInfo guifg=#83a598
    hi DiagnosticHint guifg=#b8bb26
    hi ErrorMsg guifg=#fb4934 guibg=NONE gui=boldunderline
    hi WarningMsg guifg=#fabd2f guibg=NONE gui=bold
    hi ModeMsg guifg=#ebdbb2 guibg=NONE gui=bold
    hi MoreMsg guifg=#fabd2f guibg=NONE gui=bold
    hi ErrorText guifg=NONE guibg=#442e2d gui=undercurl
    hi WarningText guifg=NONE guibg=#473c29 gui=undercurl
    hi InfoText guifg=NONE guibg=#2e3b3b gui=undercurl
    hi HintText guifg=#fb4934
    hi ErrorLine guifg=NONE guibg=#442e2d
    hi WarningLine guifg=NONE guibg=#473c29
    hi InfoLine guifg=NONE guibg=#2e3b3b
    hi HintLine guifg=NONE guibg=#333e34
    hi ErrorFloat guifg=#fb4934 guibg=#3c3836
    hi WarningFloat guifg=#fabd2f guibg=#3c3836
    hi InfoFloat guifg=#83a598 guibg=#3c3836
    hi HintFloat guifg=#b8bb26 guibg=#3c3836
    hi healthError guifg=#fb4934
    hi healthSuccess guifg=#b8bb26
    hi healthWarning guifg=#fabd2f
    hi markdownH1 guifg=#fb4934 gui=bold
    hi markdownH2 guifg=#fe8019 gui=bold
    hi markdownH3 guifg=#fabd2f gui=bold
    hi markdownH4 guifg=#b8bb26 gui=bold
    hi markdownH5 guifg=#83a598 gui=bold
    hi markdownH6 guifg=#d3869b gui=bold
endif
