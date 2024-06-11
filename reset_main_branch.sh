#!/bin/bash
cd acts
MAIN_BRANCH="main" # Main branch name of the original repository

#git remote add upstream https://gitlab.cern.ch/gfacini/chatDev.git
git checkout "$MAIN_BRANCH"
git fetch upstream
git reset --hard upstream/"$MAIN_BRANCH"
git push origin "$MAIN_BRANCH" --force

