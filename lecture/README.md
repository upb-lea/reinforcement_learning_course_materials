# Lecture Slides

This folder contains the source files for the lecture slides of the Reinforcement Learning course.  
The slides are written in LaTeX and can be built either via the provided Python build script or directly using LaTeX.

---

## Folder Structure

- `main.tex` — entry point of the lecture slides.
- `build.py` — build script that compiles the slides and manages intermediate files.
- `fig/` — figures used in the slides.  
  Each subfolder corresponds to a chapter.
- `tex/` — individual `.tex` files for each chapter/section of the course.

---

## Building the Slides

There are two ways to build the slides:

### 1. Using the build script (recommended)

The easiest way is to use the Python build script:

```bash
python build.py
```

This will:
- Compile `main.tex`
- Create a `built/` folder
- Place the output `lecture.pdf` in `built/`
- Clean up all intermediate/binary files automatically

### 2. Compiling directly with LaTeX

Alternatively, you can compile `main.tex` directly using your LaTeX distribution (e.g., `pdflatex`, `lualatex`, or `latexmk`):

```bash
pdflatex main.tex
```

In this case:
- The resulting PDF will be called `main.pdf`
- Intermediate files (`.aux`, `.log`, etc.) will remain in the same folder

---

## Requirements

To build the slides, you need:
- A LaTeX distribution (e.g., [TeX Live](https://tug.org/texlive/), [MikTeX](https://miktex.org/))
- Python 3 (for using `build.py`)
- Standard LaTeX packages (most are included in full TeX distributions)

---

## Tips

- If compilation fails due to missing packages, install the required LaTeX packages through your distribution’s package manager.
- The `build.py` script is recommended because it keeps the folder clean and ensures consistent output.

---

## Output

After a successful build, the final PDF can be found at:

```
lecture/built/lecture.pdf
```
