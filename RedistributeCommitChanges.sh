#!/bin/bash

# Usage: ./RedistributeCommitChanges.sh <commit-hash>
# Ensure this script is run from the root of a Git repository.

working_dir="/home/couthures/Bureau/HashingWork/Github"

fork_dir="acts"
fork_dir=${working_dir}/${fork_dir}

cd ${fork_dir}

# Configuration
CURRENT_BRANCH="Hashing"

#git checkout "$CURRENT_BRANCH"

COMMIT_HASH=$1
COMMIT_HASH="6bb07bed36a25093290924d19882d26124f4663c"

if [ -z "$COMMIT_HASH" ]; then
    echo "Usage: $0 <commit-hash>"
    exit 1
fi

# Store the current branch name for later use
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

# Create a branch to apply the changes to, branching off from the commit before the target commit
git checkout -b temp-branch $COMMIT_HASH^

# Get a list of files changed in the specified commit.
changed_files=$(git diff-tree --no-commit-id --name-only -r $COMMIT_HASH)

for file in $changed_files; do
    # Find the previous commit that modified this file before $COMMIT_HASH
    previous_commit=$(git log --pretty=format:"%H" -2 $COMMIT_HASH -- $file | tail -n1)

    # Echo the commit and file being modified
    echo "Applying changes from $COMMIT_HASH to $file in previous commit $previous_commit"

    # Apply the changes from $COMMIT_HASH to $previous_commit
    git checkout $previous_commit -- $file

    # Stage the changes
    git add $file
done

# Commit the changes
git commit -m "Applied changes from $COMMIT_HASH to previous relevant commits"

# Return to the original branch to start the rebase process
#git checkout $CURRENT_BRANCH

# The crucial part: rebasing the original branch from the commit after $COMMIT_HASH onto the temp-branch
git rebase --onto $COMMIT_HASH^ "d6f0e81d2dbbd9c2c5347a7342ad6ce5af1e8da2"

# Now $COMMIT_HASH and all subsequent commits from the original branch are rebased onto the temp-branch
echo "Rebase complete. The changes are now on temp-branch, including $COMMIT_HASH and subsequent commits."

# Optionally, you can now check the results and merge temp-branch back to the original branch if everything is correct
echo "If satisfied, you can merge temp-branch into $CURRENT_BRANCH."
# git checkout $CURRENT_BRANCH
# git merge temp-branch

# Cleanup: optionally delete the temporary branch
# git branch -D temp-branch

# Now $COMMIT_HASH and subsequent commits are rebased on top of the changes made in temp-branch.
# Optionally, merge temp-branch to main or another base branch.
echo "Rebase complete. You might want to merge temp-branch into your base branch."

#git diff HEAD..temp-branch

# Cleanup: optionally delete the temporary branch
# git branch -D temp-branch

