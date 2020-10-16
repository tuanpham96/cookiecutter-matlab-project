#!/bin/bash

# Init repo
git init
git add *
git commit -m "Create repo"

# Create exploratory branch
git branch exploratory
git checkout exploratory

# Get necessary parameters
EXTPKG_DIR='extpkg'
AUTHOR_NAME='{{ cookiecutter.author_name }}'
PROJECT_NAME='{{ cookiecutter.project_name }}'

# Function to confirm everything's done
function confirm_done() {
    echo "All done! Have fun with your project on ${PROJECT_NAME}, ${AUTHOR_NAME}!"
}

# FZF opts
export FZF_DEFAULT_OPTS="--reverse \
        --border \
        --ansi \
        --pointer='>' \
        --marker='+'  \
        --no-mouse \
        --info=inline \
        --bind='ctrl-a:select-all' \
        --color='bg:237,bg+:236,info:143,border:240,spinner:108' \
        --color='hl:65,fg:252,header:65,fg+:252' \
        --color='pointer:161,marker:168,prompt:110,hl+:10'"

# Option to install other github repos (via git subtree )
declare -A SUB_LIST=(
    [penguin-matlab-utils]="https://github.com/tuanpham96/penguin-matlab-utils" \
    [export_fig]="https://github.com/altmany/export_fig" \
    [ParforProgMon]="https://github.com/DylanMuir/ParforProgMon" \
    [shadedErrorBar]="https://github.com/raacampbell/shadedErrorBar" \
    [Violinplot-Matlab]="https://github.com/bastibe/Violinplot-Matlab" )

SUB_DISPLAY=''
for i in "${!SUB_LIST[@]}"
do
    SUB_DISPLAY="${SUB_DISPLAY}\e[1m${i}, \e[0m ${SUB_LIST[${i}]} \n"
done
SUB_DISPLAY="${SUB_DISPLAY::-2}"

SUB_FZF_PROMPT=$(echo -e "Choose the packages for cloning to EXTPKG.\nThese are optional but are quite useful!")
SUB_FZF_HEADER=$(echo -e "   Instructions:
\tTAB for select/deselect.
\tCTRL+   A to select all.
\tARROWS for navigation.
\tCLICK on link to go to repo for more detail.
\tESC for escape")

CHOSEN_SUB=($(
    echo -e $SUB_DISPLAY | fzf --multi \
        --prompt="${SUB_FZF_PROMPT}"\
        --header="${SUB_FZF_HEADER}"\
        | awk -F "," '{print $1}'))

echo ">>> Starting cloning repos ..."
for i in "${CHOSEN_SUB[@]}"
do
    git_url="${SUB_LIST[$i]}"
    echo -e "\t + $i--- git remote add & subtree add ${git_url}..."
    # git remote add -f $i "${git_url}"
    git subtree add --prefix $EXTPKG_DIR/$i "${git_url}" master --squash
done

EXAMPLE_START_UP_FILE="penguin-matlab-utils/example_start_up.m"
if [[ -f $EXAMPLE_START_UP_FILE ]]; then
    cp -v penguin-matlab-utils/example_start_up.m ../start_up.m
fi

confirm_done