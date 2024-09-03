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

# The following one generate a patch for each commit starting from commit_Id_first (included)
# git format-patch commit_Id_first~..commit_Id_last

# To output only one file:
# git format-patch commit_Id_first~..commit_Id_last --stdout > 0001-Modify-annoy.patch

cd annoy
#git format-patch -1 HEAD
commit_Id_first=535c819bb3566fc9d40b1b1712482518a397c3d9
commit_Id_first=2800224414b9844f9bf10ca1ec7b2941af0e79d2
commit_Id_last=HEAD
git format-patch ${commit_Id_first}~..${commit_Id_last} --stdout > 0001-Modify-annoy.patch
