#Standard patch (to use with patch):
#diff -u build/_deps/annoy-src/src/annoylib.h ./acts/Core/include/Acts/Seeding/Hashing/Annoylib.hpp > acts/thirdparty/Annoy/0001-Modify-annoylib.patch

### To use git am :
## Clone the repository
# git clone https://github.com/spotify/annoy.git
# cd annoy

## Make the changes

## Commit
# git add .
# git commit -m "Describe your changes here"

## Create patch (option 1):
# git format-patch origin/main --stdout > my_changes.patch
## Create patch (option 2):
# git format-patch -1 HEAD

## Apply the patch:
# git am /path/to/my_changes.patch


