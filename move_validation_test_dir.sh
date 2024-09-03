mv 



#!/bin/bash

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

references_dir="/home/couthures/Bureau/HashingWork/results/tests/References"
active_test_dir="ref_30_aug_2024_hash_809b378e51249733567ae24bffe6cdffa9058503"
active_test_dir=${references_dir}/${active_test_dir}

test_dir_name=${output_dir_name}

dir1="${result_dir}/${output_dir_name}"
dir2="${active_test_dir}/${test_dir_name}"
mkdir ${active_test_dir} || exit 1
mv ${dir1} ${dir2}
touch ${active_test_dir}/comments.txt
