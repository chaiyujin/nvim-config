from typing import Optional, Dict

import os
import json


HEADER = """
hi clear
if exists('syntax_on')
  syntax reset
endif
let g:colors_name='{}'
set background={}

"""


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

    def _find_token_color(scope) -> Optional[Dict[str, str]]:
        if isinstance(scope, str):
            scope = [scope]
        # check each candidates
        for scp in scope:
            for token_color in vsc['tokenColors']:
                if scp in [x.strip() for x in token_color['scope'].split(',')]:
                    return token_color["settings"]
        return None

    def _highlight_from_token(name, scope):
        token_color = _find_token_color(scope)
        if token_color is None:
            print(f"Failed to convert into '{name}'")
            return
        fg = token_color.get('foreground', 'None').upper()
        bg = token_color.get('background', 'None').upper()
        fs = token_color.get('fontStyle',  'NONE')
        if fs == 'normal':
            fs = 'NONE'

        cfg = 'NONE'
        cbg = 'NONE'

        line = (
            f"hi {name} "
            f"guifg={fg:7} ctermfg={cfg:7} "
            f"guibg={bg:7} ctermbg={cbg:7} "
            f"gui={fs} cterm={fs}"
        )
        lines.append(line)

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
    _highlight_from_color('Normal',         'editor.foreground', 'editor.background')
    _highlight_from_color('Cursor',         'editor.foreground', 'editorCursor.foreground')
    _highlight_from_color('CursorLine',     None, 'editor.lineHighlightBackground')
    _highlight_from_color('CursorLineNr',   '#757575', 'editor.lineHighlightBackground')
    _highlight_from_color('LineNr',         '#757575', 'editor.background')
    _highlight_from_color('Visual',         None, 'editor.selectionBackground')
    _highlight_from_color('MatchParen',     'editor.foreground', 'editorCursor.foreground')
    _highlight_from_color('Search',         None, 'editor.wordHighlightBackground')
    _highlight_from_color('IncSearch',      None, 'editor.wordHighlightBackground')
    _highlight_from_color('SignColumn',     'editorCursor.foreground', 'editorCursor.background')
    _highlight_from_color('VertSplit',      'sideBar.border', None)
    _highlight_from_color('NonText',        'editor.background', None)

    # * Comment
    _highlight_from_token('Comment', 'comment')

    # * Constant
    _highlight_from_token('Constant', 'constant')  # any constant
    _highlight_from_token('String',  'string')  # a string constant: "this is a string"
    _highlight_from_token('Character', 'string')  # a character constant: 'c', '\n'
    _highlight_from_token('Number', 'constant')  # a number constant: 234, 0xff
    _highlight_from_token('Boolean', 'constant')  # a boolean constant: TRUE, false
    _highlight_from_token('Float', 'constant')  # a floating point constant: 2.3e10

    # * Variable
    _highlight_from_token('Identifier', 'variable')  # any variable name

    # * Function
    _highlight_from_token('Function', ['support.function', 'entity.name.function'])

    # * Keyword
    _highlight_from_token('Statement', 'keyword')    # any statement
    _highlight_from_token('Conditional', 'keyword.control')    # if, then, else, endif, switch, etc.
    _highlight_from_token('Repeat', 'keyword.control')        # for, do, while, etc.
    _highlight_from_token('Label', 'keyword.control')        # case, default, etc.
    _highlight_from_token('Operator', 'keyword.operator')    # "sizeof", "+", "*", etc.
    _highlight_from_token('Keyword', 'keyword')    # any other keyword
    _highlight_from_token('Exception', 'keyword.control')    # try, catch, throw

    # * PreProc
    _highlight_from_token('PreProc', 'keyword.control')    # generic Preprocessor
    _highlight_from_token('Include', 'keyword.control')    # preprocessor #include
    _highlight_from_token('Define', 'keyword.control')        # preprocessor #define
    _highlight_from_token('Macro', 'keyword.control')        # same as Define
    _highlight_from_token('PreCondit', 'keyword.control')    # preprocessor #if, #else, #endif, etc.

    # * Type
    _highlight_from_token('Type', 'storage')        # int, long, char, etc.
    _highlight_from_token('StorageClass', 'storage')    # static, register, volatile, etc.
    _highlight_from_token('Structure', 'storage')    # struct, union, enum, etc.
    _highlight_from_token('Typedef', 'keyword')    # A typedef

    _highlight_from_token('Special', 'keyword.other.special-method')    # any special symbol
    _highlight_from_color('Tag', '#7DC1FF', None)        # you can use CTRL-] on this
    # _highlight_from_token('Delimiter', )    # character that needs attention
    # _highlight_from_token('SpecialComment', )    # special things inside a comment
    # _highlight_from_token('Debug', )        # debugging statements

    _highlight_from_color('Error', 'editorError.foreground', None)

    # * TS and LSP
    _highlight_from_token('TSParameter', 'variable.parameter')
    _highlight_from_token('TSStringRegex', 'string.regexp')
    _highlight_from_token('TSString', 'string')
    _highlight_from_token('TSCharacter', 'string')
    _highlight_from_token('TSNamespace', 'keyword')
    _highlight_from_token('TSMethod', ['support.function', 'entity.name.function'])
    _highlight_from_token('TSField', 'variable.other.object')
    _highlight_from_token('TSProperty', 'variable.other.property')

    _highlight_from_color('TSError',     'editorError.foreground', None)
    _highlight_from_color('TSTag',       '#7DC1FF', None)

    _highlight_from_token('LspDiagnosticsUnderlineHint', 'comment')
    _highlight_from_color('LspDiagnosticsSignError', 'editorError.foreground', None)
    _highlight_from_color('LspDiagnosticsSignWarning', 'editorWarning.foreground', None)
    _highlight_from_token('LspDiagnosticsSignInformation', 'comment')
    _highlight_from_token('LspDiagnosticsSignHint', 'comment')
    _highlight_from_color('LspDiagnosticsVirtualTextError', 'editorError.foreground', None)
    _highlight_from_color('LspDiagnosticsVirtualTextWarning', 'editorWarning.foreground', None)
    _highlight_from_token('LspDiagnosticsVirtualTextInformation', 'comment')
    _highlight_from_token('LspDiagnosticsVirtualTextHint', 'comment')

    # * NvimTree
    _highlight_from_color('NvimTreeImageFile', '#b084eb', None)
    _highlight_from_color('NvimTreeGitDirty', '#81b88b', None)
    _highlight_from_color('NvimTreeGitDeleted', '#81b88b', None)
    _highlight_from_color('NvimTreeGitStaged', '#81b88b', None)
    _highlight_from_color('NvimTreeGitMerge', '#81b88b', None)
    _highlight_from_color('NvimTreeGitRenamed', '#81b88b', None)
    _highlight_from_color('NvimTreeGitNew', '#81b88b', None)
    _highlight_from_color('NvimTreeSymlink', '#29b8d8', None)
    _highlight_from_color('NvimTreeRootFolder', '#BBBBBB', '#757575')

    if len(lines) == 0:
        print("Failed to convert!")
        return

    # Dump
    dump_vim(dst_vim, lines, background='dark', theme_name='panda-syntax')


convert('Panda.json', 'panda-syntax.vim')
