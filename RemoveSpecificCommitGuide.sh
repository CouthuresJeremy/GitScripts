#!/bin/bash
# RemoveSpecificCommitGuide.sh
COMMIT_HASH=076d0c9d0aeb57a229e839a98aa75061ec8574cc

# Move to the fork directory
source cd_fork.sh

# Step 1: Start an interactive rebase
# Replace COMMIT_HASH with the hash of the commit just before the one you want to remove
git rebase -i $COMMIT_HASH^

# During the rebase:
# - An editor will open with a list of commits
# - Change 'pick' to 'drop' for the commit you want to remove
# - Save and exit the editor

# Step 2: Force push the changes if this commit was already pushed to a remote repository
# WARNING: This will rewrite history. Use with caution and coordinate with your team.
#git push --force

