#!/bin/bash

working_dir="/home/couthures/Bureau/HashingWork/Github"

fork_dir="acts"
fork_dir=${working_dir}/${fork_dir}

cd ${fork_dir}

# Configuration
REMOTE_NAME="upstream"
TARGET_BRANCH="main"
#TARGET_BRANCH="seed_filter_container_policy"
CURRENT_BRANCH="Hashing-dev"
#CURRENT_BRANCH="Hashing"
FULL_TARGET_BRANCH=$REMOTE_NAME/$TARGET_BRANCH
#FULL_TARGET_BRANCH=$TARGET_BRANCH

# Ensure we're starting on the current branch
git checkout "$CURRENT_BRANCH"

# Save the original state of the current branch
ORIGINAL_COMMIT=$(git rev-parse HEAD)

# Fetch the latest changes from the remote without merging them
git fetch $REMOTE_NAME

# Get the commit hashes from the target branch not in the current branch
COMMITS_TO_REBASE=$(git rev-list --topo-order --reverse HEAD..$FULL_TARGET_BRANCH)

# Check if there are commits to rebase
if [ -z "$COMMITS_TO_REBASE" ]; then
    echo "Your branch is up to date with $FULL_TARGET_BRANCH."
    exit 0
fi

# Convert commits to array
COMMITS_ARRAY=($COMMITS_TO_REBASE)

# Initialize bisect variables
low=0
high=${#COMMITS_ARRAY[@]}
mid=0
bad_commit_index=-1

# Bisect loop to find the first bad commit
while [ $low -lt $high ]; do
    mid=$(((low+high)/2))

    # Reset to the original state before each test
    git reset --hard $ORIGINAL_COMMIT

    # Attempt to rebase onto the commit being tested
    git rebase --onto ${COMMITS_ARRAY[$mid]} ${COMMITS_ARRAY[$mid]}^
    rebase_success=$?

    # Check rebase success and then compile and test sequentially
    if [ $rebase_success -eq 0 ] && /bin/bash ${working_dir}/run_compile.sh && /bin/bash ${working_dir}/run_retro_test.sh; then
        echo "Good commit: ${COMMITS_ARRAY[$mid]}"
        low=$((mid + 1))
    else
        echo "Bad commit found at: ${COMMITS_ARRAY[$mid]}"
        bad_commit_index=$mid
        high=$mid
        git rebase --abort
    fi
done

# Reset to the original state before applying the good commits
git checkout "$CURRENT_BRANCH"
git reset --hard $ORIGINAL_COMMIT
git fetch $REMOTE_NAME # Ensure latest state

# If a bad commit was found, rebase up to the commit just before the bad one
if [ $bad_commit_index -ne -1 ]; then
    if [ $bad_commit_index -gt 0 ]; then
        # There's at least one good commit to rebase onto
        LAST_GOOD_COMMIT_INDEX=$((bad_commit_index - 1))
        LAST_GOOD_COMMIT_HASH=${COMMITS_ARRAY[$LAST_GOOD_COMMIT_INDEX]}
        echo "Rebasing with good commits up to (but not including) the bad commit."
        git rebase ${COMMITS_ARRAY[$LAST_GOOD_COMMIT_INDEX]}
        rebase_success=$?
        
        # Check rebase success and then compile and test sequentially
        if [ $rebase_success -eq 0 ] && /bin/bash ${working_dir}/run_compile.sh && /bin/bash ${working_dir}/run_retro_test.sh; then
            echo "Good commit"
        else
            echo "Bad commit"
            exit 1  # Exit on bad commit
        fi
    else
        echo "The first commit is bad; no good commits to rebase onto."
    fi
else
    # No bad commits found; rebase all changes
    echo "No bad commits found. Rebasing with all commits."
    git rebase $REMOTE_NAME/$TARGET_BRANCH
fi

echo "Rebase completed."

