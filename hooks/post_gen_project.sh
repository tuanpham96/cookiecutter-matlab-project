#!/bin/sh

EXTPKG_DIR='extpkg'

cd $EXTPKG_DIR

# Add matlab-utils as a submodule
git submodule add https://github.com/tuanpham96/penguin-matlab-utils
cp penguin-matlab-utils/example_start_up.m ../start_up.m

# Clone export_fig
git clone https://github.com/altmany/export_fig

# Clone ParforProgMon
# either from https://github.com/DylanMuir/ParforProgMon or https://github.com/fsaxen/ParforProgMon
git clone https://github.com/DylanMuir/ParforProgMon

# Clone plotting extras
git clone https://github.com/raacampbell/shadedErrorBar
git clone https://github.com/bastibe/Violinplot-Matlab
