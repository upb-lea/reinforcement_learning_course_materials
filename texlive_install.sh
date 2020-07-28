#!/usr/bin/env sh

# Originally from https://github.com/latex3/latex3
# Copied from https://tex.stackexchange.com/questions/398830/how-to-build-my-latex-automatically-using-travis-ci

# This script is used for testing using Travis
# It is intended to work on their VM set up: Ubuntu 12.04 LTS
# A minimal current TL is installed adding only the packages that are
# required

# See if there is a cached version of TL available
export PATH=/tmp/texlive/bin/x86_64-linux:$PATH
if ! command -v texlua > /dev/null; then
  # Obtain TeX Live
  wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
  tar -xzf install-tl-unx.tar.gz
  cd install-tl-20*

  # Install a minimal system
  ./install-tl --profile=../texlive/texlive.profile

  cd ..
fi

# Just including texlua so the cache check above works
# Needed for any use of texlua even if not testing LuaTeX
tlmgr install luatex

# Other contrib packages: done as a block to avoid multiple calls to tlmgr
# texlive-latex-base is needed to run pdflatex
tlmgr install   \
  beamer        \
  beamerbasemodes  \
  etoolbox  \
  beamerbasedecode  \  
  ifpdf  \
  beamerbaseoptions  \ 
  keyval  \
  geometry  \
  ifvtex  \
  ifxetex  \
  size11  \
  pgfcore  \
  graphicx  \
  graphics  \
  trig  \
  pgfsys  \
  pgfrcs  \
  everyshi  \
  xcolor  \
  xxcolor  \
  atbegshi  \
  infwarerr  \
  ltxcmds  \
  hyperref  \
  hobsub-hyperref  \
  hobsub-generic  \
  hobsub  \
  ifluatex  \
  intcalc  \
  etexcmds  \
  kvsetkeys  \
  kvdefinekeys  \
  pdftexcmds  \
  pdfescape  \
  bigintcalc  \
  bitset  \
  uniquecounter  \
  letltxmacro  \
  hopatch  \
  xcolor-patch  \
  atveryend  \
  refcount  \
  hycolor  \
  auxhook  \
  kvoptions  \
  url  \
  rerunfilecheck  \
  amssymb  \
  amsfonts  \  
  translator  \
  enumerate  \
  amsmath  \
  amstext  \
  amsgen  \
  amsbsy  \
  amsopn  \
  amsthm  \
  algorithm2e  \
  ifthen  \
  ifoddpage  \
  xspace  \
  relsize  \
  inputenc  \
  subfig  \
  caption  \
  caption3  \
  ragged2e  \
  everysel  \
  array  \
  hhline  \
  units  \
  nicefrac  \
  bm  \
  animate  \
  xkeyval  \
  ifdraft  \
  calc  \
  pdfbase  \
  expl3  \
  l3keys2e  \
  ocgbase  \
  multirow  \
  xmpincl  \
  pifont  \
  tcolorbox  \
  pgf  \
  verbatim  \
  environ  \
  trimspaces  \
  listings  \
  lstmisc  \
  shellesc  \
  tikz  \
  pgffor  \
  pgfkeys  \
  pgfmath  \
  epstopdf-base  \
  grfext  \
  nameref  \
  gettitlestring  
  

# Keep no backups (not required, simply makes cache bigger)
tlmgr option -- autobackup 0

# Update the TL install but add nothing new
tlmgr update --self --all --no-auto-install
