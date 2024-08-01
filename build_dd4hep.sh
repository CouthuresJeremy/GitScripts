# Install DD4HEP:

## might help for ERROR: failed to load libDDG4LCIO.so.1.23: libG4ptl.so.2: cannot open shared object file: No such file or directory
#sudo ldconfig
#ldconfig -p | grep "libicu"
## Tricks:
#find / -name libicudata.so.* 2>/dev/null
#sudo cp /home/couthures/anaconda3/lib/libicuuc.so.58 /usr/local/lib/libicuuc.so.58
#sudo cp /home/couthures/anaconda3/lib/libicudata.so.58 /usr/local/lib/libicudata.so.58
#export LD_LIBRARY_PATH=/usr/local/lib/:$LD_LIBRARY_PATH

## install from source:
source ~/softwares_install/root_install/bin/thisroot.sh
cd /home/couthures/Bureau/DD4hep-01-27
#cd /home/couthures/Bureau/DD4hep
mkdir build
cd build/
export LD_LIBRARY_PATH=/usr/local/lib/:$LD_LIBRARY_PATH
#cmake -DDD4HEP_USE_GEANT4=ON -DBoost_NO_BOOST_CMAKE=ON -DDD4HEP_USE_LCIO=ON -DBUILD_TESTING=ON -DROOT_DIR=$ROOTSYS -DLCIO_DIR=/home/couthures/softwares_install/LCIO -D CMAKE_BUILD_TYPE=Release ..
#cmake -DDD4HEP_USE_GEANT4=ON -DBoost_NO_BOOST_CMAKE=ON -DDD4HEP_USE_LCIO=ON -DBUILD_TESTING=ON -DROOT_DIR=$ROOTSYS -DLCIO_DIR=/home/couthures/softwares_install/LCIO -DDD4HEP_USE_GEANT4_UNITS=ON -D CMAKE_BUILD_TYPE=Release ..
cmake -DCMAKE_CXX_STANDARD=20 -DDD4HEP_USE_GEANT4=ON -DBoost_NO_BOOST_CMAKE=ON -DDD4HEP_USE_LCIO=ON -DBUILD_TESTING=ON -DROOT_DIR=$ROOTSYS -DLCIO_DIR=/home/couthures/softwares_install/LCIO -DDD4HEP_USE_GEANT4_UNITS=OFF -D CMAKE_BUILD_TYPE=Release .. || exit 1
make -j $(nproc); notify-send "Command Finished" "Your command has completed its execution."
make install
cp -r ../cmake cmake
cp -r ../include include
