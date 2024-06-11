#!/bin/bash

working_dir="/home/couthures/Bureau/HashingWork/Github"
/bin/bash ${working_dir}/run_compile.sh
compile_success=$?
if [[ $compile_success -eq 1 ]]; then
    echo Bad compile
    exit 1  # Bad commit
fi
export LD_LIBRARY_PATH="${working_dir}/build/thirdparty/OpenDataDetector/factory${LD_LIBRARY_PATH:+:}${LD_LIBRARY_PATH}"
source ~/Bureau/DD4hep/build/bin/thisdd4hep.sh
source ${working_dir}/build/this_acts.sh
source ${working_dir}/build/python/setup.sh 
source ~/softwares_install/root/bin/thisroot.sh


result_dir="/home/couthures/Bureau/HashingWork/results/tests"

cd ${result_dir}

mu=50
bucketSize=100
seedingAlgorithm=HashingSeeding
#seedingAlgorithm=Default
nevents=100
#nevents=10
saveFiles=True
metric=dphi
zBins=100000
phiBins=0
maxSeedsPerSpM=1000
/bin/python3 ${working_dir}/acts/Examples/Scripts/Python/full_chain_odd_hashing.py --mu=$mu --bucketSize=$bucketSize --seedingAlgorithm=$seedingAlgorithm --nevents=$nevents --saveFiles=$saveFiles --metric=$metric --zBins=$zBins --phiBins=$phiBins --maxSeedsPerSpM=$maxSeedsPerSpM

