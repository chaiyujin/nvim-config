from typing import Optional, Dict

import os
import json
from omegaconf import DictConfig


HEADER = """
hi clear
if exists('syntax_on')
  syntax reset
endif
let g:colors_name='{}'
set background={}

"""

# palette
# #FF9AC1

colors = DictConfig(dict(
    fg='#E6E6E6',
    bg='#292A2B',
    string=dict(fg='#19f9d8', bg=None),
    regexp=dict(fg='#6FC1FF', bg=None),
    constant=dict(fg='#FFCC95', bg=None),
    keyword=dict(fg='#FF75B5', bg=None),
    variable=dict(fg='#E6E6E6', bg=None),
    parameter=dict(fg='#BBBBBB', bg=None),
    operator=dict(fg='#E6E6E6', bg=None),
    storage=dict(fg='#FFCC95', bg=None),
    error=dict(fg='#FF4B82', bg=None),
    function=dict(fg='#B5EBC8', bg=None),
    method=dict(fg='#6FC1FF', bg=None),
    field=dict(fg='#E6E6E6', bg=None), 
    property=dict(fg='#E6E6E6', bg=None),
    tag=dict(fg='#7DC1FF', bg=None),
    special=dict(fg='#FF9AC1', bg=None),
))


def dump_vim(dst_vim, lines, background, theme_name):
    # Align names
    columns_max_size = [
        max([
            len(x.split()[i]) for x in lines
        ]) 
        for i in range(len(lines[0].split()))  # all same columns
    ]
    
    # Dump
    with open(dst_vim, "w") as fp:
        fp.write(HEADER.format(theme_name, background))
        for line in lines:
            x_list = [
                x + " " * (columns_max_size[i] - len(x))
                for i, x in enumerate(line.split())
            ]
            x = " ".join(x_list)
            fp.write(f"{x}\n")


