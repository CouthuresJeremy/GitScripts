# Install Geant4:
cd /home/couthures/softwares_install
mkdir geant4-v11.1.2-build && cd geant4-v11.1.2-build
cmake -DCMAKE_CXX_STANDARD=20 -DGEANT4_USE_GDML=on -DGEANT4_INSTALL_DATA=ON -DGEANT4_BUILD_TLS_MODEL=global-dynamic ../geant4-v11.1.2
make -j $(nproc)
sudo make install
