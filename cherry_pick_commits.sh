#!/bin/bash
source ./cd_fork.sh
# Usage: ./cherry_pick_commits.sh <target-branch> <start-commit>

target_branch="$1"
start_commit="$2"
target_branch="Hashing-dev"
target_branch="Hashing"
# start_commit is not included
start_commit="53b292e9d89f379fb5051203b91d26ba13eb0902"
start_commit="80a03ea58b09efbbb1cdf4ba6b42029c90918798"

# Check if sufficient arguments were provided
if [ -z "$target_branch" ] || [ -z "$start_commit" ]; then
    echo "Usage: $0 <target-branch> <start-commit>"
    exit 1
fi

# Fetch the latest updates from all branches
git fetch

# Check out to the target branch temporarily to get the commit list
git checkout $target_branch

# Get the list of commit hashes from start_commit to the end of the branch
commit_list=$(git log --reverse --format=%H $start_commit..HEAD)

# Check out back to the original branch
git checkout -

# Cherry-pick each commit onto the current branch
for commit in $commit_list; do
    git cherry-pick $commit
    if [ $? -ne 0 ]; then
        echo "Conflict detected. Please resolve the conflict and continue, or abort the cherry-pick."
        exit 1
    fi
done

echo "Cherry-picking complete."

