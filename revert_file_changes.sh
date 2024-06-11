#!/bin/bash

source cd_fork.sh

# File: revert_file_changes.sh
# Usage: bash revert_file_changes.sh <commit_hash> <file_path>

# This script reverses changes made to a specific file in a given commit.

# Assign command line arguments to variables
commit_hash=$1
file_path=$2
commit_hash=12bf6c4d46dcf3a6d9dc4e307df76ddf913c7839
file_path=CMakeLists.txt

# Check if git is installed
if ! git --version &> /dev/null; then
    echo "Git is not installed. Please install Git to use this script."
    exit 1
fi

# Ensure that both commit hash and file path are provided
if [ -z "$commit_hash" ] || [ -z "$file_path" ]; then
    echo "Usage: bash revert_file_changes.sh <commit_hash> <file_path>"
    exit 1
fi

# Determine the Git version to decide whether to use checkout or restore
git_version=$(git --version | grep -o '[0-9]\+\.[0-9]\+\.[0-9]\+' | head -n 1)
git_major_version=$(echo $git_version | cut -d'.' -f1)
git_minor_version=$(echo $git_version | cut -d'.' -f2)

if [ "$git_major_version" -gt 2 ] || { [ "$git_major_version" -eq 2 ] && [ "$git_minor_version" -ge 23 ]; }; then
    # Use git restore for Git version 2.23 and later
    git restore --source $commit_hash^ --staged -- $file_path
    echo "Reverted changes to $file_path from commit $commit_hash using git restore."
else
    # Use git checkout for older Git versions
    git checkout $commit_hash^ -- $file_path
    echo "Reverted changes to $file_path from commit $commit_hash using git checkout."
fi

# Stage the file
#git add $file_path
#echo "$file_path staged for commit."