def convert(dst_vim):
    lines = []

    def _highlight_from_color(name, *args):
        assert 1 <= len(args) <= 3

        fg = "NONE"
        bg = "NONE"
        cfg = "NONE"
        cbg = "NONE"
        style = "NONE"

        if len(args) == 1:
            if isinstance(args[0], str):
                fg = str(args[0]).upper()
            else:
                assert isinstance(args[0], DictConfig)
                fg = str(args[0].fg).upper()
                bg = str(args[0].bg).upper()
                style = str(args[0].get('style')).upper()

        elif len(args) == 2:
            fg = str(args[0]).upper()
            bg = str(args[1]).upper()
        elif len(args) == 3:
            fg = str(args[0]).upper()
            bg = str(args[1]).upper()
            style = str(args[2])

        line = (
            f"hi {name} "
            f"guifg={fg:7} ctermfg={cfg:7} "
            f"guibg={bg:7} ctermbg={cbg:7} "
            f"gui={style} cterm={style}"
        )
        lines.append(line)

    # * Normal
    _highlight_from_color('Normal',         colors.fg, colors.bg)
    _highlight_from_color('Cursor',         colors.fg, '#FF4B82')
    _highlight_from_color('CursorLine',     None, '#31353a')
    _highlight_from_color('CursorLineNr',   '#757575', '#31353a')
    _highlight_from_color('MatchParen',     colors.fg, '#FF4B82')
    _highlight_from_color('LineNr',         '#757575', colors.bg)
    _highlight_from_color('Visual',         None, '#42404c')
    _highlight_from_color('Search',         None, '#62679A')
    _highlight_from_color('IncSearch',      None, '#62679A')
    _highlight_from_color('SignColumn',     colors.fg, colors.bg)
    _highlight_from_color('VertSplit',      colors.bg, None)
    _highlight_from_color('NonText',        colors.bg, None)
    _highlight_from_color('Pmenu',          '#CFD0D5', '#333435')
    _highlight_from_color('PmenuSel',       '#232425', '#7dc1ff')
    _highlight_from_color('PmenuSbar',      None, '#3b4048')
    _highlight_from_color('PmenuThumb',     None, '#abb2bf')
    _highlight_from_color('StatusLine',     '#e6e6e6', '#232425', 'bold')
    _highlight_from_color('StatusLineNC',   '#e6e6e6', '#232425')
    _highlight_from_color('MsgArea',        None, '#232425')

    # * Comment
    _highlight_from_color('Comment', '#676B79', None, 'italic')

    # * Constant
    _highlight_from_color('Constant' , colors.constant)  # any constant
    _highlight_from_color('Number'   , colors.constant)  # a number constant: 234, 0xff
    _highlight_from_color('Boolean'  , colors.constant)  # a boolean constant: TRUE, false
    _highlight_from_color('Float'    , colors.constant)  # a floating point constant: 2.3e10
    _highlight_from_color('String'   , colors.string)  # a string constant: "this is a string"
    _highlight_from_color('Character', colors.string)  # a character constant: 'c', '\n'

    # * Variable
    _highlight_from_color('Identifier', colors.variable)  # any variable name

    # * Function
    _highlight_from_color('Function', colors.function)

    # * Keyword
    _highlight_from_color('Statement'  , colors.keyword)    # any statement
    _highlight_from_color('Conditional', colors.keyword)    # if, then, else, endif, switch, etc.
    _highlight_from_color('Repeat'     , colors.keyword)    # for, do, while, etc.
    _highlight_from_color('Label'      , colors.keyword)    # case, default, etc.
    _highlight_from_color('Keyword'    , colors.keyword)    # any other keyword
    _highlight_from_color('Exception'  , colors.keyword)    # try, catch, throw
    _highlight_from_color('Operator'   , colors.operator)  # "sizeof", "+", "*", etc.

    # * PreProc
    _highlight_from_color('PreProc'  , colors.keyword)    # generic Preprocessor
    _highlight_from_color('Include'  , colors.keyword)    # preprocessor #include
    _highlight_from_color('Define'   , colors.keyword)    # preprocessor #define
    _highlight_from_color('Macro'    , colors.keyword)    # same as Define
    _highlight_from_color('PreCondit', colors.keyword)    # preprocessor #if, #else, #endif, etc.

    # * Type
    _highlight_from_color('Type'        , colors.storage)    # int, long, char, etc.
    _highlight_from_color('StorageClass', colors.storage)    # static, register, volatile, etc.
    _highlight_from_color('Structure'   , colors.storage)    # struct, union, enum, etc.
    _highlight_from_color('Typedef'     , colors.keyword)    # A typedef

    _highlight_from_color('Tag', colors.tag)        # you can use CTRL-] on this
    # _highlight_from_token('Special', 'keyword.other.special-method')    # any special symbol #45A9F9
    # _highlight_from_token('Delimiter', )    # character that needs attention
    # _highlight_from_token('SpecialComment', )    # special things inside a comment
    # _highlight_from_token('Debug', )        # debugging statements

    _highlight_from_color('Error', colors.error)

    # * TS and LSP
    _highlight_from_color('TSParameter'  , colors.parameter)
    _highlight_from_color('TSStringRegex', colors.regexp)
    _highlight_from_color('TSString'     , colors.string)
    _highlight_from_color('TSStringEscape', colors.storage)
    _highlight_from_color('TSCharacter'  , colors.string)
    _highlight_from_color('TSVariable',  colors.variable)
    _highlight_from_color('TSVariableBuiltin', colors.variable.fg, colors.variable.bg, 'italic')
    _highlight_from_color('TSConstBuiltin', colors.storage)
    _highlight_from_color('TSConstructor', colors.storage)
    _highlight_from_color('TSType'       , colors.storage)
    _highlight_from_color('TSNamespace'  , colors.keyword)
    _highlight_from_color('TSMethod'     , colors.method)
    _highlight_from_color('TSFunction'   , colors.function)
    _highlight_from_color('TSFuncBuiltin', colors.function)
    _highlight_from_color('TSPunctBracket', colors.fg, None)
    _highlight_from_color('TSPunctDelimiter', colors.fg, None)
    _highlight_from_color('TSField'      , colors.field)
    _highlight_from_color('TSProperty'   , colors.property)
    _highlight_from_color('TSError'      , colors.error)
    _highlight_from_color('TSTag'        , colors.tag)
    _highlight_from_color('TSPunctSpecial', colors.special)

    _highlight_from_color('LspDiagnosticsUnderlineHint'         , '#676B79', None, 'italic')
    _highlight_from_color('LspDiagnosticsSignError'             , '#FF4B82', None)
    _highlight_from_color('LspDiagnosticsSignWarning'           , '#FFCC95', None)
    _highlight_from_color('LspDiagnosticsSignInformation'       , '#676B79', None, 'italic')
    _highlight_from_color('LspDiagnosticsSignHint'              , '#676B79', None, 'italic')
    _highlight_from_color('LspDiagnosticsVirtualTextError'      , '#FF4B82', None)
    _highlight_from_color('LspDiagnosticsVirtualTextWarning'    , '#FFCC95', None)
    _highlight_from_color('LspDiagnosticsVirtualTextInformation', '#676B79', None, 'italic')
    _highlight_from_color('LspDiagnosticsVirtualTextHint'       , '#676B79', None, 'italic')

    # * NvimTree
    _highlight_from_color('NvimTreeNormal' ,    None, "#232425")
    _highlight_from_color('NvimTreeImageFile' , "#b084eb", None)
    _highlight_from_color('NvimTreeGitDirty'  , "#81b88b", None)
    _highlight_from_color('NvimTreeGitDeleted', "#81b88b", None)
    _highlight_from_color('NvimTreeGitStaged' , "#81b88b", None)
    _highlight_from_color('NvimTreeGitMerge'  , "#81b88b", None)
    _highlight_from_color('NvimTreeGitRenamed', "#81b88b", None)
    _highlight_from_color('NvimTreeGitNew'    , "#81b88b", None)
    _highlight_from_color('NvimTreeSymlink'   , "#29b8d8", None)
    _highlight_from_color('NvimTreeRootFolder', "#FFCC95", None, "bold")

    # * GitSigns
    _highlight_from_color('GitSignsAdd'   , "#19f9d8", None)
    _highlight_from_color('GitSignsChange', "#FFCC95", None)
    _highlight_from_color('GitSignsDelete', "#FF4B82", None)

    # * Floaterm
    _highlight_from_color('Floaterm', None, '#232425')
    _highlight_from_color('FloatermNC', None, '#232425')
    # _highlight_from_color('FloatermBorder', '#19f9d8', '#19f9d8')

    if len(lines) == 0:
        print("Failed to convert!")
        return

    # Dump
    dump_vim(dst_vim, lines, background='dark', theme_name='panda-syntax')


convert('panda-syntax.vim')
