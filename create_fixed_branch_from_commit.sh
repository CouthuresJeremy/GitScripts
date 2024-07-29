#!/bin/bash

# Script to create a new branch from a specific commit without user input

working_dir="/home/couthures/Bureau/HashingWork/Github"

fork_dir="acts"
fork_dir=${working_dir}/${fork_dir}

cd ${fork_dir}

# Configuration
CURRENT_BRANCH="Hashing-dev"

git checkout "$CURRENT_BRANCH"

# Variables
commit_hash="f5cee2884e8fe65654dd0c432bfeff8cb22f0aac"  # Replace ENTER_COMMIT_HASH_HERE with your desired commit hash
new_branch_name="typos_fix"  # Replace ENTER_NEW_BRANCH_NAME_HERE with your desired branch name

# Check if git is installed
if ! command -v git &> /dev/null
then
    echo "git could not be found, please install git."
    exit 1
fi

# Verify this is a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1;
then
    echo "This is not a git repository."
    exit 1
fi

# Create new branch from a specific commit
git checkout -b "$new_branch_name" "$commit_hash"

if [ $? -eq 0 ]; then
    echo "Successfully created new branch '$new_branch_name' from commit $commit_hash"
else
    echo "Failed to create the branch. Please check the commit hash and try again."
    exit 1
fi

