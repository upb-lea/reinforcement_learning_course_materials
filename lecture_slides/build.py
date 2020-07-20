import os
import fileinput
from tqdm import tqdm
from subprocess import call

os.makedirs('built', exist_ok=True)
call_pdflatex_l = ['pdflatex', '-synctex=1',
                   '-interaction=nonstopmode', 'main.tex']

# build main pdf
with fileinput.input('main.tex', inplace=True) as f:
    for line in f:
        if 'includeonly{' in line:
            # comment out includeonly flag
            print(f'%{line}', end='')
        else:
            print(line, end='')
call(call_pdflatex_l)
os.replace('main.pdf', os.path.join('built', 'main.pdf'))

# build single chapters
chap_list = [os.path.splitext(p)[0] for p in os.listdir('tex')
             if p.endswith('.tex')]
for tex_file in tqdm(chap_list):
    with fileinput.input('main.tex', inplace=True) as f:
        for line in f:
            if 'includeonly{' in line:
                # specify chapter to render
                print(f'\\includeonly{{tex/{tex_file}}}')
            else:
                print(line, end='')
    call(call_pdflatex_l)
    os.replace('main.pdf', os.path.join('built', tex_file + '.pdf'))
