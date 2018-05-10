# SetHack 1.0   feature.fst $SETH-Date$ $SETH-Branch$   $SETH-Revision$
# 
# Copyright (C) 2018 by Jacob Collard
# 
# SetHack may be freely redistributed. See license for details.
#
# This file defines dungeon features, which are fixed elements of the
# game-board. They may have temporary states, but the features themselves
# typically cannot be removed.

#######
#
# Stairs and ladders
#
#######

# Stairs and ladders are cosmetically different, but are effectively the same
# thing. Both use an index and branch name to determine where they lead.
define Staircase "Staircase";
define Ladder "Ladder";
define StairType Staircase | Ladder;
define StairTypeDisplay StairType;
define DisplayStairType(T) T;

define UpStair "UpStair";
define DownStair "DownStair";
define StairDirection UpStair | DownStair;
define StairDirectionDisplay StairDirection;
define DisplayStairDirection(D) D;

define Stair "Stair"
             LB StairType           # The type of stair (staircase or ladder).
             SEP StairDirection     # The stair direction (up or down).
             SEP Trait(BasicString) # The branch the stairs lead to.
             SEP Trait(Integer)     # The level the stairs lead to.
             RB; 
define StairDisplay "Stair"
                    [LB : "("] StairTypeDisplay
                    [SEP : ","] StairDirectionDisplay
                    [SEP : ","] TraitDisplay(BasicStringDisplay)
                    [SEP : ","] TraitDisplay(IntegerDisplay)
                    [RB : ")"];
define DisplayStair(S) App(StairDisplay, S);
define SimpleStairDisplay ["Stair" : 0]
                          [LB : 0] [StairType : 0]
                          [SEP : 0] [[UpStair : "<"] | [DownStair : ">"]]
                          [SEP : 0] [Trait(BasicString) : 0]
                          [SEP : 0] [Trait(Integer) : 0]
                          [RB : 0];
define DisplayStairSimple(S) App(SimpleStairDisplay, S);

#######
#
# Altars
#
#######

# An altar is defined by its alignment.
define Altar "Altar" LB Alignment RB;
define AltarDisplay "Altar" [LB : "("] AlignmentDisplay [RB : ")"];
define DisplayAltar(A) App(AltarDisplay, A);
define SimpleAltarDisplay ["Altar" : "_"] [LB : 0] [Alignment : 0] [RB : 0];
define DisplayAltarSimple(A) App(SimpleAltarDisplay, A);

#######
#
# Fountains
#
#######

# Fountains can be either magical or non-magical.
define Fountain "Fountain" LB Bool # Whether the fountain is magical.
                           RB;
define FountainDisplay "Fountain" [LB : "("] BoolDisplay [RB : ")"];
define DisplayFountain(F) App(FountainDisplay, F);
define SimpleFountainDisplay ["Fountain" : "⌠"] [LB : 0] [Bool : 0] [RB : 0];
define DisplayFountainSimple(F) App(SimpleFountainDisplay, F);
 
#######
#
# Traps
#
#######

# The general kind of trap that we're dealing with.
define ArrowTrap "ArrowTrap";
define DartTrap "DartTrap";
define RockTrap "RockTrap";
define SqueakyBoard "SqueakyBoard";
define BearTrap "BearTrap";
define Landmine "Landmine";
define RollingBoulderTrap "RollingBoulderTrap";
define SleepGasTrap "SleepGasTrap";
define RustTrap "RustTrap";
define FireTrap "FireTrap";
define Pit "Pit";
define SpikedPit "SpikedPit";
define Hole "Hole";
define Trapdoor "Trapdoor";
define TeleportTrap "TeleportTrap";
define LevelTeleporter "LevelTeleporter";
define MagicPortal "MagicPortal";
define Web "Web";
define StatueTrap "StatueTrap";
define MagicTrap "MagicTrap";
define PolymorphTrap "PolymorphTrap";
define VibratingSquare "VibratingSquare";
define TrapType ArrowTrap | DartTrap | RockTrap | SqueakyBoard | BearTrap |
                Landmine | RollingBoulderTrap | SleepGasTrap | RustTrap |
                FireTrap | Pit | SpikedPit | Hole | Trapdoor | TeleportTrap |
                LevelTeleporter | MagicPortal | Web | StatueTrap | MagicTrap |
                PolymorphTrap | VibratingSquare;
define TrapTypeDisplay TrapType;
define DisplayTrapType(T) T;

# Squeaky boards play a particular note when stepped on.
define CNote "CNote";
define DFlat "DFlat";
define DNote "DNote";
define EFlat "EFlat";
define ENote "ENote";
define FNote "FNote";
define FSharp "FSharp";
define GNote "GNote";
define GSharp "GSharp";
define ANote "ANote";
define BFlat "BFlat";
define BNote "BNote";
define Note CNote | DFlat | DNote | EFlat | ENote | FNote | FSharp | GNote |
            GSharp | ANote | BFlat | BNote;
