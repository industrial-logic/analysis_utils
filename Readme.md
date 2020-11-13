These instructions assume you have a bash-like shell. Any unix will be fine. Mac OS as well. For windows, consider using [git bash](https://gitforwindows.org/).

## Tools needed:
* Git
* PMD (downloaded automatically)
* bash 
* curl
* coreutils package (for gdate)
* gnuplot package (for plotting duplications over time)
* jq (for easier posting to slack)

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

* Use one of the scripts
```
~/src/analysis_utils/summarize.sh
```

### Assumptions
Any of the tools that compare results currently require a clean repo.
If the repo has any local changes, you'll get a message. 

### Show Duplication with example Code
This does not require a clean repo.
```
cd <your repo>
~/src/analysis_utils/dups.sh 
```

### Summarize duplicates
This does not require a clean repo.
```
cd <your repo>
~/src/analysis_utils/summarize.sh 
    1,     4,   29, (./src/main/java/org/shoe/rpn/Multiply.java:5)
    1,     4,   29, (./src/main/java/org/shoe/rpn/Subtract.java:4)
    2,     4,   27, (./src/main/java/org/shoe/rpn/BinaryOperator.java:3)
    2,     4,   27, (./src/main/java/org/shoe/rpn/Subtract.java:3)
    3,     3,   24, (./src/main/java/org/shoe/rpn/BinaryOperator.java:4)
    3,     3,   24, (./src/main/java/org/shoe/rpn/Multiply.java:5)
    4,     5,   22, (./src/main/java/org/shoe/rpn/Factorial.java:3)
    4,     5,   22, (./src/main/java/org/shoe/rpn/Multiply.java:3)
```
That is: ID, Line Count, Token Count, File. If you run this in the terminal window in Idea, 
you can double-click inside the () and then hit <shift> <shift> <return> to go to that file.

Also, if you run this in a parent directory that contains multiple
projects, then you'll see duplication between projects as well.

### Show change in duplication from last commit
If your repo is dirty (new/changed files and/or staged but not commited files):
* This script will show the difference between current repo and the last commit
* You will not be able to use the -b option to walk through previous commits

If your repo is clean:
* This script will show the difference between the most recent commit (HEAD) and the previous commit (HEAD^ or HEAD~1)

```bash
$ ~/src/analysis_utils/last_commit_dups.sh
lp-achievement                : Diff:        0 (   0%) Current:    3775 Previous:    3775 Commit: 4c946a793bdf934b00d8df8bd020168f424aa2c9 [2020-08-27 12:01:07 -0500]
```

For clean repos, you can also provide -b and give a number to look at multiple commits.
```
$ ~/src/analysis_utils/last_commit_dups.sh -b 10
rpn_kata                      : Diff:       32 (   0%) Current:      32 Previous:       0 Commit: a76b4309759c5a98b7c541f2ec1c830a7debc4dd [2020-06-19 14:08:02 -0500]
rpn_kata                      : Diff:        0 (   0%) Current:       0 Previous:       0 Commit: e2fc1b15f4b5da98f23963618755243f1f7dfbe8 [2020-06-19 12:50:48 -0500]
rpn_kata                      : Diff:        0 (   0%) Current:       0 Previous:       0 Commit: 804d8102cc0521bd1d2e626b2eddc6686558e06e [2020-06-19 12:40:58 -0500]
rpn_kata                      : Diff:        0 (   0%) Current:       0 Previous:       0 Commit: 85d2f54df16c4d08ab3fa8f1c7f8651346cd3880 [2020-06-19 12:16:46 -0500]
rpn_kata                      : Diff:        0 (   0%) Current:       0 Previous:       0 Commit: c662a7b223118aba1902b70a95f2cc706efc170f [2020-06-19 12:15:35 -0500]
rpn_kata                      : Diff:        0 (   0%) Current:       0 Previous:       0 Commit: a15bf9f039d68eb443d43ff3e1766cc85f521e17 [2020-06-04 16:10:57 -0500]
rpn_kata                      : Diff:        0 (   0%) Current:       0 Previous:       0 Commit: fe97d3cdf13b56a56755c23de382cf9ac92a9ac6 [2020-06-04 13:11:25 -0500]
rpn_kata                      : Diff:        0 (   0%) Current:       0 Previous:       0 Commit: 9aa90cf68a33c9a25cbae13a0d62f5280c724886 [2020-05-28 14:51:59 -0500]
```

### Look for cyclomatic complexity issues by each commit
This requires a clean repo.
```
~/src/analysis_utils/pmd_walk.sh cc.xml > cc_report.txt
```

### Look for code duplication by each commit
This requires a clean repo.
```
~/src/analysis_utils/historical_duplication.sh > dup_report.txt
```

