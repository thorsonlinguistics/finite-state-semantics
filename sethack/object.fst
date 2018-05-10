# SetHack 1.0   object.fst  $SETH-Date$ $SETH-Branch$   $SETH-Revision$
#
# Copyright (C) 2018 by Jacob Collard
# 
# SetHack may be freely redistributed. See license for details.
#
# This file defines all possible objects in NetHack.

#######
#
# Directionality
# 
#
#######

# Many objects have a "directionality", which determines how they are used.
define WhackDirection "WhackDirection";
define PierceDirection "PierceDirection";
define Nondirectional "Nondirectional";
define ImmediateDirection "ImmediateDirection";
define SlashDirection "SlashDirection";
define RayDirection "RayDirection";
define Directionality WhackDirection | PierceDirection | Nondirectional |
                      ImmediateDirection | SlashDirection | RayDirection;
define DirectionalityDisplay Directionality;
define DisplayDirectionality(D) D;

#######
#
# Materials
#
#######

# Items can be made of any of the following materials.
define Liquid "Liquid";
define Wax "Wax";
define Veggie "Veggie";
define Flesh "Flesh";
define Paper "Paper";
define Cloth "Cloth";
define Leather "Leather";
define Wood "Wood";
define Bone "Bone";
define DragonHide "DragonHide";
define Iron "Iron";
define Metal "Metal";
define Copper "Copper";
define Silver "Silver";
define Gold "Gold";
define Platinum "Platinum";
define Mithril "Mithril";
define Plastic "Plastic";
define Glass "Glass";
define Gemstone "Gemstone";
define Mineral "Mineral";
define Material Liquid | Wax | Veggie | Flesh | Paper | Cloth | Leather |
                Wood | Bone | DragonHide | Iron | Metal | Copper | Silver |
                Gold | Platinum | Mithril | Plastic | Glass | Gemstone |
                Mineral;
define MaterialDisplay Material;
define DisplayMaterial(M) M;
                
#######
#
# Object classes
#
#######

# Objects are given classes that group them into several basic categories.
define IllusoryClass "IllusoryClass";
define WeaponClass "WeaponClass";
define ArmorClass "ArmorClass";
define RingClass "RingClass";
define AmuletClass "AmuletClass";
define ToolClass "ToolClass";
define FoodClass "FoodClass";
define PotionClass "PotionClass";
define ScrollClass "ScrollClass";
define SpellbookClass "SpellbookClass";
define WandClass "WandClass";
define CoinClass "CoinClass";
define GemClass "GemClass";
define RockClass "RockClass";
define BallClass "BallClass";
define ChainClass "ChainClass";
define VenomClass "VenomClass";
define ObjectClass IllusoryClass | WeaponClass | ArmorClass | RingClass |
                   AmuletClass | ToolClass | FoodClass | PotionClass |
                   ScrollClass | SpellbookClass | WandClass | CoinClass |
                   GemClass | RockClass | BallClass | ChainClass | 
                   VenomClass;
define ObjectClassDisplay ObjectClass;
define DisplayObjectClass(C) C;

#######
#
# Position
#
#######

# Even given a fixed location on a particular tile, objects can have different
# positions within a tile, whether they are on the floor, buried, carried by a
# monster, etc.
define FreePosition "FreePosition";
define FloorPosition "FloorPosition";
define ContainedPosition "ContainedPosition";
define InventoryPosition "InventoryPosition";
define MonsterPosition "MonsterPosition";
define MigratingPosition "MigratingPosition";
define BuriedPosition "BuriedPosition";
define BillPosition "BillPosition";
define NoPosition "NoPosition";
define Position FreePosition | FloorPosition | ContainedPosition |
                InventoryPosition | MonsterPosition | MigratingPosition |
                BuriedPosition | BillPosition | NoPosition;
define PositionDisplay Position;
define DisplayPosition(P) P;

#######
#
# Object Types
#
#######

# Object symbols are limited to a subset of characters.
define ObjectSymbol ")" | "[" | "!" | "?" | "/" | "=" | "+" | "*" | 
                    "(" | "`" | "$" | "%" | "0" | "_" | %";
define ObjectSymbolDisplay ObjectSymbol;
define DisplayObjectSymbol(S) S;

