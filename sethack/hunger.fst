# SetHack 1.0   hunger.fst  $SETH-Date$ $SETH-Branch$   $SETH-Revision$
#
# Copyright (C) 2018 by Jacob Collard
# 
# SetHack may be freely redistributed. See license for details.
#
# This file defines the possible hunger states.

# A satiated character risks choking.
define Satiated "Satiated";

# The default/unmarked hunger state.
define NotHungry "NotHungry";

# The character is hungry and should eat soon.
define Hungry "Hungry";

# The character may begin to see warning messages and risks fainting.
define Weak "Weak";

# A fainting character will often faint while moving.
define Fainting "Fainting";

# The character has fainted from hunger.
define Fainted "Fainted";

# The character has starved to death.
define Starved "Starved";

define HungerLevel Satiated | NotHungry | Hungry | Weak | Fainting | Fainted |
                   Starved;
