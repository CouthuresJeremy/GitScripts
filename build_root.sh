## Build ROOT (for specific C++ standard)
# https://root.cern/install/#build-from-source
# https://root.cern/install/dependencies/#ubuntu-and-other-debian-based-distributions
# https://root.cern/install/build_from_source/#external-and-built-in-dependencies

## Required packages
# sudo apt-get install binutils cmake dpkg-dev g++ gcc libssl-dev git libx11-dev \
# libxext-dev libxft-dev libxpm-dev python3 libtbb-dev libvdt-dev

## Most common optional packages (not necessary with builtin_all=ON ?)
# sudo apt-get install gfortran libpcre3-dev \
# libglu1-mesa-dev libglew-dev libftgl-dev \
# libfftw3-dev libcfitsio-dev libgraphviz-dev \
# libavahi-compat-libdnssd-dev libldap2-dev \
# python3-dev python3-numpy libxml2-dev libkrb5-dev \
# libgsl-dev qtwebengine5-dev nlohmann-json3-dev libmysqlclient-dev

# need also CURL:
# sudo apt-get install libcurl4-openssl-dev

cd /home/couthures/softwares_install

# Branch or Tag
branch=latest-stable
#branch=v6-30-08
#branch=v6-30-06
#branch=v6-30-00
#branch=v6-30-00-patches
#branch=v6-28-12

# git log --grep=Updated

#git clone --branch $branch --depth=1 https://github.com/root-project/root.git root_src
git clone --branch $branch  --single-branch https://github.com/root-project/root.git root_src

cd root_src
# branch v6-30-06
commit_hash=076446fd1711a7556e262e60d53c42c0788fb602
commit_hash=eb11674537735199c8466bc6d5cb31a79e0d5a32
#commit_hash=latest-stable
git checkout $commit_hash
cd ..

mkdir root_build root_install
cd root_build

## Works with v6-32-02 (82b3f69c86e48963e5666b18f03a163bab44b958)
#cmake -DCMAKE_CXX_STANDARD=20 -DCMAKE_INSTALL_PREFIX=../root_install ../root_src


#cmake -DCMAKE_CXX_STANDARD=20 -DCMAKE_INSTALL_PREFIX=../root_install -D builtin_all=ON -D builtin_openssl=OFF ../root_src
cmake -DCMAKE_CXX_STANDARD=20 -DCMAKE_INSTALL_PREFIX=../root_install -D builtin_all=ON -D davix=OFF -D builtin_davix=OFF ../root_src

cmake --build . -- install -j$(nproc) # if you have 4 cores available for compilation
source ../root_install/bin/thisroot.sh # or thisroot.{fish,csh}
