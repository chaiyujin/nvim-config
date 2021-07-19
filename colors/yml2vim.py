import os
import argparse
from omegaconf import DictConfig, OmegaConf

HEADER = """hi clear
if exists('syntax_on')
  syntax reset
endif
let g:colors_name='{}'
set background={}

"""

def _hex_to_int(hex):
    if hex[0] == '#':
        hex = hex[1:]
    return int(hex, 16)


def _int_to_hex(value):
    return f'{value:X}'


def _get_color(color):
    if color.find('-') >= 0:
        c0, c1 = color.split('-')
        c = _hex_to_int(c0) - _hex_to_int(c1)
        color = '#' + _int_to_hex(c)
    elif color.find('+') >= 0:
        c0, c1 = color.split('+')
        c = _hex_to_int(c0) + _hex_to_int(c1)
        color = '#' + _int_to_hex(c)
    elif color.find('*') >= 0:
        c, factor = color.split('*')
        factor = float(factor)
        r, g, b = _hex_to_int(c[1:3]), _hex_to_int(c[3:5]), _hex_to_int(c[5:7])
        r = min(int(r * factor), 255)
        g = min(int(g * factor), 255)
        b = min(int(b * factor), 255)
        color = '#' + _int_to_hex(r) + _int_to_hex(g) + _int_to_hex(b)

    color = color.upper()
    assert color == 'NONE' or (color[0] == '#' and len(color) == 7)
    return color


def yaml_to_vim(source_yaml, target_vim):
    theme: DictConfig = OmegaConf.load(source_yaml)
    max_len_key = max(len(x) for x in theme.highlights)
    max_len_style = max(len(str(group.get('style', 'NONE')).upper()) for _, group in theme.highlights.items())

    lines = []
    for key, group in theme.highlights.items():
        fg = _get_color(group.get('fg', 'NONE'))
        bg = _get_color(group.get('bg', 'NONE'))
        style = str(group.get('style', 'NONE')).upper()
        key = key.ljust(max_len_key)
        style = style.ljust(max_len_style)
        line = f"hi {key} guifg={fg:7} guibg={bg:7} gui={style}"
        lines.append(line)

    os.makedirs(os.path.dirname(os.path.abspath(target_vim)), exist_ok=True)
    with open(target_vim, 'w') as fp:
        if theme.info.get('message') is not None:
            fp.write('\" ' + theme.info.message + '\n')
        fp.write(HEADER.format(theme.info.name, theme.info.background))
        for line in lines:
            fp.write(line + '\n')
    print("The colorscheme has been written into: '{}'".format(target_vim))


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('-I', '--input_yaml', required=True)
    parser.add_argument('-O', '--output_vim', required=True)
    args = parser.parse_args()

    yaml_to_vim(args.input_yaml, args.output_vim)

