working_dir="/home/couthures/Bureau/HashingWork/Github"

fork_dir="acts"
fork_dir=${working_dir}/${fork_dir}

cd ${fork_dir}

branch_name="main"

git fetch upstream
git checkout ${branch_name}
git rebase upstream/main