# An object type (incorrectly named "object class" in the source) is a basic
# kind of object. Though individal objects within a type may have some unique
# characteristics, they are basically the same kind of thing.
define ObjectType "ObjectType"
                  LB ObjectSymbol            # The object's symbol
                  SEP Trait(BasicString)     # The object's real name.
                  SEP BasicString            # The object's description.
                  SEP String                 # What the player calls this object.
                  SEP Trait(Bool)            # Whether the object merges/stacks.
                  SEP Trait(Bool)            # Whether the object is inherently
                                             # magical.
                  SEP Trait(Bool)            # Whether the object uses charges.
                  SEP Trait(Bool)            # Whether the object is unique.
                  SEP Trait(Bool)            # Whether the object cannot be wished
                                             # for.
                  SEP Trait(Bool)            # Whether the object is bulky.
                  SEP Trait(Bool)            # Whether the object is "tough".
                  SEP Trait(Directionality)  # How the object is used.
                  SEP Trait(Material)        # Material used to make object.
                  SEP Trait(Skill)           # The skill used.
                  SEP Trait(Bool)            # Whether the object is a projectile.
                  SEP Trait(List(Property))  # Properties conveyed.
                  SEP ObjectClass            # Object class/category.
                  SEP Trait(Color)           # Color.
                  SEP Trait(UnsignedInteger) # Weight.
                  SEP Trait(UnsignedInteger) # Base cost.
                  SEP Trait(List(Dice))      # Small damage.
                  SEP Trait(List(Dice))      # Large damage.
                  SEP Trait(Integer)         # To hit or AC bonus.
                  SEP Trait(UnsignedInteger) # Base nutritional value.
                  RB;
define ObjectTypeDisplay "ObjectType"
                         [LB : "("]
                         ObjectSymbolDisplay
                         [SEP : ","]
                         TraitDisplay(BasicStringDisplay)
                         [SEP : ","]
                         BasicStringDisplay
                         [SEP : ","]
                         StringDisplay
                         [SEP : ","]
                         TraitDisplay(BoolDisplay)
                         [SEP : ","]
                         TraitDisplay(BoolDisplay)
                         [SEP : ","]
                         TraitDisplay(BoolDisplay)
                         [SEP : ","]
                         TraitDisplay(BoolDisplay)
                         [SEP : ","]
                         TraitDisplay(BoolDisplay)
                         [SEP : ","]
                         TraitDisplay(BoolDisplay)
                         [SEP : ","]
                         TraitDisplay(BoolDisplay)
                         [SEP : ","]
                         TraitDisplay(DirectionalityDisplay)
                         [SEP : ","]
                         TraitDisplay(MaterialDisplay)
                         [SEP : ","]
                         TraitDisplay(SkillDisplay)
                         [SEP : ","]
                         TraitDisplay(BoolDisplay)
                         [SEP : ","]
                         TraitDisplay(ListDisplay(PropertyDisplay))
                         [SEP : ","]
                         ObjectClassDisplay
                         [SEP : ","]
                         TraitDisplay(ColorDisplay)
                         [SEP : ","]
                         TraitDisplay(UnsignedIntegerDisplay)
                         [SEP : ","]
                         TraitDisplay(UnsignedIntegerDisplay)
                         [SEP : ","]
                         TraitDisplay(ListDisplay(DiceDisplay))
                         [SEP : ","]
                         TraitDisplay(ListDisplay(DiceDisplay))
                         [SEP : ","]
                         TraitDisplay(IntegerDisplay)
                         [SEP : ","]
                         TraitDisplay(UnsignedIntegerDisplay)
                         [RB : ")"];
define DisplayObjectType(O) App(ObjectTypeDisplay, O);
define SimpleObjectTypeDisplay ["ObjectType" : 0]
                         [LB : 0]
                         ObjectSymbolDisplay
                         [SEP : 0]
                         [Trait(BasicString) : 0]
                         [SEP : 0]
                         [BasicString : 0]
                         [SEP : 0]
                         [String : 0]
                         [SEP : 0]
                         [Trait(Bool) : 0]
                         [SEP : 0]
                         [Trait(Bool) : 0]
                         [SEP : 0]
                         [Trait(Bool) : 0]
                         [SEP : 0]
                         [Trait(Bool) : 0]
                         [SEP : 0]
                         [Trait(Bool) : 0]
                         [SEP : 0]
                         [Trait(Bool) : 0]
                         [SEP : 0]
                         [Trait(Bool) : 0]
                         [SEP : 0]
                         [Trait(Directionality) : 0]
                         [SEP : 0]
                         [Trait(Material) : 0]
                         [SEP : 0]
                         [Trait(Skill) : 0]
                         [SEP : 0]
                         [Trait(Bool) : 0]
                         [SEP : 0]
                         [Trait(List(Property)) : 0]
                         [SEP : 0]
                         [ObjectClass : 0]
                         [SEP : 0]
                         [Trait(Color) : 0]
                         [SEP : 0]
                         [Trait(UnsignedInteger) : 0]
                         [SEP : 0]
                         [Trait(UnsignedInteger) : 0]
                         [SEP : 0]
                         [Trait(List(Dice)) : 0]
                         [SEP : 0]
                         [Trait(List(Dice)) : 0]
                         [SEP : 0]
                         [Trait(Integer) : 0]
                         [SEP : 0]
                         [Trait(UnsignedInteger) : 0]
                         [RB : 0];
define DisplayObjectTypeSimple(O) App(SimpleObjectTypeDisplay, O);

#######
#
# Objects
#
#######

