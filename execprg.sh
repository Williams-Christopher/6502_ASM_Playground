#!/bin/zsh

# TODO:
# Check that .prg file exists / catch typos
# Provide usage output / help
# Argument for optional vice logging?

# Update with parent folder of x64sc
VICE_FOLDER=/Applications/vice

CURRENT_DIR=`pwd`

# $VICE_FOLDER/x64sc.app/Contents/MacOS/x64sc -logfile $CURRENT_DIR/vicelog.log $CURRENT_DIR/$1
$VICE_FOLDER/x64sc.app/Contents/MacOS/x64sc $CURRENT_DIR/$1