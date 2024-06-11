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

# Get list of descendants from the specified commit to the latest commit on the branch
descendant_commit_list=$(git rev-list --ancestry-path $start_commit..HEAD)

# Get list of ancestors of the specified commit, up to the root commit
ancestor_commit_list=$(git rev-list $start_commit | tac)  # Reverse list to check from oldest to newest

# Store original state to restore later
original_head=$(git rev-parse HEAD)

# Temporary branch for testing rebases
git checkout -b temp-rebase-checker $start_commit

# Check each commit by attempting to rebase it on each previous and subsequent commit
for commit in $descendant_commit_list; do
    commit_subject=$(git log -1 --format=%s $commit)
    min_rebase_commit=$commit  # Assume the commit can only rebase to itself initially
    max_rebase_commit=$commit

    # Check rebase to previous commits (backward)
    for target_commit in $ancestor_commit_list; do
        if [[ "$target_commit" < "$commit" ]] && git rebase --onto $target_commit^ $commit^ $commit 2>/dev/null; then
            min_rebase_commit=$target_commit
        else
            git rebase --abort
            break
        fi
    done

    # Check rebase to future commits (forward)
    for target_commit in $(git rev-list $commit..HEAD); do
        if git rebase --onto $target_commit^ $commit^ $commit 2>/dev/null; then
            max_rebase_commit=$target_commit
        else
            git rebase --abort
            break
        fi
    done

    min_subject=$(git log -1 --format=%s $min_rebase_commit)
    max_subject=$(git log -1 --format=%s $max_rebase_commit)
    echo "Commit $commit ('$commit_subject') can be rebased between $min_rebase_commit ('$min_subject') and $max_rebase_commit ('$max_subject') without conflicts." >> $output_file
    git reset --hard $commit # Reset to commit to test next rebase
done

# Cleanup: restore original branch and state, delete temporary branch
git checkout $current_branch
git reset --hard $original_head
git branch -D temp-rebase-checker

echo "Rebase testing complete. Results are in $output_file."