# An instance of an object.
define Object "Object"
              LB ObjectType
              SEP UnsignedInteger        # The type of object this is.
              SEP Trait(UnsignedInteger) # Quantity of items in a stack.
              SEP Trait(Integer)         # Bonus or charges, etc.
              SEP Trait(Position)        # Relative position.
              SEP Trait(Bool)            # Cursed.
              SEP Trait(Bool)            # Blessed.
              SEP Trait(Bool)            # Unpaid.
              SEP Trait(Bool)            # Shopkeeper won't charge.
              SEP Trait(Bool)            # Rusted/burnt.
              SEP Trait(Bool)            # Corroded/rotten.
              SEP Trait(Bool)            # Erodeproof.
              SEP Trait(Bool)            # Locked.
              SEP Trait(Bool)            # Lock has been broken.
              SEP Trait(Bool)            # Trapped.
              SEP Trait(UnsignedInteger) # Number of recharges left.
              SEP Trait(Bool)            # Is a light source.
              SEP Trait(Bool)            # Globby.
              SEP Trait(Bool)            # Greased.
              SEP Trait(Bool)            # Has been thrown by the player.
              SEP Trait(UnsignedInteger) # Remaining nutrition.
              SEP BasicString            # Name of the monster that dropped a
                                         # corpse.
              RB;
define ObjectDisplay "Object"
                     [LB : "("]
                     ObjectTypeDisplay
                     [SEP : ","]
                     UnsignedIntegerDisplay
                     [SEP : ","]
                     [TraitDisplay(UnsignedIntegerDisplay)]
                     [SEP : ","]
                     [TraitDisplay(IntegerDisplay)]
                     [SEP : ","]
                     [TraitDisplay(PositionDisplay)]
                     [SEP : ","]
                     [TraitDisplay(BoolDisplay)]
                     [SEP : ","]
                     [TraitDisplay(BoolDisplay)]
                     [SEP : ","]
                     [TraitDisplay(BoolDisplay)]
                     [SEP : ","]
                     [TraitDisplay(BoolDisplay)]
                     [SEP : ","]
                     [TraitDisplay(BoolDisplay)]
                     [SEP : ","]
                     [TraitDisplay(BoolDisplay)]
                     [SEP : ","]
                     [TraitDisplay(BoolDisplay)]
                     [SEP : ","]
                     [TraitDisplay(BoolDisplay)]
                     [SEP : ","]
                     [TraitDisplay(BoolDisplay)]
                     [SEP : ","]
                     [TraitDisplay(BoolDisplay)]
                     [SEP : ","]
                     [TraitDisplay(UnsignedIntegerDisplay)]
                     [SEP : ","]
                     [TraitDisplay(BoolDisplay)]
                     [SEP : ","]
                     [TraitDisplay(BoolDisplay)]
                     [SEP : ","]
                     [TraitDisplay(BoolDisplay)]
                     [SEP : ","]
                     [TraitDisplay(BoolDisplay)]
                     [SEP : ","]
                     [TraitDisplay(UnsignedIntegerDisplay)]
                     [SEP : ","]
                     BasicStringDisplay
                     [RB : ")"];
define DisplayObject(O) App(ObjectDisplay, O);
define SimpleObjectDisplay ["Object" : 0]
                     [LB : 0]
                     SimpleObjectTypeDisplay
                     [SEP : 0]
                     [UnsignedInteger : 0]
                     [SEP : 0]
                     [Trait(UnsignedInteger) : 0]
                     [SEP : 0]
                     [Trait(Integer) : 0]
                     [SEP : 0]
                     [Trait(Position) : 0]
                     [SEP : 0]
                     [Trait(Bool) : 0]
                     [SEP : 0]
                     [Trait(Bool) : 0]
                     [SEP : 0]
                     [Trait(Bool) : 0]
                     [SEP : 0]
                     [Trait(Bool) : 0]
                     [SEP : 0]
                     [Trait(Bool) : 0]
                     [SEP : 0]
                     [Trait(Bool) : 0]
                     [SEP : 0]
                     [Trait(Bool) : 0]
                     [SEP : 0]
                     [Trait(Bool) : 0]
                     [SEP : 0]
                     [Trait(Bool) : 0]
                     [SEP : 0]
                     [Trait(Bool) : 0]
                     [SEP : 0]
                     [Trait(UnsignedInteger) : 0]
                     [SEP : 0]
                     [Trait(Bool) : 0]
                     [SEP : 0]
                     [Trait(Bool) : 0]
                     [SEP : 0]
                     [Trait(Bool) : 0]
                     [SEP : 0]
                     [Trait(Bool) : 0]
                     [SEP : 0]
                     [Trait(UnsignedInteger) : 0]
                     [SEP : 0]
                     [BasicString : 0]
                     [RB : 0];
define DisplayObjectSimple(O) App(SimpleObjectDisplay, O);
