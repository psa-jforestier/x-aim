#!/bin/bash
export REL=./release
mkdir -p $REL
cp xaim.exe $REL/
cp *.png $REL/
cp README.md $REL/
cp LICENSE $REL/
zip xaim-git-release.zip $REL/*

