These instructions assume you have a bash-like shell. Any unix will be fine. Mac OS as well. For windows, consider using [git bash](https://gitforwindows.org/).

## Tools needed:
* Git
* PMD (downloaded automatically)
* bash 
* curl

## Using
* Clone this repo (assuming the directory ~/src/analysis_utils for remainder of instructions)
```
cd ~/src
git clone git@github.com:schuchert/analysis_utils.git
```
* Switch to a git repository
```
cd ~/src/some_git_repo
```

### Look for cyclomatic complexity issues by each commit
```
~/src/analysis_utils/walk.sh cc.xml 2>/dev/null > cc_report.txt 
```
### Look for code duplication by each commit
```
~/src/analysis_utils/dup.sh 2>/dev/null > dup_report.txt
```
