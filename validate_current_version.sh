#!/bin/bash
working_dir="/home/couthures/Bureau/HashingWork/Github"

fork_dir="acts"
fork_dir=${working_dir}/${fork_dir}

cd ${fork_dir}

# Check rebase success and then compile and test sequentially
if /bin/bash ${working_dir}/run_compile.sh && /bin/bash ${working_dir}/run_retro_test.sh; then
    echo "Version validated"
    exit 0
else
    echo "Issue with this version"
    exit 1
fi

