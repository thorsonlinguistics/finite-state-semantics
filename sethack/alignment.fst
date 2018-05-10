# SetHack 1.0   alignment.fst   $SETH-Date$ $SETH-Branch$   $SETH-Revision$
#
# Copyright (C) 2018 by Jacob Collard
# 
# SetHack may be freely redistributed. See license for details.
#
# This file defines the four possible alignments for creatures and players in
# NetHack.

# A typically "good" character or monster.
define Lawful "Lawful";

# A morally neutral character or monster.
define Neutral "Neutral";

# A typically "evil" character or monster.
define Chaotic "Chaotic";

# An unaligned character (typically equally hostile towards all players).
define Unaligned "Unaligned";

define Alignment Lawful | Neutral | Chaotic | Unaligned;
define AlignmentDisplay Alignment;
define DisplayAlignment(A) App(AlignmentDisplay, A);
