#!/bin/bash

working_dir="/home/couthures/Bureau/HashingWork/Github"

repository_dir="${working_dir}/acts"

export LD_LIBRARY_PATH="${working_dir}/build/thirdparty/OpenDataDetector/factory${LD_LIBRARY_PATH:+:}${LD_LIBRARY_PATH}"
source ~/Bureau/DD4hep/build/bin/thisdd4hep.sh
source ${working_dir}/build/this_acts.sh
source ${working_dir}/build/python/setup.sh 
source ~/softwares_install/root/bin/thisroot.sh


result_dir="/home/couthures/Bureau/HashingWork/results/tests"

cd ${result_dir}

#new: detector
detector=ODD

mu=50
bucketSize=100
seedingAlgorithm=HashingSeeding
seedingAlgorithm=Hashing
#seedingAlgorithm=Default
nevents=100
#nevents=10
nevents=20
saveFiles=True
metric=dphi
zBins=100000
phiBins=0
maxSeedsPerSpM=1000
output_dir_name="detector_generic_output_hashing_mu_${mu}_bucket_${bucketSize}_maxSeedsPerSpM_${maxSeedsPerSpM}_seedFinderConfig_TrackML_seedingAlgorithm_${seedingAlgorithm}Seeding_metric_${metric}_AnnoySeed_123456789_zBins_${zBins}"
rm -r "${result_dir}/${output_dir_name}"
#/bin/python3 ${working_dir}/acts/Examples/Scripts/Python/seeding.py
#/bin/python3 ${working_dir}/acts/Examples/Scripts/Python/full_chain_odd.py --ttbar --events=20
#/bin/python3 ${working_dir}/acts/Examples/Scripts/Python/full_chain_odd_hashing.py --mu=$mu --bucketSize=$bucketSize --seedingAlgorithm=$seedingAlgorithm --nevents=$nevents --saveFiles=$saveFiles --metric=$metric --zBins=$zBins --phiBins=$phiBins --maxSeedsPerSpM=$maxSeedsPerSpM
/bin/python3 ${working_dir}/acts/Examples/Scripts/Python/hashing_seeding.py --mu=$mu --bucketSize=$bucketSize --seedingAlgorithm=$seedingAlgorithm --nevents=$nevents --saveFiles=$saveFiles --metric=$metric --zBins=$zBins --phiBins=$phiBins --maxSeedsPerSpM=$maxSeedsPerSpM

references_dir="/home/couthures/Bureau/HashingWork/results/tests/References"
active_test_dir="ref_9_jan_2024_to_check"
active_test_dir="ref_18_jan_2024_to_check"
active_test_dir="ref_28_mar_2024_to_check"
active_test_dir="ref_09_apr_2024_hash_95d0052e6fb4af0daa85ee6f807bc8a4b87683ca"
active_test_dir="ref_09_apr_2024_hash_95d0052e6fb4af0daa85ee6f807bc8a4b87683ca_small"
active_test_dir="ref_09_apr_2024_hash_a739299b62a58204fca39cfbb35a94fd912b761d"
active_test_dir="ref_10_apr_2024_hash_c4f5a414446b9268da5749ae9723e8199cf54bf5"
active_test_dir="ref_10_apr_2024_hash_1df91751ccfa8eb4ff61c2d10554208c089cd089_to_check"
active_test_dir="ref_10_apr_2024_hash_19464fa0d24f031083ef3ad3108b74f2b5fa5454"
active_test_dir="ref_10_apr_2024_hash_fc754692a02f21804fd215e67886631feea3e509"
active_test_dir="ref_10_apr_2024_hash_1cc17595d3278f5488fb6d4eba2b6336f909903a"
active_test_dir="ref_11_apr_2024_hash_6fd0337cb1eb9e7ab8df5c6335b3fdb0076e9cc2"
active_test_dir="ref_11_apr_2024_hash_28c31336ca89c7680a998cbd8acde90f4c2f4f60"
active_test_dir="ref_11_apr_2024_hash_69f72174dce3bd8153f459a7acb5ff437d2345fb"
active_test_dir="ref_17_apr_2024_hash_d9f775f4155f1a13e316aa142e939ef7178ff665"
active_test_dir="ref_17_apr_2024_hash_4935604fa3c6ebae23467312684800a78e722c0b"
active_test_dir="ref_22_apr_2024_hash_f88bf424e863cb871cc5ae39367f07d9256fd54a"
active_test_dir="ref_22_apr_2024_hash_301ba29efab4650b8e657d11a2286e342edd4de9"
active_test_dir="ref_25_apr_2024_hash_e0633f32a4f274313e8be1dc2c1020f742e5ebcf"
active_test_dir="ref_25_apr_2024"
active_test_dir="ref_07_jun_2024_57fd232791810cbb1bb5a58f57c73e73c7a4a4e3"
active_test_dir="ref_10_jun_2024_8ad346b87fa7132078c0fcf6fb1fe603ca721483"
active_test_dir=${references_dir}/${active_test_dir}

test_dir_name=ref_${output_dir_name}
test_dir_name=${output_dir_name}

cd "${repository_dir}"

# Store the current branch name for later use
ORIGINAL_BRANCH=$(git rev-parse --abbrev-ref HEAD)

# Validating branch
VALIDATING_BRANCH="main"
VALIDATING_BRANCH=$ORIGINAL_BRANCH

if [ "$VALIDATING_BRANCH" != "$ORIGINAL_BRANCH" ]; then
	# Ensure we're comparing on the validating branch
	# WARNING: This makes cmake have to recompile everything from scratch
	git checkout "$VALIDATING_BRANCH"
fi

/bin/python3 ~/Bureau/Codes/Scripts/compare_directories.py --dir1="${result_dir}/${output_dir_name}" --dir2="${active_test_dir}/${test_dir_name}" --called_by_script
compare_success=$?

if [ "$VALIDATING_BRANCH" != "$ORIGINAL_BRANCH" ]; then
	# Ensure we get back to the original branch
	git checkout "$ORIGINAL_BRANCH"
fi

if [[ $compare_success -eq 0 ]]; then
    echo Good commit
    exit 0  # Good commit
else
    echo Bad commit
    exit 1  # Bad commit
fi
