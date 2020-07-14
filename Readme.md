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
git clone https://github.com/schuchert/analysis_utils.git
```
* Switch to a git repository
```
cd ~/src/some_git_repo
```

### Assumptions
There are no local changes. If there are, you will lose them. So commit or stash.

### Check for duplication 
```
~/src/analysis_utils/dups.sh > dups.txt
```

### Check for duplication changed by most recent commit
```
~/src/analysis_utils/dups_in_this_commit.sh > dups.txt
```

### Look for cyclomatic complexity issues by each commit
```
~/src/analysis_utils/pmd_walk.sh cc.xml > cc_report.txt
```

### Look for code duplication by each commit
```
~/src/analysis_utils/historical_duplication.sh > dup_report.txt
```

### Check for dups across several children directories under current directory
```
cd ~/src # note is a top-level directory where I clone my repos
~/src/analysis_utils/dups_across_all.sh
```

This will find all directories under the current one with a src directory.
Then for each directory, cd into in, run dups_in_this_commit.sh.

