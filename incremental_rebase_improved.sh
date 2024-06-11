#!/bin/bash
working_dir="/home/couthures/Bureau/HashingWork/Github"

fork_dir="acts"
fork_dir=${working_dir}/${fork_dir}

cd ${fork_dir}

# Configuration
REMOTE_NAME="upstream"
TARGET_BRANCH="main"
CURRENT_BRANCH="Hashing-dev"

git checkout "$CURRENT_BRANCH"

# Fetch the latest changes from the remote without merging them
git fetch $REMOTE_NAME

# Get the commit hashes from the target branch not in the current branch
COMMITS_TO_REBASE=$(git rev-list --topo-order --reverse HEAD..$REMOTE_NAME/$TARGET_BRANCH)

# Check if there are commits to rebase
if [ -z "$COMMITS_TO_REBASE" ]; then
    echo "Your branch is up to date with $REMOTE_NAME/$TARGET_BRANCH."
    exit 0
fi

# Convert commits to array
COMMITS_ARRAY=($COMMITS_TO_REBASE)

# Get length of commits array
LENGTH=${#COMMITS_ARRAY[@]}

# Rebase commits one by one
for (( i=0; i<$LENGTH; i++ )); do
#for (( i=$LENGTH-1; i<$LENGTH; i+=5 )); do
#for (( i=2; i<$LENGTH; i+=5 )); do
    # For the last commit, perform a normal rebase
    if [ $i -eq $((LENGTH-1)) ]; then
        echo "Rebasing onto the last commit ${COMMITS_ARRAY[$i]}..."
        git rebase ${COMMITS_ARRAY[$i]}
    else
        # For all but the last commit, use the next commit as the upper boundary for rebase
        NEXT_COMMIT_INDEX=$((i+1))
        NEXT_COMMIT_HASH=${COMMITS_ARRAY[$NEXT_COMMIT_INDEX]}
        echo "Rebasing up to the commit before ${NEXT_COMMIT_HASH}..."
        git rebase --onto ${COMMITS_ARRAY[$i]} ${NEXT_COMMIT_HASH}^
    fi

    if [ $? -ne 0 ]; then
        echo "Rebase failed. Resolve conflicts, then run 'git rebase --continue' to proceed."
        exit 1
    fi

    if /bin/bash ${working_dir}/run_compile.sh && /bin/bash ${working_dir}/run_retro_test.sh; then
        echo "Good commit"
        exit 0
    else
        echo "Bad commit"
        exit 1  # Exit on bad commit
    fi
done

echo "Rebase completed successfully."