define NoteDisplay Note;
define DisplayNote(N) N;

define Trap "Trap"
            LB TrapType            # The kind of trap.
            SEP Trait(BasicString) # The dungeon branch that portals point to.
            SEP Trait(Integer)     # The dungeon level that portals point to.
            SEP Trait(Bool)        # If the trap only triggers once.
            SEP Trait(Bool)        # If the player made the trap.
            SEP Trait(Coordinate)  # Base launch coordinate.
            SEP Trait(Coordinate)  # Secondary launch coordinate.
            SEP Trait(Coordinate)  # The note that boards play.
            RB;
define TrapDisplay "Trap"
                   [LB : "("] TrapTypeDisplay
                   [SEP : ","] TraitDisplay(BasicStringDisplay)
                   [SEP : ","] TraitDisplay(IntegerDisplay)
                   [SEP : ","] TraitDisplay(BoolDisplay)
                   [SEP : ","] TraitDisplay(BoolDisplay)
                   [SEP : ","] TraitDisplay(CoordinateDisplay)
                   [SEP : ","] TraitDisplay(CoordinateDisplay)
                   [SEP : ","] TraitDisplay(CoordinateDisplay)
                   [RB : ")"];
define DisplayTrap(T) App(TrapDisplay, T);
define SimpleTrapDisplay ["Trap" : "^"]
                         [LB : 0] [TrapType : 0]
                         [SEP : 0] [Trait(BasicString) : 0]
                         [SEP : 0] [Trait(Integer) : 0]
                         [SEP : 0] [Trait(Bool) : 0]
                         [SEP : 0] [Trait(Bool) : 0]
                         [SEP : 0] [Trait(Coordinate) : 0]
                         [SEP : 0] [Trait(Coordinate) : 0]
                         [SEP : 0] [Trait(Coordinate) : 0]
                         [RB : 0];
define DisplayTrapSimple(T) App(SimpleTrapDisplay, T);

#######
#
# Doors
#
#######

# Doors can be open or closed, locked or unlocked, and may be trapped or
# broken. They may also be hidden.
define Door "Door" LB Bool         # Whether the door is open.
                   SEP Trait(Bool) # Whether the door is locked.
                   SEP Trait(Bool) # Whether the door is trapped.
                   SEP Bool        # Whether the door is destroyed.
                   RB;
define DoorDisplay "Door" 
                   [LB : "("] BoolDisplay
                   [SEP : ","] TraitDisplay(BoolDisplay)
                   [SEP : ","] TraitDisplay(BoolDisplay)
                   [SEP : ","] BoolDisplay
                   [RB : ")"];
define DisplayDoor(D) App(DoorDisplay, D);
define SimpleDoorDisplay ["Door" : 0]
                         [LB : 0] [[True : "-"] | [False : "+"]]
                         [SEP : 0] [Trait(Bool) : 0]
                         [SEP : 0] [Trait(Bool) : 0]
                         [SEP : 0] [Bool : 0]
                         [RB : 0];
define DisplayDoorSimple(D) App(SimpleDoorDisplay, D);

#######
#
# Walls
#
#######

# Walls are defined by their direction (vertical, horizontal, cross).
define VerticalWall "VerticalWall";
define HorizontalWall "HorizontalWall";
define CrossWall "CrossWall";
define Wall VerticalWall | HorizontalWall | CrossWall;
define WallDisplay Wall;
define DisplayWall(W) W;
define SimpleWallDisplay ["VerticalWall" : "|"] | ["HorizontalWall" : "-"] |
                         ["CrossWall" : "+"];
define DisplayWallSimple(W) App(SimpleWallDisplay, W);

#######
#
# Drawbridges
#
#######

# Drawbridges can be open or closed, and locked or unlocked.
define Drawbridge "Drawbridge" LB Bool  # Whether the drawbridge is open.
                               SEP Trait(Bool) # Whether the drawbridge is locked.
                               RB;
define DrawbridgeDisplay "Drawbridge" 
                         [LB : "("] BoolDisplay
                         [SEP : ","] TraitDisplay(BoolDisplay)
                         [RB : ")"];
define DisplayDrawbridge(D) App(DrawbridgeDisplay, D);
define SimpleDrawbridgeDisplay ["Drawbridge" : 0]
                               [LB : 0] [[True : "."] | [False : "#"]]
                               [SEP : 0] [Trait(Bool) : 0]
                               [RB : 0];
define DisplayDrawbridgeSimple(D) App(SimpleDrawbridgeDisplay, D);

#######
#
# Ice
#
#######

# Ice may melt after a certain number of turns, though some ice is permanent.
define Ice "Ice"
           LB Trait(UnsignedInteger) # Number of turns before the ice melts.
           SEP Trait(Bool)           # If the ice is permanent.
           RB;
