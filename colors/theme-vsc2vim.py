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


def convert(src_json, dst_vim):
    # Load and check keys
    with open(src_json) as fp:
        vsc = json.load(fp)
    # - check keys
    assert 'colors' in vsc, "Failed to find 'colors' in {}".format(src_json)
    assert 'tokenColors' in vsc, "Failed to find 'tokenColors' in {}".format(src_json)

    lines = []

    def _highlight_from_color(name, fg_key, bg_key, dec='NONE'):
        fg, bg = 'NONE', 'NONE'
        if fg_key is not None:
            fg = vsc['colors'].get(fg_key, 'NONE').upper() if not fg_key.startswith('#') else fg_key.upper()
        if bg_key is not None:
            bg = vsc['colors'].get(bg_key, 'None').upper() if not bg_key.startswith('#') else bg_key.upper()

        if len(fg) > 7:
            fg = fg[:7]
        if len(bg) > 7:
            bg = bg[:7]
        cfg = 'NONE'
        cbg = 'NONE'

        line = (
            f"hi {name} "
            f"guifg={fg:7} ctermfg={cfg:7} "
            f"guibg={bg:7} ctermbg={cbg:7} "
            f"gui={dec} cterm={dec}"
        )
        lines.append(line)

    # TODO: todo test

    # * Normal
    _highlight_from_color('Normal',         colors.fg, colors.bg)
    _highlight_from_color('Cursor',         colors.fg, '#FF4B82')
    _highlight_from_color('CursorLine',     None, '#31353a')
    _highlight_from_color('CursorLineNr',   '#757575', '#31353a')
    _highlight_from_color('MatchParen',     colors.fg, '#FF4B82')
    _highlight_from_color('LineNr',         '#757575', colors.bg)
    _highlight_from_color('Visual',         None, '#42404c')
    _highlight_from_color('Search',         None, '#FFCC95')
    _highlight_from_color('IncSearch',      None, '#FFCC95')
    _highlight_from_color('SignColumn',     colors.fg, colors.bg)
    _highlight_from_color('VertSplit',      colors.bg, None)
    _highlight_from_color('NonText',        colors.bg, None)
    _highlight_from_color('Pmenu',          '#CFD0D5', '#333435')
    _highlight_from_color('PmenuSel',       '#232425', '#7dc1ff')
    _highlight_from_color('PmenuSbar',      None, '#3b4048')
    _highlight_from_color('PmenuThumb',     None, '#abb2bf')
    _highlight_from_color('StatusLine',     '#e6e6e6', '#232425', 'bold')
    _highlight_from_color('StatusLineNC',   '#e6e6e6', '#232425')

    # * Comment
    _highlight_from_color('Comment', '#676B79', None, 'italic')

    # * Constant
    _highlight_from_color('Constant' , colors.constant.fg, colors.constant.bg)  # any constant
    _highlight_from_color('Number'   , colors.constant.fg, colors.constant.bg)  # a number constant: 234, 0xff
    _highlight_from_color('Boolean'  , colors.constant.fg, colors.constant.bg)  # a boolean constant: TRUE, false
    _highlight_from_color('Float'    , colors.constant.fg, colors.constant.bg)  # a floating point constant: 2.3e10
    _highlight_from_color('String'   , colors.string.fg, colors.string.bg)  # a string constant: "this is a string"
    _highlight_from_color('Character', colors.string.fg, colors.string.bg)  # a character constant: 'c', '\n'

    # * Variable
    _highlight_from_color('Identifier', colors.variable.fg, colors.variable.bg)  # any variable name

    # * Function
    _highlight_from_color('Function', colors.function.fg, colors.function.bg)

    # * Keyword
    _highlight_from_color('Statement'  , colors.keyword.fg, colors.keyword.bg)    # any statement
    _highlight_from_color('Conditional', colors.keyword.fg, colors.keyword.bg)    # if, then, else, endif, switch, etc.
    _highlight_from_color('Repeat'     , colors.keyword.fg, colors.keyword.bg)    # for, do, while, etc.
    _highlight_from_color('Label'      , colors.keyword.fg, colors.keyword.bg)    # case, default, etc.
    _highlight_from_color('Keyword'    , colors.keyword.fg, colors.keyword.bg)    # any other keyword
    _highlight_from_color('Exception'  , colors.keyword.fg, colors.keyword.bg)    # try, catch, throw
    _highlight_from_color('Operator'   , colors.operator.fg, colors.operator.bg)  # "sizeof", "+", "*", etc.

    # * PreProc
    _highlight_from_color('PreProc'  , colors.keyword.fg, colors.keyword.bg)    # generic Preprocessor
    _highlight_from_color('Include'  , colors.keyword.fg, colors.keyword.bg)    # preprocessor #include
    _highlight_from_color('Define'   , colors.keyword.fg, colors.keyword.bg)    # preprocessor #define
    _highlight_from_color('Macro'    , colors.keyword.fg, colors.keyword.bg)    # same as Define
    _highlight_from_color('PreCondit', colors.keyword.fg, colors.keyword.bg)    # preprocessor #if, #else, #endif, etc.

    # * Type
    _highlight_from_color('Type'        , colors.storage.fg, colors.storage.bg)    # int, long, char, etc.
    _highlight_from_color('StorageClass', colors.storage.fg, colors.storage.bg)    # static, register, volatile, etc.
    _highlight_from_color('Structure'   , colors.storage.fg, colors.storage.bg)    # struct, union, enum, etc.
    _highlight_from_color('Typedef'     , colors.keyword.fg, colors.keyword.bg)    # A typedef

    _highlight_from_color('Tag', colors.tag.fg, colors.tag.bg)        # you can use CTRL-] on this
    # _highlight_from_token('Special', 'keyword.other.special-method')    # any special symbol #45A9F9
    # _highlight_from_token('Delimiter', )    # character that needs attention
    # _highlight_from_token('SpecialComment', )    # special things inside a comment
    # _highlight_from_token('Debug', )        # debugging statements

    _highlight_from_color('Error', colors.error.fg, colors.error.bg)

    # * TS and LSP
    _highlight_from_color('TSParameter'  , colors.parameter.fg, colors.parameter.bg)
    _highlight_from_color('TSStringRegex', colors.regexp.fg, colors.regexp.bg)
    _highlight_from_color('TSString'     , colors.string.fg, colors.string.bg)
    _highlight_from_color('TSStringEscape', colors.storage.fg, colors.storage.bg)
    _highlight_from_color('TSCharacter'  , colors.string.fg, colors.string.bg)
    _highlight_from_color('TSConstBuiltin', colors.storage.fg, colors.storage.bg)
    _highlight_from_color('TSConstructor', colors.storage.fg, colors.storage.bg)
    _highlight_from_color('TSType'       , colors.storage.fg, colors.storage.bg)
    _highlight_from_color('TSNamespace'  , colors.keyword.fg, colors.keyword.bg)
    _highlight_from_color('TSMethod'     , colors.method.fg, colors.method.bg)
    _highlight_from_color('TSFunction'   , colors.function.fg, colors.function.bg)
    _highlight_from_color('TSFuncBuiltin', colors.function.fg, colors.function.bg)
    _highlight_from_color('TSPunctBracket', colors.fg, None)
    _highlight_from_color('TSPunctDelimiter', colors.fg, None)
    _highlight_from_color('TSField'      , colors.field.fg, colors.field.bg)
    _highlight_from_color('TSProperty'   , colors.property.fg, colors.property.bg)
    _highlight_from_color('TSError'      , colors.error.fg, colors.error.bg)
    _highlight_from_color('TSTag'        , colors.tag.fg, colors.tag.bg)
    _highlight_from_color('TSPunctSpecial', colors.special.fg, colors.special.bg)

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


convert('Panda.json', 'panda-syntax.vim')
