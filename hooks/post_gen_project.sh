#!/bin/bash
# TODO: customize color scheme for FZF

# Init repo
git init

# Go to external package path
EXTPKG_DIR='extpkg'
cd $EXTPKG_DIR

# FZF opts
export FZF_DEFAULT_OPTS="--reverse \
        --border \
        --ansi \
        --pointer='>' \
        --marker='+'  \
        --no-mouse \
        --info=inline \
        --color='bg:237,bg+:236,info:143,border:240,spinner:108' \
        --color='hl:65,fg:252,header:65,fg+:252' \
        --color='pointer:161,marker:168,prompt:110,hl+:10'"

# Option to install PENGUIN-MATLAB-UTILS from repo (either add as submodule or clone)
MLUTILS_OPTS='SUB,Add as submodule\nCLONE,Git clone the repository\nNONE,Do nothing with this repo'
MLUTILS_FZF_PROMPT=$(echo -e "Choose what to do with the matlab-utils repo.\n Click here for more details https://github.com/tuanpham96/penguin-matlab-utils")
MLUTILS_FZF_HEADER=$(echo -e "   Instructions:\n\t ENTER for select only one option.\n\t ARROWS for navigation.\n\t ESC for escape")
MLUTILS_CHOSEN_OPT=$(echo -e "${MLUTILS_OPTS}" | fzf --no-multi \
        --delimiter="," --with-nth=2 \
        --prompt="${MLUTILS_FZF_PROMPT}"\
        --header="${MLUTILS_FZF_HEADER}" \
        | awk -F "," '{print $1}')

case $MLUTILS_CHOSEN_OPT in
    SUB)
        echo ">>> Adding as submodule: git submodule add https://github.com/tuanpham96/penguin-matlab-utils ..."
        git submodule add https://github.com/tuanpham96/penguin-matlab-utils
        echo ">>> Copying 'example_start_up.m' to main project path as 'start_up.m' script'"
        cp -v penguin-matlab-utils/example_start_up.m ../start_up.m
        ;;
    CLONE)
        echo ">>> Adding as submodule: git clone https://github.com/tuanpham96/penguin-matlab-utils ..."
        git clone https://github.com/tuanpham96/penguin-matlab-utils
        echo ">>> Copying 'example_start_up.m' to main project path as 'start_up.m' script'"
        cp -v penguin-matlab-utils/example_start_up.m ../start_up.m
        ;;
    *)
        echo "Nothing is done for https://github.com/tuanpham96/penguin-matlab-utils"
        ;;
esac

# Option to install other github repos (via git clone)
declare -A CLONE_LIST=(
    [export_fig]="https://github.com/altmany/export_fig" \
    [ParforProgMon]="https://github.com/DylanMuir/ParforProgMon" \
    [shadedErrorBar]="https://github.com/raacampbell/shadedErrorBar" \
    [Violinplot-Matlab]="https://github.com/bastibe/Violinplot-Matlab" )

CLONE_DISPLAY=''
for i in "${!CLONE_LIST[@]}"
do
    CLONE_DISPLAY="${CLONE_DISPLAY}\e[1m${i}, \e[0m ${CLONE_LIST[${i}]} \n"
done
CLONE_DISPLAY="${CLONE_DISPLAY::-2}"

CLONE_FZF_PROMPT=$(echo -e "Choose the packages for cloning to EXTPKG.\nThese are optional but are quite useful!")
CLONE_FZF_HEADER=$(echo -e "   Instructions:\n\t TAB for select multiple options.\n\t ARROWS for navigation.\n\t CLICK on link to go to repo for more detail.\n\t ESC for escape")

CHOSEN_CLONE=($(
    echo -e $CLONE_DISPLAY | fzf --multi \
        --prompt="${CLONE_FZF_PROMPT}"\
        --header="${CLONE_FZF_HEADER}"\
        | awk -F "," '{print $1}'))

echo ">>> Starting cloning repos ..."
for i in "${CHOSEN_CLONE[@]}"
do
    echo -e "\t + ${i} --- git clone ${CLONE_LIST[${i}]} ..."
    git clone "${CLONE_LIST[${i}]}"
done

# Confirm everything's done
AUTHOR_NAME='{{ cookiecutter.author_name }}'
PROJECT_NAME='{{ cookiecutter.project_name }}'
echo "All done! Have fun with your project on ${PROJECT_NAME}, ${AUTHOR_NAME}!"