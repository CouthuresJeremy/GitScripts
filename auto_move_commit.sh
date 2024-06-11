#!/bin/bash
# auto_move_commit.sh
COMMIT_HASH=f08a7e732214187c8a6998102fc4f4a4ec0151b8
cd acts

#!/bin/bash

# Script to automatically move a commit after a specified target commit in Git history

# Check if correct number of arguments is passed
#if [ "$#" -ne 2 ]; then
#  echo "Usage: $0 <commit-to-move> <target-commit>"
#  exit 1
#fi

COMMIT_TO_MOVE=f08a7e732214187c8a6998102fc4f4a4ec0151b8
TARGET_COMMIT=74afd55a4856ed5b5a4e6e6b96633e84f06c37c5
# Create a new branch from the current state to apply changes
ORIGINAL_BRANCH=$(git branch --show-current)

# Abort on errors
set -e

# Ensure there are no uncommitted changes
#if [ -n "$(git status --porcelain)" ]; then
#  echo "Error: You have uncommitted changes. Please commit or stash them."
#  exit 1
#fi
git rebase -i $TARGET_COMMIT^
echo "Not working"
exit 1
# Abort the script on any errors
set -e

# First, create a branch for the commit to move on top of the target commit
FIRST_BRANCH="temp_first_branch_$(date +%s)"
git checkout -b $FIRST_BRANCH $TARGET_COMMIT
git cherry-pick $COMMIT_TO_MOVE

# Second, create a branch with all commits except the one to move
SECOND_BRANCH="temp_second_branch_$(date +%s)"
git checkout $TARGET_COMMIT
git branch $SECOND_BRANCH
# Exclude the commit to move from the second branch
git rebase --onto $TARGET_COMMIT $COMMIT_TO_MOVE $SECOND_BRANCH

# Finally, rebase the second branch onto the first one
git checkout $SECOND_BRANCH
git rebase $FIRST_BRANCH

# Replace the original branch with the result
ORIGINAL_BRANCH=$(git rev-parse --abbrev-ref HEAD)
git checkout $ORIGINAL_BRANCH
git reset --hard $SECOND_BRANCH

# Cleanup temporary branches
git branch -D $FIRST_BRANCH
git branch -D $SECOND_BRANCH

echo "Commit $COMMIT_TO_MOVE has been successfully relocated after $TARGET_COMMIT."
