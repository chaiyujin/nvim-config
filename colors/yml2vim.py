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


def yaml_to_vim(source_yaml, target_vim):
    theme: DictConfig = OmegaConf.load(source_yaml)
    max_len_key = max(len(x) for x in theme.highlights)
    max_len_style = max(len(str(group.get('style', 'NONE')).upper()) for _, group in theme.highlights.items())

    lines = []
    for key, group in theme.highlights.items():
        fg = str(group.get('fg', 'NONE')).upper()
        bg = str(group.get('bg', 'NONE')).upper()
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

