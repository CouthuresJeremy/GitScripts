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

references_dir="/home/couthures/Bureau/HashingWork/results/tests/References"
active_test_dir="ref_9_jan_2024_to_check"
active_test_dir="ref_18_jan_2024_to_check"
active_test_dir="ref_28_mar_2024_to_check"
active_test_dir="ref_10_apr_2024_hash_1df91751ccfa8eb4ff61c2d10554208c089cd089_to_check"
active_test_dir="ref_11_apr_2024_hash_69f72174dce3bd8153f459a7acb5ff437d2345fb"
active_test_dir="ref_25_apr_2024_hash_e0633f32a4f274313e8be1dc2c1020f742e5ebcf"
active_test_dir="ref_25_apr_2024"
active_test_dir="ref_12_aug_2024_hash_223cba28a59a0c8ce3dbc80782033c1b21f8bd5e"
active_test_dir=${references_dir}/${active_test_dir}

output_dir_name="detector_generic_output_hashing_mu_${mu}_bucket_${bucketSize}_maxSeedsPerSpM_${maxSeedsPerSpM}_seedFinderConfig_TrackML_seedingAlgorithm_${seedingAlgorithm}_metric_${metric}_annoySeed_123456789_zBins_${zBins}"
test_dir_name=ref_${output_dir_name}
test_dir_name=${output_dir_name}

#/bin/python3 ~/Bureau/Codes/Scripts/compare_directories.py --dir1="$result_dir/$output_dir_name" --dir2="${PWD}/../ref_tests_repro_sept/$output_dir_name" --verbose=True

/bin/python3 ~/Bureau/Codes/Scripts/compare_directories.py --dir1="$result_dir/$output_dir_name" --dir2="${active_test_dir}/${test_dir_name}" --verbose=True
#/bin/python3 ~/Bureau/Codes/Scripts/compare_directories.py --dir1="$result_dir/$output_dir_name" --dir2="${active_test_dir}/${test_dir_name}" --verbose=True --called_by_script
if [[ $? -eq 0 ]]; then
    echo Good commit
    exit 0  # Good commit
else
    echo Bad commit
    exit 1  # Bad commit
fi