define IceDisplay "Ice"
                  [LB : "("] TraitDisplay(UnsignedIntegerDisplay)
                  [SEP : ","] TraitDisplay(BoolDisplay)
                  [RB : ")"];
define DisplayIce(I) App(IceDisplay, I);
define SimpleIceDisplay ["Ice" : "."]
                        [LB : 0] [Trait(UnsignedInteger) :0]
                        [SEP : 0] [Trait(Bool) : 0]
                        [RB : 0];
define DisplayIceSimple(I) App(SimpleIceDisplay, I);

#######
#
# Other Features
#
#######

# These features require no extra data.
define Sink "Sink";
define Tree "Tree";
define Doorway "Doorway";
define IronBars "IronBars";
define Floor "Floor";
define Corridor "Corridor";
define Throne "Throne";
define Grave "Grave";
define Water "Water";
define Lava "Lava";
define Cloud "Cloud";
define Air "Air";
define SolidRock "SolidRock";
define Pool "Pool";
define Moat "Moat";
define NoFeature "NoFeature";

define SinkDisplay Sink;
define SimpleSinkDisplay [Sink : "#"];
define TreeDisplay Tree;
define SimpleTreeDisplay [Tree : "#"];
define DoorwayDisplay Doorway;
define SimpleDoorwayDisplay [Doorway : "."];
define IronBarsDisplay IronBars;
define SimpleIronBarsDisplay [IronBars : "#"];
define FloorDisplay Floor;
define SimpleFloorDisplay [Floor : "."];
define CorridorDisplay Corridor;
define SimpleCorridorDisplay [Corridor : "▒"];
define ThroneDisplay Throne;
define SimpleThroneDisplay [Throne : "\"];
define GraveDisplay Grave;
define SimpleGraveDisplay [Grave : "|"];
define WaterDisplay Water;
define SimpleWaterDisplay [Water : "}"];
define LavaDisplay Lava;
define SimpleLavaDisplay [Lava : "}"];
define CloudDisplay Cloud;
define SimpleCloudDisplay [Cloud : "#"];
define AirDisplay Air;
define SimpleAirDisplay [Air : " "];
define SolidRockDisplay SolidRock;
define SimpleSolidRockDisplay [SolidRock : " "];
define PoolDisplay Pool;
define SimplePoolDisplay [Pool : "}"];
define MoatDisplay Moat;
define SimpleMoatDisplay [Moat : "}"];
define NoFeatureDisplay NoFeature;
define SimpleNoFeatureDisplay [NoFeature : "."];

#######
#
# Dungeon Features
#
#######

# A dungeon feature is a fixed game element.
define DungeonFeature Stair | Altar | Sink | Fountain | Tree | Trap |
                      Door | Doorway | Wall | Drawbridge | IronBars | Floor |
                      Corridor | Throne | Grave | Water | Ice | Lava | Cloud |
                      Air | SolidRock | Pool | Moat | NoFeature;
define DungeonFeatureDisplay StairDisplay | AltarDisplay | SinkDisplay | 
                             FountainDisplay | TreeDisplay | TrapDisplay |
                             DoorDisplay | DoorwayDisplay | WallDisplay | 
                             DrawbridgeDisplay | IronBarsDisplay | 
                             FloorDisplay | CorridorDisplay | ThroneDisplay |
                             GraveDisplay | WaterDisplay | IceDisplay | 
                             LavaDisplay | CloudDisplay | AirDisplay | 
                             SolidRockDisplay | PoolDisplay | MoatDisplay |
                             NoFeatureDisplay;
define DisplayDungeonFeature(F) App(DungeonFeatureDisplay, F);
define SimpleDungeonFeatureDisplay SimpleStairDisplay |
                                   SimpleAltarDisplay |
                                   SimpleSinkDisplay |
                                   SimpleFountainDisplay |
                                   SimpleTreeDisplay |
                                   SimpleTrapDisplay |
                                   SimpleDoorDisplay |
                                   SimpleDoorwayDisplay |
                                   SimpleWallDisplay |
                                   SimpleDrawbridgeDisplay |
                                   SimpleIronBarsDisplay |
                                   SimpleFloorDisplay |
                                   SimpleCorridorDisplay |
                                   SimpleThroneDisplay |
                                   SimpleGraveDisplay |
                                   SimpleWaterDisplay |
                                   SimpleIceDisplay |
                                   SimpleLavaDisplay |
                                   SimpleCloudDisplay |
                                   SimpleAirDisplay |
                                   SimpleSolidRockDisplay |
                                   SimplePoolDisplay |
                                   SimpleMoatDisplay |
                                   SimpleNoFeatureDisplay;
define DisplayDungeonFeatureSimple(F) App(SimpleDungeonFeatureDisplay, F);
