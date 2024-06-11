#!/bin/bash

# rebase_conflict_checker.sh
# Usage: ./rebase_conflict_checker.sh <commit-hash>
#!/bin/bash

working_dir="/home/couthures/Bureau/HashingWork/Github"

fork_dir="acts"
fork_dir=${working_dir}/${fork_dir}

cd ${fork_dir}

# Configuration
CURRENT_BRANCH="Hashing"

# Ensure we're starting on the current branch
git checkout "$CURRENT_BRANCH"

#if [ "$#" -ne 1 ]; then
#    echo "Usage: $0 <commit-hash>"
#    exit 1
#fi

start_commit=$1
start_commit="d70d2ff645a890a154cebbc3001de8a098122755"
current_branch=$(git rev-parse --abbrev-ref HEAD)
output_file="../rebase_ranges.txt"

# Prepare output file
echo "Commit Range Analysis for rebasing from $start_commit on branch $current_branch" > $output_file
echo "" >> $output_file

# Get list of commits from the specified commit to the latest commit on the branch
commit_list=$(git rev-list --ancestry-path $start_commit..HEAD)

# Store original state to restore later
original_head=$(git rev-parse HEAD)

# Temporary branch for testing rebases
git checkout -b temp-rebase-checker $start_commit

# Check each commit by attempting to rebase it on each subsequent commit
for commit in $commit_list; do
    commit_subject=$(git log -1 --format=%s $commit)
    echo "Testing commit $commit: '$commit_subject'" >> $output_file
    can_rebase_up_to=$commit  # Start assuming the commit can only rebase to itself
    for target_commit in $(git rev-list $commit..HEAD); do
        # Attempt to rebase quietly without prompting for conflict resolution
        if git rebase --onto $target_commit^ $commit^ $commit; then
            can_rebase_up_to=$target_commit
        else
            git rebase --abort
            break
        fi
    done
    target_subject=$(git log -1 --format=%s $can_rebase_up_to)
    echo "Commit $commit ('$commit_subject') can be rebased up to $can_rebase_up_to ('$target_subject') without conflicts." >> $output_file
    # Reset to commit to test next rebase
    git reset --hard $commit
done

# Cleanup: restore original branch and state, delete temporary branch
git checkout $current_branch
git reset --hard $original_head
git branch -D temp-rebase-checker

echo "Rebase testing complete. Results are in $output_file."

