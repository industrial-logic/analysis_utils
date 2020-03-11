These instructions assume you have a bash-like shell. Any unix will be fine. Mac OS as well. For windows, consider using [git bash](https://gitforwindows.org/).

Tools needed:
* Git
* PMD

Getting started.
* Clone this repo (assuming the directory ~/src/analysis_utils for remainder of instructions)
* Download [PMD](https://pmd.github.io/) following the instructions
 [here](https://pmd.github.io/). (The rest of these instructions assume 
 you extracted the zipfile into $HOME.)
* Add the alias pmd to your shell (e.g., in .bash_profile, or .zshrc)
```bash 
alias pmd="$HOME/pmd-bin-6.21.0/bin/run.sh pmd"
```
* Switch to a git repository
* Use previous_cc.sh to get a report for each commit:
```
~/src/analysis_utils/previous_cc.sh
```
