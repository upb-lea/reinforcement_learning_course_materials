import os
import fileinput
from subprocess import call

os.makedirs('built', exist_ok=True)
call_pdflatex_l = ['pdflatex', '-synctex=1',
                   '-interaction=nonstopmode', 'main.tex']


def clear_tex_binaries():
    # clean misc files
    for file in os.listdir('.'):
        if file.startswith('main'):
            if not file.endswith(('.tex', '.pdf')):
                os.remove(file)


# build main pdf
clear_tex_binaries()
with fileinput.input('main.tex', inplace=True) as f:
    for line in f:
        if 'includeonly{' in line:
            # comment out includeonly flag
            print(f'%{line}', end='')
        else:
            print(line, end='')
call(call_pdflatex_l)
call(call_pdflatex_l)
os.replace('main.pdf', os.path.join('built', 'main.pdf'))

# build single chapters
chap_list = [os.path.splitext(p)[0] for p in os.listdir('tex')
             if p.endswith('.tex')]

for tex_file in chap_list:
    clear_tex_binaries()
    with fileinput.input('main.tex', inplace=True) as f:
        for line in f:
            if 'includeonly{' in line:
                # specify chapter to render
                print(f'\\includeonly{{tex/{tex_file}}}')
            else:
                print(line, end='')
    call(call_pdflatex_l)
    call(call_pdflatex_l)
    call(call_pdflatex_l)
    os.replace('main.pdf', os.path.join('built', tex_file + '.pdf'))

print('Done processing:')
for p in chap_list:
    print('  ', p)
