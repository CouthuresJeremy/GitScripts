#!/bin/bash

working_dir="/home/couthures/Bureau/HashingWork/Github"

repository_dir="${working_dir}/acts"

# set -x
# export LD_LIBRARY_PATH="${working_dir}/build/thirdparty/OpenDataDetector/factory${LD_LIBRARY_PATH:+:}${LD_LIBRARY_PATH}"
# source ~/Bureau/DD4hep/build/bin/thisdd4hep.sh
source ${working_dir}/build/this_acts.sh
source ${working_dir}/build/python/setup.sh 
# source ~/softwares_install/root_install/bin/thisroot.sh
# set +x


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
output_dir_name="detector_generic_output_hashing_mu_${mu}_bucket_${bucketSize}_maxSeedsPerSpM_${maxSeedsPerSpM}_seedFinderConfig_TrackML_seedingAlgorithm_${seedingAlgorithm}Seeding_metric_${metric}_annoySeed_123456789_zBins_${zBins}"
rm -r "${result_dir}/${output_dir_name}"
#/bin/python3 ${working_dir}/acts/Examples/Scripts/Python/seeding.py
#/bin/python3 ${working_dir}/acts/Examples/Scripts/Python/full_chain_odd.py --ttbar --events=20
#/bin/python3 ${working_dir}/acts/Examples/Scripts/Python/full_chain_odd_hashing.py --mu=$mu --bucketSize=$bucketSize --seedingAlgorithm=$seedingAlgorithm --nevents=$nevents --saveFiles=$saveFiles --metric=$metric --zBins=$zBins --phiBins=$phiBins --maxSeedsPerSpM=$maxSeedsPerSpM
#/bin/python3 ${working_dir}/acts/Examples/Scripts/Python/hashing_seeding.py --mu=$mu --bucketSize=$bucketSize --seedingAlgorithm=$seedingAlgorithm --nevents=$nevents --saveFiles=$saveFiles --metric=$metric --zBins=$zBins --phiBins=$phiBins --maxSeedsPerSpM=$maxSeedsPerSpM
/bin/python3 ${working_dir}/acts/Examples/Scripts/Python/hashing_seeding.py

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
active_test_dir="ref_03_jul_2024"
active_test_dir="ref_31_jul_2024_hash_41c5a73a2b669ea5889d79c8a7a88318d6e06244"
active_test_dir="ref_31_jul_2024_hash_625f3bcecd5d1738f758983ced1ee41e6d44aee2"
active_test_dir="ref_31_jul_2024_hash_df0e54dc4f4179d213439e2cfbe6c55722c42ed5"
active_test_dir="ref_01_aug_hash_b58a4b404efdc86401e5adb077d8431de4152869"
active_test_dir="ref_01_aug_hash_b2fb7fd1520eee87a99766cf8c8ebacdfb7d0571"
active_test_dir="ref_01_aug_2024_hash_b5f69b99790f5de25aebb740f4f201b79b98a83d"
active_test_dir="ref_01_aug_2024_hash_e10a868ffdc3b8dc13574a47877b5cb591935740"
active_test_dir="ref_06_aug_2024_hash_5ca5ec0bbfcbf98afae83a8a7d29b08cac7834db"
active_test_dir="ref_12_aug_2024_hash_ca697991df842e13f7897cd3f793038860f822c7"
active_test_dir="ref_12_aug_2024_hash_223cba28a59a0c8ce3dbc80782033c1b21f8bd5e"
active_test_dir="ref_14_aug_2024"
active_test_dir="ref_19_aug_2024"
active_test_dir="ref_27_aug_2024_hash_3e934e4babe37d3ca456cb14eb14a8b435bb620c"
active_test_dir="ref_27_aug_2024_hash_09307e45ced2d3734a065e0329cf5a4ba59f5b7b"
active_test_dir="ref_27_aug_2024_hash_cda0b99f2e8a234b3b2ceb7d9c0f1c44357138f4"
active_test_dir="ref_28_aug_2024_hash_5b6ba65ae21528345114b9680b5dd43bbc9bb929"
active_test_dir="ref_30_aug_2024_hash_809b378e51249733567ae24bffe6cdffa9058503"
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
