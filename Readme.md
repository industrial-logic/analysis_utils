These instructions assume you have a bash-like shell. Any unix will be fine. Mac OS as well. For windows, consider using [git bash](https://gitforwindows.org/).

## Tools needed:
* Git
* PMD (downloaded automatically)
* bash 
* curl

## Using
* Clone this repo (assuming the directory ~/src/analysis_utils for remainder of instructions)
* Switch to a git repository

### Look for cyclomatic complexity issues by each commit
```
~/src/analysis_utils/walk.sh cc.xml > report.txt 2>/dev/null
```
### Look for code duplication by each commit
```
~/src/analysis_utils/dup.sh > report.txt 2>/dev/null
```
