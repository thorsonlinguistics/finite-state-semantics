# SetHack 1.0   main.fst    $SETH-Date$ $SETH-Branch$   $SETH-Revision$
#
# Copyright (C) 2018 by Jacob Collard
# 
# SetHack may be freely distributed. See license for details.
# 
# This is the highest-level automata file; it organizes the other automata
# file. The order of these sources is very important, as the files depend on
# one another.

# Primitives should always be the first file included.
source primitives.fst

# The order of the remaining files should typically remain fixed, but can be
# modified in certain situations. 
source hunger.fst
source alignment.fst
source property.fst
source skill.fst
source object.fst
source monster.fst
source feature.fst
source level.fst

# This file is last, as it defines actual language features. 
source language.fst

#regex DebugLevel(WCenter);
#echo "LEVELS:"
#print words
