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
        for token_color in vsc['tokenColors']:
            if scope in [x.strip() for x in token_color['scope'].split(',')]:
                return token_color["settings"]
        return None


    def _highlight_from_token(name, token_color):
        if isinstance(token_color, str):
            token_color = _find_token_color(token_color)
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

    def _highlight_from_color(name, fg_key, bg_key):
        fg = vsc['colors'].get(fg_key, 'None').upper() if fg_key is not None else 'NONE'
        bg = vsc['colors'].get(bg_key, 'None').upper() if bg_key is not None else 'NONE'
        cfg = 'NONE'
        cbg = 'NONE'

        line = (
            f"hi {name} "
            f"guifg={fg:7} ctermfg={cfg:7} "
            f"guibg={bg:7} ctermbg={cbg:7} "
            f"gui=NONE cterm=NONE"
        )
        lines.append(line)

    # Convert

    _highlight_from_color('Normal', 'editor.foreground', 'editor.background')
    _highlight_from_token('Comment', 'comment')

    if len(lines) == 0:
        print("Failed to convert!")
        return

    # Dump
    dump_vim(dst_vim, lines, background='dark', theme_name='panda')


convert('Panda.json', 'panda-syntax.vim')

