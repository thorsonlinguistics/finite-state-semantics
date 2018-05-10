# SetHack 1.0   utils.fst   $SETH-Date$ $SETH-Branch$   $SETH-Revision$
#
# Copyright (C) 2018 Jacob Collard
#
# SetHack may be freely redistributed. See license for details.
#
# This file defines the core semantic primitives used by the automaton for
# natural language understanding. 

#######
#
# Relations
#
#######

# The domain of a relation is the upper side of a transducer.
define Do(X) X.u;

# The co-domain of a relation is the lower side of a transducer.
define Co(X) X.l;

# The inverse of a relation is the inverse of a transducer.
define Inv(X) X.i;

#######
#
# Functions
#
#######

# Applies a function to its argument.
define App(F, Arg) [Arg .o. F].l;

#######
#
# Separators
#
#######

# Used to separate distinct values.
define SEP "SEP";

# Used to separate list values.
define LISTSEP "LISTSEP";

# Used to define the left boundary of a value.
define LB "LPAREN";

# Used to define the right boundary of a value.
define RB "RPAREN";

#######
#
# Lists
#
#######

# A list is an automaton containing a sequence of one or more instances of the
# given automaton. The list may also be empty.
define EmptyList "EMPTYLIST";
define List(X) [X [LISTSEP X]*] | EmptyList;
define ListDisplay(X) [[0 : "["] [X [[LISTSEP : ","] X]*] [0 : "]"]] | 
                      [EmptyList : "[]"];
define DisplayList(Typ, L) App(ListDisplay(Typ), L);
define ListDisplayOne(X) [X [[LISTSEP X]* : 0]];

#######
#
# Options
#
#######

# Optional values that should still be represented when null.
define Option(X) "NULL" | X;
define OptionDisplay(X) Option(X);
define DisplayOption(O) O;

#######
#
# Integers
#
#######

# Any single digit other than 0.
define NonzeroDigit ["1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9"];

# Any single digit, including 0.
define Digit ["0" | NonzeroDigit];

# Any non-negative integer.
define UnsignedInteger ["0" | [NonzeroDigit [Digit]*]];
define UnsignedIntegerDisplay UnsignedInteger;
define DisplayUnsignedInteger(UI) UI;

# Adds one to a single digit, with the exception of 9.
define AddOneDigit ["0" : "1"] |
                   ["1" : "2"] |
                   ["2" : "3"] |
                   ["3" : "4"] |
                   ["4" : "5"] |
                   ["5" : "6"] |
                   ["6" : "7"] |
                   ["7" : "8"] |
                   ["8" : "9"];

# A transducer which adds one to any unsigned integer.
define AddOne0 [?* AddOneDigit ["9" : "0"]* ["9" : "0"]] |
               [[0 : "1"] ["9" : "0"]* ["9" : "0"]] |
               [?* AddOneDigit];

# A function macro which adds one to any unsigned integer.
define AddOne(X) App(AddOne0, X) & UnsignedInteger;

# A transducer which adds one to any unsigned integer.
define AddOne0 [?* AddOneDigit ["9" : "0"]* ["9" : "0"]] |
               [[0 : "1"] ["9" : "0"]* ["9" : "0"]] |
               [?* AddOneDigit];

# A function macro which adds one to any unsigned integer.
define AddOne(X) App(AddOne0, X) & UnsignedInteger;

# A transducer which substracts one from any unsigned integer.
define SubtractOne0 Inv(AddOne0);

# A function macro which subtracts one from any unsigned integer.
define SubtractOne(X) App(SubtractOne0, X) & UnsignedInteger;

# Any integer, including negative integers.
define Integer ("-") UnsignedInteger;
define IntegerDisplay Integer;
define DisplayInteger(I) I;

# A pair of unsigned integers representing a coordinate in 2-d space.
define Coordinate LB UnsignedInteger SEP UnsignedInteger RB;
define CoordinateDisplay [LB : "("]
                         UnsignedInteger
                         [SEP : ","]
                         UnsignedInteger
                         [RB : ")"];
define DisplayCoordinate(C) App(CoordinateDisplay, C);

# A function macro for defining a 2-d coordinate.
define Coordinate(X, Y) [LB X SEP Y RB] & Coordinate;

