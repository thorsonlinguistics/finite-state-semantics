# SetHack 1.0   level.fst   $SETH-Date$ $SETH-Branch$   $SETH-Revision$
#
# Copyright (C) 2018 by Jacob Collard
# 
# SetHack may be freely redistributed. See license for details.
#
# This file defines all possible dungeon levels in NetHack.

#######
#
# Individuals and Indices
#
#######

# An index indicates the discourse role of an individual.
define Center "Center";
define Pericenter "Pericenter";
define Trace "Trace";
define NullIndex "NullIndex";
define Idx Center | Pericenter | Trace | NullIndex;
define IndexDisplay Idx;
define DisplayIndex(I) I;
define IndexDebug [Center : "1"] | [Pericenter : "2"] | [Trace : "0"] |
                  [NullIndex : "."];
define DebugIndex(I) App(IndexDebug, I);

# Everything that may appear on a square is an individual, having the ability
# to be identified as an e-type element in the grammar. Individuals are based
# around some more specific type, such as Monster or DungeonFeature.
define Individual(Type) Kno Type Idx;
define IndividualDisplay(Type) [0 : "Individual("]
                               KnowledgeBitDisplay
                               Type
                               IndexDisplay
                               [0 : ")"];
define DisplayIndividual(Type, I) App(IndividualDisplay(Type), I);
define SimpleIndividualDisplay(Type) [Kno : 0]
                                     Type
                                     [Idx : 0];
define DisplayIndividualSimple(Type, I) App(SimpleIndividualDisplay(Type), I);
define IndividualDebug(Type) KnowledgeBitDebug
                             Type
                             IndexDebug;
define DebugIndividual(Type, I) App(IndividualDebug(Type), I);

# All individual types
define IndividualType Option(Monster) | DungeonFeature | List(Object) | String;

# Macros for accessing components of individuals.
define MakeIndividual(B, T, I) B T I;
define IndividualWithKnowledge(Bit, Type) Bit Type Idx;
define IndividualWithType(T, Type) Kno T Idx;
define IndividualWithIndex(I) Kno IndividualType I;
define IndividualWithIndex(I, Type) Kno Type I;

#######
#
# Squares
#
#######

# Squares are the primary building blocks for NetHack levels. Each square can
# contain a monster, a dungeon feature, a list of items, and an engraving.
define Square "Square" LB Individual(Option(Monster)) # The monster in this square.
                       SEP Individual(DungeonFeature) # The dungeon feature in this square.
                       SEP Individual(List(Object))   # All objects in this square.
                       SEP Individual(String)         # The engraving in this square.
                       RB;
define SquareDisplay "Square"
                     [LB : "("] IndividualDisplay(OptionDisplay(MonsterDisplay))
                     [SEP : ","] IndividualDisplay(DungeonFeatureDisplay)
                     [SEP : ","] IndividualDisplay(ListDisplay(ObjectDisplay))
                     [SEP : ","] IndividualDisplay(StringDisplay)
                     [RB : ")"];
define DisplaySquare(S) App(SquareDisplay, S);
# If there's a monster, it should appear on top.
define SimpleSquare0 ["Square" : 0] [LB : 0]
                     SimpleIndividualDisplay(SimpleMonsterDisplay)
                     [SEP : 0]
                     [Individual(DungeonFeature) : 0]
                     [SEP : 0]
                     [Individual(List(Object)) : 0]
                     [SEP : 0]
                     [Individual(String) : 0]
                     [RB : 0];
define SquareDebug0 ["Square" : 0] [LB : 0]
                    IndividualDebug(SimpleMonsterDisplay)
                    [SEP : 0]
                    [Individual(DungeonFeature) : 0]
                    [SEP : 0]
                    [Individual(List(Object)) : 0]
                    [SEP : 0]
                    [Individual(String) : 0]
                    [RB : 0];
# Then one object.
define SimpleSquare1 ["Square" : 0] [LB : 0]
                     [Individual("NULL") : 0]
                     [SEP : 0]
                     [Individual(DungeonFeature) : 0]
                     [SEP : 0]
                     SimpleIndividualDisplay(ListDisplayOne(SimpleObjectDisplay))
                     [SEP : 0]
                     [Individual(String) : 0]
                     [RB : 0];
define SquareDebug1 ["Square" : 0] [LB : 0]
                    [Individual("NULL") : 0]
                    [SEP : 0]
                    [Individual(DungeonFeature) : 0]
                    [SEP : 0]
                    IndividualDebug(ListDisplayOne(SimpleObjectDisplay))
                    [SEP : 0]
                    [Individual(String) : 0]
                    [RB : 0];
# Then the dungeon feature.
define SimpleSquare2 ["Square" : 0] [LB : 0]
                     [Individual("NULL") : 0]
                     [SEP : 0]
                     SimpleIndividualDisplay(SimpleDungeonFeatureDisplay)
                     [SEP : 0]
                     [Individual(EmptyList) : 0]
                     [SEP : 0]
                     [Individual(String) : 0]
                     [RB : 0];
