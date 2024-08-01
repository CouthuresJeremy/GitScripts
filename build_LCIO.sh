#git clone https://github.com/iLCSoft/LCIO.git
cd LCIO
git fetch
git pull
#git checkout v02-15-01    ##  use a specific version
git checkout v02-22

source ~/softwares_install/root_install/bin/thisroot.sh
mkdir build
cd build
cmake -DBUILD_ROOTDICT=ON -D CMAKE_CXX_STANDARD=20 ..
make -j $(nproc) install
#cd ..

. ./setup.sh  ## <--- run this in the source directory

make test