# A triple of unsigned integers representing a coordinate in 3-d space.
define 3DCoordinate LB UnsignedInteger SEP UnsignedInteger SEP
                       UnsignedInteger RB;
define 3DCoordinateDisplay [LB : "("]
                           UnsignedInteger
                           [SEP : ","]
                           UnsignedInteger
                           [SEP : ","]
                           UnsignedInteger
                           [RB : ")"];
define Display3DCoordinate(C) App(3DCoordinateDisplay, C);

# A function macro for defining a 3-d coordinate.
define 3DCoordinate(X, Y, Z) [LB X SEP Y SEP Z RB] & 3DCoordinate;

#######
#
# Decimals
#
#######

# Strength scores in SetHack use the weird decimal system of early D&D games.
define SDecimal LB UnsignedInteger SEP UnsignedInteger RB;
define SDecimalDisplay [LB : 0]
                       UnsignedInteger
                       [SEP : "/"]
                       UnsignedInteger
                       [RB : 0];
define DisplaySDecimal(D) App(SDecimalDisplay, D);

# A function macro for defining a strength-score decimal.
define SDecimal(A, B) [LB A SEP B RB] & SDecimal;

#######
#
# Booleans
#
#######

# A boolean value set to True (1).
define True "1";

# A boolean value set to False (0).
define False "0";

# Any boolean value. 
define Bool [False | True];
define BoolDisplay [[False : "False"] | [True : "True"]];
define DisplayBool(B) App(BoolDisplay, B);

#######
#
# Characters and Strings
#
#######

# A lowercase alphabetic character.
define LowercaseAlphabetic ["a" | "b" | "c" | "d" | "e" | "f" | "g" | "h" | "i"
                          | "j" | "k" | "l" | "m" | "n" | "o" | "p" | "q" | "r"
                          | "s" | "t" | "u" | "v" | "w" | "x" | "u" | "z"];

# An uppercase alphabetic character.
define UppercaseAlphabetic ["A" | "B" | "C" | "D" | "E" | "F" | "G" | "H" | "I"
                          | "J" | "K" | "L" | "M" | "N" | "O" | "P" | "Q" | "R"
                          | "S" | "T" | "U" | "V" | "W" | "X" | "Y" | "Z"];

# A (legal) punctuation characters. Some punctuation characters are legal
# in-game, but dangerous for use in automata, so they are forbidden.
define PunctuationCharacter [" " | "!" | "#" | "$" | "%" | "&" | "'" |
                             "(" | ")" | "*" | "+" | "," | "-" | "," |
                             "/" | ":" | ";" | "<" | "=" | ">" | "?" |
                             "@" | "[" | "]" | "^" | "_" | "`" | "{" |
                             "|" | "}" | "~"];

# Any alphabetic character
define AlphabeticCharacter [LowercaseAlphabetic | UppercaseAlphabetic];

# Any alphanumeric character
define AlphanumericCharacter [AlphabeticCharacter | Digit];

# A "basic string" is a somewhat restricted string that allows only
# alphanumeric characters and spaces. 
define BasicString [AlphanumericCharacter | " "]*;
define BasicStringDisplay BasicString;
define DisplayBasicString(S) S;

# Any string that does not contain a forbidden punctuation character.
define String [AlphanumericCharacter | PunctuationCharacter]*;
define StringDisplay String;
define DisplayString(S) S;

#######
#
# Dice
#
#######

# Dice essentially represent random variables, used in representing, for
# example, the amount of damage that an attack deals. Dice use the standard D&D
# notation of AdB, where A is the number of dice to roll and B is the number of
# faces per die.
define Dice "Dice" LB UnsignedInteger SEP UnsignedInteger RB;
define DiceDisplay ["Dice" : 0]
                   [LB : 0]
                   UnsignedInteger
                   [SEP : "d"]
                   UnsignedInteger
                   [RB : 0];
define DisplayDice(D) App(DiceDisplay, D);

# A function macro for defining a particular dice value.
define Dice(A, B) ["Dice" LB A SEP B RB] & Dice;

#######
#
# Colors
#
#######

