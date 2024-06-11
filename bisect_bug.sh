#!/bin/bash

# Add the fork code
# cd acts
# git checkout main
# git rebase upstream/main
# cd ..

# Compile the bindings
/bin/bash run_compile.sh
if [[ $? -ne 0 ]]; then
    echo "Compilation failed for commit $(git rev-parse HEAD)!"
    exit 125  # Special exit code to tell git bisect to skip this commit
fi

# Run the script
/bin/bash run_retro_test.sh
if [[ $? -eq 0 ]]; then
    echo Good commit
    exit 0  # Good commit
else
    echo Bad commit
    exit 1  # Bad commit
fi

