# `cookiecutter` for matlab-project

This is a `cookiecutter` template for MATLAB projects. Technically this is more so the type of projects I'm used to. For other purposes like add-on or app development, please consider looking at [1]. The structure of this template is inspired by [1], [2], [3]. This template is quite barebone vanilla. I'm open to suggestions and feedbacks.

## TODO

- [ ] Add option to select `git submodule add`, `git substree`, or `git clone` for external packages.
- [ ] Change color scheme of `fzf` default options.
- [ ] Add option to create and `exploratory` branch.
- [ ] Update external packages regularly (`fetch` and `git subtree pull`)
- [ ] Add option to not use external package installation *during* template generation without having to go through the prompt, maybe via some config file?
- [ ] Add option to download external packages from *MathworksExchange*
- [ ] Add a script to download and install external packages after template generation.

## Dependencies

- [`cookiecutter`][4], preferentially in a `conda` environment (or just any python virtual environment to keep things clean for your system)
- [`fzf`][5] for selecting options post-generation selections of external packages. Please refer to [their repo][5] for installation to specific OSes. Additionally, you could also use `conda` to install `fzf`.

## Instructions

For example, I created a `conda` environment named to remove the submodule, or do it however you're comfortable with.`cookie-cutter-env`:

``` bash
# remember to activate your environment
conda activate cookie-cutter-env

# installation (only need to do once)
conda install -c conda-forge cookiecutter
conda install -c conda-forge fzf

# use the template
cookiecutter https://github.com/tuanpham96/cookiecutter-matlab-project
```

After the template is done, go through the prompts to install external packages from github repos - these are some that I usually use. If there are other you would like to recommend, please let me know to add into the list of options.

## External packages options

If you accidentally select some packages but you don't want it anymore, just remove it in the `extpkg` (for example by using `rm -rf`). For packages added as a submodule, you can refer to [here][6] to remove the submodule, or do it however you're comfortable with.

If you don't choose any of the above list during the generation step, just simply do a `git clone` or `git submodule add` or `git substree add` (follow [here][12] for more information) with the links above in the `extpkg` path.

Currently these are from github repos.

- [penguin-matlab-utils][7]: a list of functions I developed over the years. Would not recommend cuz I don't document well with many of them.
- [export_fig][8]: exporting matlab figures, quite useful with the cropping option to save space, and with linux OSes due to some font inavailability.
- [ParforProgMon][9]: progress monitor for using `parfor`. There are of course other forks doing the same thing.
- [shadedErrorBar][10]: shaded error bars + lines that look nicer than MATLAB built-in error bars
- [Violinplot-Matlab][11]: beautiful violin plots. I really wish MATLAB would step it up and made these plots one of their standards.

I'm not quite sure yet how to add the ones from *MathworksExchange* yet.

## Template structure

``` markdown
├── code                <-- [dir] scripts to run the main codes
├── data                <-- [dir] data directory; depending on usage, create further subdirectories and update the *.gitignore* and *.gitkeep* files
├── demo                <-- [dir] demo scripts to show examples, if needed
├── docs                <-- [dir] documents, like references, instructions, some reports
├── extpkg              <-- [dir] external packages and addons (from github or matlabexchange for example); either download them straight here, clone them, or add as a submodule or as subtree
├── figures             <-- [dir] figure directory; depending on usage, create further subdirectories
├── functions           <-- [dir] source functions to be used for scripts
├── reports             <-- [dir] tend to be final reports, or presentations
├── scratch             <-- [dir] scratch/test codes and scripts
├── LICENSE
└── README.md           <-- [file] describe the project and its progress here
```

[1]: https://github.com/suever/matlab-plugin-cookiecutter
[2]: https://github.com/drivendata/cookiecutter-data-science
[3]: https://github.com/audreyfeldroy/cookiecutter-pypackage
[4]: https://github.com/cookiecutter/cookiecutter
[5]: https://github.com/junegunn/fzf
[6]: https://stackoverflow.com/questions/1260748/how-do-i-remove-a-submodule
[7]: https://github.com/tuanpham96/penguin-matlab-utils
[8]: https://github.com/altmany/export_fig
[9]: https://github.com/DylanMuir/ParforProgMon
[10]: https://github.com/raacampbell/shadedErrorBar
[11]: https://github.com/bastibe/Violinplot-Matlab
[12]: https://www.atlassian.com/git/tutorials/git-subtree