# The system colors recognized by the game.
define Black "Black";
define Red "Red";
define Green "Green";
define Brown "Brown";
define Blue "Blue";
define Magenta "Magenta";
define Cyan "Cyan";
define Gray "Gray";
define Colorless "Colorless";
define Orange "Orange";
define BrightGreen "BrightGreen";
define Yellow "Yellow";
define BrightBlue "BrightBlue";
define BrightMagenta "BrightMagenta";
define BrightCyan "BrightCyan";
define White "White";
define MaxWhite "MaxWhite";
define Color Black | Red | Green | Brown | Blue | Magenta | Cyan | Gray |
             Colorless | Orange | BrightGreen | Yellow | BrightBlue | 
             BrightMagenta | BrightCyan | White | MaxWhite;
define ColorDisplay Color;
define DisplayColor(C) C;

# Semantic colors are mapped to system colors.
define GenericColor Magenta;
define MetalColor Gray;
define CopperColor Yellow;
define SilverColor Gray;
define GoldColor Yellow;
define LeatherColor Brown;
define ClothColor Brown;
define WoodColor Brown;
define PaperColor White;
define GlassColor BrightCyan;
define MineralColor Gray;
define DragonSilver BrightCyan;
define ZapColor BrightBlue;
define SemanticColor GenericColor | MetalColor | CopperColor | SilverColor |
                     GoldColor | LeatherColor | ClothColor | WoodColor | 
                     PaperColor | GlassColor | MineralColor | DragonSilver |
                     ZapColor;
define SemanticColorDisplay SemanticColor;
define DisplaySemanticColor(C) C;

#######
#
# UIDS
#
#######

# Unique identifier for dungeon levels.
define LevelIdentifier "LevelIdentifier"
                       LB BasicString  # The name of the level's branch.
                       SEP Integer     # The dungeon level.
                       RB;
define LevelIdentifierDisplay ["LevelIdentifier" : 0]
                              [LB : 0]
                              BasicString
                              [SEP : ", level "]
                              Integer
                              [RB : 0];
define DisplayLevelIdentifier(L) App(LevelIdentifierDisplay, L);

# A function macro for defining a dungeon level identifier.
define LevelIdentifier(A, B) ["LevelIdentifier" LB A SEP B RB] &
                             LevelIdentifier;

#######
#
# Attributes
#
#######

# A character's primary attributes. 
define Attributes "Attributes"
                  LB SDecimal         # Strength
                  SEP UnsignedInteger # Intelligence
                  SEP UnsignedInteger # Wisdom
                  SEP UnsignedInteger # Constitution
                  SEP UnsignedInteger # Dexterity
                  SEP UnsignedInteger # Charisma
                  RB;
define AttributesDisplay ["Attributes" : 0]
                         [LB : 0]
                         [0 : "Str: "]
                         SDecimalDisplay
                         [SEP : 0]
                         [0 : ", Int: "]
                         UnsignedInteger
                         [SEP : 0]
                         [0 : ", Wis: "]
                         UnsignedInteger
                         [SEP : 0]
                         [0 : ", Con: "]
                         UnsignedInteger
                         [SEP : 0]
                         [0 : ", Dex: "]
                         UnsignedInteger
                         [SEP : 0]
                         [0 : ", Cha: "]
                         UnsignedInteger
                         [RB : 0];
define DisplayAttributes(A) App(AttributesDisplay, A);

# A function macro for defining an attribute array.
define Attributes(Str, Int, Wis, Con, Dex, Cha) 
            ["Attributes" LB Str SEP Int SEP Wis SEP Con SEP Dex SEP Cha RB] 
            & Attributes;

######
#
# Knowledge
#
######

# A knowledge bit indicates whether the player has identified an individual or
# trait.
define Kno "K+" | "K-";
define KnowledgeBitDisplay Kno;
define DisplayKnowledgeBit(K) K;
define KnowledgeBitDebug ["K+" : "+"] | ["K-" : "-"];
define DebugKnowledgeBit(K) App(KnowledgeBitDebug, K);

######
#
# Traits
#
######

# Complex objects have traits, which consist of a value of some sort as well as
# information about whether the player has observed that trait.
define Trait(X) Kno LB X RB;
define TraitDisplay(X) Kno LB X RB;
define DisplayTrait(X, T) App(TraitDisplay(X), T);