define SquareDebug2 ["Square" : 0] [LB : 0]
                    [Individual("NULL") : 0]
                    [SEP : 0]
                    IndividualDebug(SimpleDungeonFeatureDisplay)
                    [SEP : 0]
                    [Individual(EmptyList) : 0]
                    [SEP : 0]
                    [Individual(String) : 0]
                    [RB : 0];
define SimpleSquareDisplay SimpleSquare0 | SimpleSquare1 | SimpleSquare2;
define DisplaySimpleSquare(S) App(SimpleSquareDisplay, S);
define SquareDebug ["Square" : 0] [LB : 0]
                   IndividualDebug(OptionDisplay(SimpleMonsterDisplay))
                   [SEP : "\n"]
                   IndividualDebug(SimpleDungeonFeatureDisplay)
                   [SEP : "\n"]
                   IndividualDebug(ListDisplay(SimpleObjectDisplay))
                   [SEP : 0]
                   [Individual(String) : 0]
                   [RB : "\n-----\n"];
#define SquareDebug SquareDebug0 | SquareDebug1 | SquareDebug2;
define DebugSquare(S) App(SquareDebug, S);
# A square that contains a certain element.
define SquareContains(X) [$ X] & Square;

#######
#
# Rows
#
#######

define NEWLINE "NEWLINE";

# For now, just 5 (should be 75)
define Length "5";

# A row consists of a single row of squares.
define Row _iterate(Square, Length) NEWLINE;
define RowDisplay _iterate(SquareDisplay, Length) [NEWLINE : "\n"];
define DisplayRow(R) App(RowDisplay, R);
define SimpleRowDisplay _iterate(SimpleSquareDisplay, Length) [NEWLINE : "\n"];
define DisplayRowSimple(R) App(SimpleRowDisplay, R);
define RowDebug _iterate(SquareDebug, Length) [NEWLINE : "---------------\n"];
define DebugRow(R) App(RowDebug, R);

#######
#
# Game Board
#
#######

# For now, just 5 (should be 18).
define Height "5";

# The game board consists of several stacked rows.
define GameBoard _iterate(Row, Height);
define GameBoardDisplay _iterate(RowDisplay, Height);
define DisplayGameBoard(B) App(GameBoardDisplay, B);
define SimpleGameBoardDisplay _iterate(SimpleRowDisplay, Height);
define DisplayGameBoardSimple(B) App(SimpleGameBoardDisplay, B);
define GameBoardDebug _iterate(RowDebug, Height);
define DebugGameBoard(B) App(GameBoardDebug, B);

#######
#
# Levels
#
#######

# Each level has a branch name and a few other properties as well as an
# associated game board.
define Level "Level" LB LevelIdentifier # Unique identifier for this level.
                     SEP GameBoard      # The level's contents.
                     SEP Bool           # Eligible for bones.
                     SEP Bool           # Mappable.
                     SEP Bool           # Teleportation allowed.
                     SEP Bool           # Level teleportation allowed.
                     SEP Bool           # Diggable floor.
                     SEP Bool           # Diggable walls.
                     RB;
define LevelWithBoard(B) "Level" LB LevelIdentifier
                                 SEP B
                                 SEP Bool
                                 SEP Bool
                                 SEP Bool
                                 SEP Bool
                                 SEP Bool
                                 SEP Bool
                                 RB;
define LevelDisplay "Level"
                    [LB : "("] LevelIdentifierDisplay
                    [SEP : ","] GameBoardDisplay
                    [SEP : ","] BoolDisplay
                    [SEP : ","] BoolDisplay
                    [SEP : ","] BoolDisplay
                    [SEP : ","] BoolDisplay
                    [SEP : ","] BoolDisplay
                    [SEP : ","] BoolDisplay
                    [RB : ")"];
define DisplayLevel(L) App(LevelDisplay, L);
define SimpleLevelDisplay ["Level" : 0] [LB : 0]
                          [LevelIdentifier : 0]
                          [SEP : 0] SimpleGameBoardDisplay
                          [SEP : 0] [Bool : 0]  
                          [SEP : 0] [Bool : 0]  
                          [SEP : 0] [Bool : 0]  
                          [SEP : 0] [Bool : 0]  
                          [SEP : 0] [Bool : 0]  
                          [SEP : 0] [Bool : 0]  
                          [RB : 0];
define DisplayLevelSimple(L) App(SimpleLevelDisplay, L);
define LevelDebug ["Level" : 0] [LB : 0]
                  [LevelIdentifier : 0]
                  [SEP : 0] GameBoardDebug
                  [SEP : 0] [Bool : 0]  
                  [SEP : 0] [Bool : 0]  
                  [SEP : 0] [Bool : 0]  
                  [SEP : 0] [Bool : 0]  
                  [SEP : 0] [Bool : 0]  
                  [SEP : 0] [Bool : 0]  
                  [RB : "---------------------------------------------------------"];
define DebugLevel(L) App(LevelDebug, L);
