#!/bin/sh

git fetch mingw +$1:port
git cherry-pick --empty=drop -Xtheirs port~2..port
git show HEAD~1 HEAD
