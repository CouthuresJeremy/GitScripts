#!/bin/bash
source ~/softwares_install/root_install/bin/thisroot.sh
source ~/Bureau/DD4hep/build/bin/thisdd4hep.sh

working_dir="/home/couthures/Bureau/HashingWork/Github"

# C++ 17 standard:
#cmake -B ${working_dir}/build -S ${working_dir}/acts -DACTS_BUILD_EXAMPLES=on -DACTS_BUILD_EXAMPLES_PYTHON_BINDINGS=on -DACTS_BUILD_ANALYSIS_APPS=on -DACTS_BUILD_EXAMPLES_PYTHIA8=on -DACTS_BUILD_ODD=on -DACTS_BUILD_PLUGIN_DD4HEP=on -DACTS_BUILD_EXAMPLES_DD4HEP=on -DLD_LIBRARY_PATH=${working_dir}/build/thirdparty/OpenDataDetector/factory -DLCIO_DIR=/home/couthures/softwares_install/LCIO -DPythia8_LIBRARY=/home/couthures/softwares_install/pythia8307/lib/libpythia8.so -DPythia8_INCLUDE_DIR=/home/couthures/softwares_install/pythia8307/include -DACTS_BUILD_PLUGIN_GEANT4=on -DACTS_BUILD_EXAMPLES_GEANT4=on
#cmake --build ${working_dir}/build --parallel $(nproc)
# cmake -B ${working_dir}/build -S ${working_dir}/acts -DACTS_BUILD_EXAMPLES_PYTHON_BINDINGS=on -DACTS_BUILD_ANALYSIS_APPS=on -DACTS_BUILD_EXAMPLES_PYTHIA8=on -DACTS_BUILD_ODD=on -DACTS_BUILD_PLUGIN_DD4HEP=on -DACTS_BUILD_EXAMPLES_DD4HEP=on -DLD_LIBRARY_PATH=${working_dir}/build/thirdparty/OpenDataDetector/factory -DLCIO_DIR=/home/couthures/softwares_install/LCIO -DPythia8_LIBRARY=/home/couthures/softwares_install/pythia8307/lib/libpythia8.so -DPythia8_INCLUDE_DIR=/home/couthures/softwares_install/pythia8307/include -DACTS_BUILD_PLUGIN_GEANT4=on -DACTS_BUILD_EXAMPLES_GEANT4=on

# C++ 20 standard:
cmake -B ${working_dir}/build -S ${working_dir}/acts \
    -DACTS_BUILD_EXAMPLES_PYTHON_BINDINGS=on \
    -DACTS_BUILD_ANALYSIS_APPS=on \
    -DACTS_BUILD_EXAMPLES_PYTHIA8=on \
    -DACTS_BUILD_ODD=off \
    -DACTS_BUILD_PLUGIN_DD4HEP=off \
    -DACTS_BUILD_EXAMPLES_DD4HEP=off \
    -DLD_LIBRARY_PATH=${working_dir}/build/thirdparty/OpenDataDetector/factory \
    -DLCIO_DIR=/home/couthures/softwares_install/LCIO \
    -DPythia8_LIBRARY=/home/couthures/softwares_install/pythia8310/lib/libpythia8.so \
    -DPythia8_INCLUDE_DIR=/home/couthures/softwares_install/pythia8310/include \
    -DACTS_BUILD_PLUGIN_GEANT4=off \
    -DACTS_BUILD_EXAMPLES_GEANT4=off

cmake --build ${working_dir}/build --parallel $(nproc)
compile_success=$?
if [[ $compile_success -eq 0 ]]; then
    echo Good compilation
    exit 0  # Good compilation
else
    notify-send "Command Finished" "Compilation failed."
    exit 1  # Bad compilation
fi
