# SetHack 1.0   monster.fst $SETH-Date$ $SETH-Branch$   $SETH-Revision$
# 
# Copyright (C) 2018 by Jacob Collard
#
# SetHack may be freely redistributed. See license for details.
#
# This file defines all possible monsters in NetHack, including both monster
# species and instances.

#######
#
# Symbols
#
#######

# Every class of monsters is represented by a shared ASCII symbol. Not all
# possible symbols are used.
define MonsterSymbol "a" | "b" | "c" | "d" | "e" | "f" | "g" | "h" | "i" |
                     "j" | "k" | "l" | "m" | "n" | "o" | "p" | "q" | "r" |
                     "s" | "t" | "u" | "v" | "w" | "x" | "y" | "z" | "A" |
                     "B" | "C" | "D" | "E" | "F" | "G" | "H" | "I" | "J" |
                     "K" | "L" | "M" | "N" | "O" | "P" | "Q" | "R" | "S" |
                     "T" | "U" | "V" | "W" | "X" | "Y" | "Z" | "'" | "@" |
                     " " | "&" | ";" | ":";
define MonsterSymbolDisplay MonsterSymbol;
define DisplayMonsterSymbol(S) S;

#######
#
# Generation Flags
#
#######

# Generation flags determine where and how individuals of a particular species
# are generated.
define GenoFlags "GenoFlags"
                 LB Trait(Bool)  # Is the monster unique?
                 SEP Trait(Bool) # Is the monster not generated in hell?
                 SEP Trait(Bool) # Is the monster generated only in hell?
                 SEP Trait(Bool) # Is the monster never generated normally?
                 SEP Trait(Bool) # Does the monster appear in small groups?
                 SEP Trait(Bool) # Does the monster appear in large groups?
                 SEP Trait(Bool) # Can the monster be genocided?
                 SEP Trait(Bool) # Does the monster never leave a corpse?
                 SEP Bool        # Has the monster been encountered?
                 SEP Trait(Bool) # Has the monster been genocided?
                 SEP Trait(Bool) # Has the monster gone extinct?
                 RB;
define GenoFlagsDisplay "GenoFlags"
                        [LB : "("]
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
                        TraitDisplay(BoolDisplay)
                        [SEP : ","]
                        BoolDisplay
                        [SEP : ","]
                        TraitDisplay(BoolDisplay)
                        [SEP : ","]
                        TraitDisplay(BoolDisplay)
                        [RB : ")"];
define DisplayGenoFlags(F) App(GenoFlagsDisplay, F);

#######
#
# Attacks
#
#######

# Each species may have up to six attacks, which are defined by various
# properties.

# Attack types. This specifies how the attack is made (with a weapon, venomous
# spit, a spell, etc.).
define FakeAttack "FakeAttack";
define ClawAttack "ClawAttack";
define BiteAttack "BiteAttack";
define ButtAttack "ButtAttack";
define TouchAttack "TouchAttack";
define StingAttack "StingAttack";
define HugAttack "HugAttack";
define SpitAttack "SpitAttack";
define EngulfAttack "EngulfAttack";
define BreathAttack "BreathAttack";
define ExplodeAttack "ExplodeAttack";
define BoomAttack "BoomAttack";
define GazeAttack "GazeAttack";
define TentacleAttack "TentacleAttack";
define WeaponAttack "WeaponAttack";
define SpellAttack "SpellAttack";
define AttackType FakeAttack | ClawAttack | BiteAttack | ButtAttack |
                  TouchAttack | StingAttack | HugAttack | SpitAttack | 
                  EngulfAttack | BreathAttack | ExplodeAttack | BoomAttack |
                  GazeAttack | TentacleAttack | WeaponAttack | SpellAttack;
define AttackTypeDisplay AttackType;
define DisplayAttackType(A) App(AttackTypeDisplay, A);

# Damage types, which impact resistances and secondary effects.
define FakeDamage "FakeDamage";
define PhysicalDamage "PhysicalDamage";
define MagicMissileDamage "MagicMissileDamage";
define FireDamage "FireDamage";
define FrostDamage "FrostDamage";
define SleepDamage "SleepDamage";
define DisintegrationDamage "DisintegrationDamage";
define ShockDamage "ShockDamage";
define DrainStrengthDamage "DrainStrengthDamage";
define AcidDamage "AcidDamage";
define BuzzDamage1 "BuzzDamage1";
define BuzzDamage2 "BuzzDamage2";
define BlindDamage "BlindDamage";
define StunDamage "StunDamage";
define SlowDamage "SlowDamage";
define ParalysisDamage "ParalysisDamage";
define DrainLifeDamage "DrainLifeDamage";
define LegDamage "LegDamage";
define PetrifyDamage "PetrifyDamage";
define StickyDamage "StickyDamage";
define StealGoldDamage "StealGoldDamage";
define SeduceDamage "SeduceDamage";
define TeleportDamage "TeleportDamage";
define RustDamage "RustDamage";
define ConfuseDamage "ConfuseDamage";
define DigestDamage "DigestDamage";
define HealDamage "HealDamage";
define EelDamage "EelDamage";
define LycanthropyDamage "LycanthropyDamage";
define DrainDexterityDamage "DrainDexterityDamage";
define DrainConstitutionDamage "DrainConstitutionDamage";
define DrainIntelligenceDamage "DrainIntelligenceDamage";
define DiseaseDamage "DiseaseDamage";
define DecayDamage "DecayDamage";
define SuccubusDamage "SuccubusDamage";
define HallucinationDamage "HallucinationDamage";
define DeathDamage "DeathDamage";
define PestilenceDamage "PestilenceDamage";
define FamineDamage "FamineDamage";
define GreenSlimeDamage "GreenSlimeDamage";
define RemoveEnchantmentDamage "RemoveEnchantmentDamage";
define CorrodeDamage "CorrodeDamage";
define ClericalSpellDamage "ClericalSpellDamage";
define MagicSpellDamage "MagicSpellDamage";
define BreathWeaponDamage "BreathWeaponDamage";
define StealAmuletDamage "StealAmuletDamage";
define CurseDamage "CurseDamage";
define DamageType FakeDamage | PhysicalDamage | MagicMissileDamage |
                  FireDamage | FrostDamage | SleepDamage | 
                  DisintegrationDamage | ShockDamage | DrainStrengthDamage |
                  AcidDamage | BuzzDamage1 | BuzzDamage2 | BlindDamage | 
                  StunDamage | SlowDamage | ParalysisDamage | 
                  DrainLifeDamage | DrainMagicDamage | LegDamage |
                  PetrifyDamage | StickyDamage | StealGoldDamage |
                  StealItemDamage | SeduceDamage | TeleportDamage | 
                  RustDamage | ConfuseDamage | DigestDamage | HealDamage |
                  EelDamage | LycanthropyDamage | DrainDexterityDamage |
                  DrainConstitutionDamage | DrainIntelligenceDamage | 
                  DiseaseDamage | DecayDamage | SuccubusDamage |
                  HallucinationDamage | DeathDamage | PestilenceDamage |
                  FamineDamage | GreenSlimeDamage | RemoveEnchantmentDamage |
                  CorrodeDamage | ClericalSpellDamage | MagicSpellDamage |
                  BreathWeaponDamage | StealAmuletDamage | CurseDamage;
define DamageTypeDisplay DamageType;
define DisplayDamageType(D) D;

# A normal attack has an attack type, a damage type, and a damage amount
# expressed using dice.
define Attack "Attack"
              LB Trait(AttackType)
              SEP Trait(DamageType)
              SEP Trait(Dice)
              RB;
define AttackDisplay "Attack"
                     [LB : "("]
                     TraitDisplay(AttackTypeDisplay)
                     [SEP : ","]
                     TraitDisplay(DamageTypeDisplay)
                     [SEP : ","]
                     TraitDisplay(DiceDisplay)
                     [RB : ")"];
define DisplayAttack(A) App(AttackDisplay, A);

#######
#
# Sounds
#
#######

# Monsters can each make one type of sound.
define Silent "Silent";
define Bark "Bark";
define Mew "Mew";
define Roar "Roar";
define Growl "Growl";
define Squeak "Squeak";
define Squawk "Squawk";
define Hiss "Hiss";
define Buzz "Buzz";
define Neigh "Neigh";
define Wail "Wail";
define Gurgle "Gurgle";
define Burble "Burble";
define Shriek "Shriek";
define BoneRattle "BoneRattle";
define Laugh "Laugh";
define Mumble "Mumble";
define Imitate "Imitate";
define Grunt "Grunt";
define HumanoidSound "HumanoidSound";
define Arrest "Arrest";
define SoldierSound "SoldierSound";
define GuardSound "GuardSound";
define DjinniSound "DjinniSound";
define NurseSound "NurseSound";
define SeduceSound "SeduceSound";
define VampireSound "VampireSound";
define BribeSound "BribeSound";
define Cuss "Cuss";
define RiderSound "RiderSound";
define LeaderSound "LeaderSound";
define NemesisSound "NemesisSound";
define GuardianSound "GuardianSound";
define SellSound "SellSound";
define OracleSound "OracleSound";
define PriestSound "PriestSound";
define SpellSound "SpellSound";
define WereSound "WereSound";
define BoastSound "BoastSound";
define MonsterSound Silent | Bark | Mew | Roar | Growl | Squeak | Squawk | 
                    Hiss | Buzz | Neigh | Wail | Gurgle | Burble | Shriek |
                    BoneRattle | Laugh | Mumble | Imitate | Grunt | 
                    HumanoidSound | Arrest | SoldierSound | GuardSound |
                    DjinniSound | NurseSound | SeduceSound | VampireSound |
                    BribeSound | Cuss | RiderSound | LeaderSound | 
                    NemesisSound | GuardianSound | SellSound | OracleSound |
                    PriestSound | SpellSound | WereSound | BoastSound;
define SoundDisplay MonsterSound;
define DisplaySound(S) S;

#######
#
# Sizes
#
#######

# There are seven possible monster sizes, ranging from tiny to gigantic.
define Tiny "Tiny";
define Small "Small";
define Medium "Medium";
define Large "Large";
define Huge "Huge";
define Gigantic "Gigantic";
define Size Tiny | Small | Medium | Large | Huge | Gigantic;
define SizeDisplay Size;
define DisplaySize(S) S;

#######
#
# Flags
#
#######

# Flags denote facts about a particular species, such as special abilities. 
define Flies "Flies";
define Swims "Swims";
define Amorphous "Amorphous";
define Wallwalks "Wallwalks";
define Clings "Clings";
define Tunnels "Tunnels";
define Needspick "Needspick";
define Conceals "Conceals";
define Hides "Hides";
define Amphibious "Amphibious";
define Breathless "Breathless";
define NoTake "NoTake";
define NoEyes "NoEyes";
define NoHands "NoHands";
define NoLimbs "NoLimbs";
define NoHead "NoHead";
define Mindless "Mindless";
define Humanoid "Humanoid";
define Animal "Animal";
define Slithy "Slithy";
define Unsolid "Unsolid";
define ThickHide "ThickHide";
define Oviparous "Oviparous";
define Regenerates "Regenerates";
define SeesInvisible "SeesInvisible";
define Teleports "Teleports";
define HasTeleportControl "HasTeleportControl";
define HasAcid "HasAcid";
define Poisonous "Poisonous";
define Carnivore "Carnivore";
define Herbivore "Herbivore";
define Omnivore "Omnivore";
define Metallivore "Metallivore";
define NoPoly "NoPoly";
define Undead "Undead";
define IsWere "IsWere";
define IsHuman "IsHuman";
define IsElf "IsElf";
define IsDwarf "IsDwarf";
define IsGnome "IsGnome";
define IsDemon "IsDemon";
define IsMercenary "IsMercenary";
define IsLord "IsLord";
define IsPrince "IsPrince";
define IsMinion "IsMinion";
define IsGiant "IsGiant";
define IsShapeshifter "IsShapeshifter";
define IsMale "IsMale";
define IsFemale "IsFemale";
define IsNeuter "IsNeuter";
define IsProperName "IsProperName";
define GeneratedHostile "GeneratedHostile";
define GeneratedPeaceful "GeneratedPeaceful";
define Domestic "Domestic";
define Wanders "Wanders";
define Stalks "Stalks";
define Nasty "Nasty";
define Strong "Strong";
define ThrowsRocks "ThrowsRocks";
define Greedy "Greedy";
define LikesJewels "LikesJewels";
define Collects "Collects";
define WantsMagicItems "WantsMagicItems";
define WantsAmulet "WantsAmulet";
define WantsBell "WantsBell";
define WantsBook "WantsBook";
define WantsCandelabrum "WantsCandelabrum";
define WantsArtifact "WantsARtifact";
define WantsAll "WantsAll";
define WaitsForYou "WaitsForYou";
define LetsClose "LetsClose";
define Covetous "Covetous";
define WaitMask "WaitMask";
define HasInfravision "HasInfravision";
define IsInfravisible "IsInfravisible";
define Displaces "Displaces";
define MonsterFlag Flies | Swims | Amorphous | Wallwalks | Clings | Tunnels |
                   Needspick | Conceals | Hides | Amphibious | Breathless |
                   NoTake | NoEyes | NoHands | NoLimbs | NoHead | Mindless |
                   Humanoid | Animal | Slithy | Unsolid | ThickHide |
                   Oviparous | Regenerates | SeesInvisible | Teleports |
                   HasAcid | Poisonous | Carnivore | Herbivore | Omnivore |
                   Metallivore | NoPoly | Undead | IsWere | IsHuman | IsElf |
                   IsDwarf | IsGnome | IsDemon | IsMercenary | IsLord |
                   IsPrince | IsMinion | IsGiant | IsShapeshifter | IsMale |
                   IsFemale | IsNeuter | IsProperName | GeneratedHostile |
                   GeneratedPeaceful | Domestic | Wanders | Stalks | Nasty |
                   Strong | ThrowsRocks | Greedy | LikesJewels | Collects |
                   WantsMagicItems | WantsAmulet | WantsBell | WantsBook |
                   WantsCandelabrum | WantsArtifact | WantsAll | WaitsForYou |
                   LetsClose | Covetous | WaitMask | HasInfravision | 
                   IsInfravisible | Displaces;
define MonsterFlagDisplay MonsterFlag;
define DisplayMonsterFlag(F) F;

#######
#
# Monster Species
#
#######

# The definition of a monster species.
define Species "Species"
               LB BasicString               # The name of the species.
               SEP MonsterSymbol            # Symbol (and by extension, class)
               SEP Trait(UnsignedInteger)   # Difficulty level.
               SEP Trait(UnsignedInteger)   # Base movement rate.
               SEP Trait(Integer)           # Base armor class.
               SEP Trait(UnsignedInteger)   # Base magic resistance.
               SEP Trait(Integer)           # Alignment rating.
               SEP Trait(GenoFlags)         # Flags related to generation.
               SEP Trait(List(Attack))      # Base attacks.
               SEP Trait(UnsignedInteger)   # Corpse weight.
               SEP Trait(UnsignedInteger)   # Nutritional value.
               SEP Trait(MonsterSound)      # The sound this creature makes.
               SEP Trait(Size)              # Base size.
               SEP Trait(List(Property))    # The species' own resistances.
               SEP Trait(List(Property))    # Resistances conferred.
               SEP Trait(List(MonsterFlag)) # Special abilities and features.
               RB;
define SpeciesWithSymbol(S) Species & ["Species" LB BasicString SEP S ?*];
define SpeciesDisplay "Species"
                      [LB : "("] BasicStringDisplay
                      [SEP : ","] MonsterSymbolDisplay
                      [SEP : ","] TraitDisplay(UnsignedIntegerDisplay)
                      [SEP : ","] TraitDisplay(UnsignedIntegerDisplay)
                      [SEP : ","] TraitDisplay(IntegerDisplay)
                      [SEP : ","] TraitDisplay(UnsignedIntegerDisplay)
                      [SEP : ","] TraitDisplay(IntegerDisplay)
                      [SEP : ","] TraitDisplay(GenoFlagsDisplay)
                      [SEP : ","] TraitDisplay(ListDisplay(AttackDisplay))
                      [SEP : ","] TraitDisplay(UnsignedIntegerDisplay)
                      [SEP : ","] TraitDisplay(UnsignedIntegerDisplay)
                      [SEP : ","] TraitDisplay(SoundDisplay)
                      [SEP : ","] TraitDisplay(SizeDisplay)
                      [SEP : ","] TraitDisplay(ListDisplay(PropertyDisplay))
                      [SEP : ","] TraitDisplay(ListDisplay(PropertyDisplay))
                      [SEP : ","] TraitDisplay(ListDisplay(MonsterFlagDisplay))
                      [RB : ")"];
define DisplaySpecies(S) App(SpeciesDisplay, S);
define SimpleSpeciesDisplay ["Species" : 0]
                            [LB : 0]
                            [BasicString : 0]
                            [SEP : 0]
                            MonsterSymbolDisplay
                            [SEP : 0]
                            [Trait(UnsignedInteger) : 0]
                            [SEP : 0]
                            [Trait(UnsignedInteger) : 0]
                            [SEP : 0]
                            [Trait(Integer) : 0]
                            [SEP : 0]
                            [Trait(UnsignedInteger) : 0]
                            [SEP : 0]
                            [Trait(Integer) : 0]
                            [SEP : 0]
                            [Trait(GenoFlags) : 0]
                            [SEP : 0]
                            [Trait(List(Attack)) : 0]
                            [SEP : 0]
                            [Trait(UnsignedInteger) : 0]
                            [SEP : 0]
                            [Trait(UnsignedInteger) : 0]
                            [SEP : 0]
                            [Trait(MonsterSound) : 0]
                            [SEP : 0]
                            [Trait(Size) : 0]
                            [SEP : 0]
                            [Trait(List(Property)) : 0]
                            [SEP : 0]
                            [Trait(List(Property)) : 0]
                            [SEP : 0]
                            [Trait(List(MonsterFlag)) : 0]
                            [RB : 0];
define DisplaySpeciesSimple(S) App(SimpleSpeciesDisplay, S);

#######
#
# Monsters
#
#######

# An individual monster instance.
define Monster "Monster"
               LB Species                    # The monster's species.
               SEP Trait(Species)            # Original monster species (for
                                             # shapeshifters).
               SEP Trait(Integer)            # Current movement points.
               SEP Trait(UnsignedInteger)    # Difficulty level.
               SEP Trait(UnsignedInteger)    # The monster's relative alignment.
               SEP Trait(Coordinate)         # Where the monster thinks the player is.
               SEP Trait(UnsignedInteger)    # Current HP.
               SEP Trait(UnsignedInteger)    # Maximum HP.
               SEP Trait(Object)             # Item disguised as (for mimics).
               SEP Trait(UnsignedInteger)    # Tameness level.
               SEP Trait(List(Property))     # Intrinsics and extrinsics.
               SEP Trait(Bool)               # Female.
               SEP Trait(Bool)               # Currently invisible.
               SEP Trait(Bool)               # Permanently invisible.
               SEP Trait(Bool)               # Cancelled.
               SEP Trait(Bool)               # Is buried.
               SEP Trait(Bool)               # The monster can see.
               SEP Trait(UnsignedInteger)    # Current speed.
               SEP Trait(UnsignedInteger)    # Intrinsic speed.
               SEP Trait(Bool)               # Has been revived.
               SEP Trait(Bool)               # Has been cloned.
               SEP Trait(Bool)               # Did something to deserve retaliation.
               SEP Trait(Bool)               # Is fleeing.
               SEP Trait(UnsignedInteger)    # How scared the monster is.
               SEP Trait(Bool)               # Asleep until woken.
               SEP Trait(UnsignedInteger)    # Is temporarily blinded.
               SEP Trait(Bool)               # Is stunned.
               SEP Trait(UnsignedInteger)    # How frozen the monster is.
               SEP Trait(Bool)               # Is paralyzed.
               SEP Trait(Bool)               # Is confused.
               SEP Trait(Bool)               # Is peaceful.
               SEP Trait(Bool)               # Is trapped.
               SEP Trait(Bool)               # Is leashed.
               SEP Trait(Bool)               # Is a shopkeeper.
               SEP Trait(Bool)               # Is a minion.
               SEP Trait(Bool)               # Is a guard.
               SEP Trait(Bool)               # Is a priest.
               SEP Trait(Bool)               # Is the Wizard of Yendor.
               SEP Trait(List(Object))       # The monster's inventory.
               SEP Trait(Object)             # The monster's current weapon.
               SEP Trait(Bool)               # True if the monster is eating.
               RB;
define MonsterWithSpecies(S) Monster & ["Monster" LB S ?* RB];
define MonsterWithSymbol(S) MonsterWithSpecies(SpeciesWithSymbol(S));
define MonsterDisplay "Monster"
                      [LB : "("] SpeciesDisplay
                      [SEP : ","] TraitDisplay(SpeciesDisplay)
                      [SEP : ","] TraitDisplay(IntegerDisplay)
                      [SEP : ","] TraitDisplay(UnsignedIntegerDisplay)
                      [SEP : ","] TraitDisplay(UnsignedIntegerDisplay)
                      [SEP : ","] TraitDisplay(CoordinateDisplay)
                      [SEP : ","] TraitDisplay(UnsignedIntegerDisplay)
                      [SEP : ","] TraitDisplay(UnsignedIntegerDisplay)
                      [SEP : ","] TraitDisplay(ObjectDisplay)
                      [SEP : ","] TraitDisplay(UnsignedIntegerDisplay)
                      [SEP : ","] TraitDisplay(ListDisplay(PropertyDisplay))
                      [SEP : ","] TraitDisplay(BoolDisplay)
                      [SEP : ","] TraitDisplay(BoolDisplay)
                      [SEP : ","] TraitDisplay(BoolDisplay)
                      [SEP : ","] TraitDisplay(BoolDisplay)
                      [SEP : ","] TraitDisplay(BoolDisplay)
                      [SEP : ","] TraitDisplay(BoolDisplay)
                      [SEP : ","] TraitDisplay(UnsignedIntegerDisplay)
                      [SEP : ","] TraitDisplay(UnsignedIntegerDisplay)
                      [SEP : ","] TraitDisplay(BoolDisplay)
                      [SEP : ","] TraitDisplay(BoolDisplay)
                      [SEP : ","] TraitDisplay(BoolDisplay)
                      [SEP : ","] TraitDisplay(BoolDisplay)
                      [SEP : ","] TraitDisplay(UnsignedIntegerDisplay)
                      [SEP : ","] TraitDisplay(BoolDisplay)
                      [SEP : ","] TraitDisplay(UnsignedIntegerDisplay)
                      [SEP : ","] TraitDisplay(BoolDisplay)
                      [SEP : ","] TraitDisplay(UnsignedIntegerDisplay)
                      [SEP : ","] TraitDisplay(BoolDisplay)
                      [SEP : ","] TraitDisplay(BoolDisplay)
                      [SEP : ","] TraitDisplay(BoolDisplay)
                      [SEP : ","] TraitDisplay(BoolDisplay)
                      [SEP : ","] TraitDisplay(BoolDisplay)
                      [SEP : ","] TraitDisplay(BoolDisplay)
                      [SEP : ","] TraitDisplay(BoolDisplay)
                      [SEP : ","] TraitDisplay(BoolDisplay)
                      [SEP : ","] TraitDisplay(BoolDisplay)
                      [SEP : ","] TraitDisplay(BoolDisplay)
                      [SEP : ","] TraitDisplay(ListDisplay(ObjectDisplay))
                      [SEP : ","] TraitDisplay(ObjectDisplay)
                      [SEP : ","] TraitDisplay(BoolDisplay)
                      [RB : ")"];
define DisplayMonster(M) App(MonsterDisplay, M);
define SimpleMonsterDisplay ["Monster" : 0]
                      [LB : 0] SimpleSpeciesDisplay
                      [SEP : 0] [Trait(Species) : 0]
                      [SEP : 0] [Trait(Integer) : 0]
                      [SEP : 0] [Trait(UnsignedInteger) : 0]
                      [SEP : 0] [Trait(UnsignedInteger) : 0]
                      [SEP : 0] [Trait(Coordinate) : 0]
                      [SEP : 0] [Trait(UnsignedInteger) : 0]
                      [SEP : 0] [Trait(UnsignedInteger) : 0]
                      [SEP : 0] [Trait(Object) : 0]
                      [SEP : 0] [Trait(UnsignedInteger) : 0]
                      [SEP : 0] [Trait(List(Property)) : 0]
                      [SEP : 0] [Trait(Bool) : 0]
                      [SEP : 0] [Trait(Bool) : 0]
                      [SEP : 0] [Trait(Bool) : 0]
                      [SEP : 0] [Trait(Bool) : 0]
                      [SEP : 0] [Trait(Bool) : 0]
                      [SEP : 0] [Trait(Bool) : 0]
                      [SEP : 0] [Trait(UnsignedInteger) : 0]
                      [SEP : 0] [Trait(UnsignedInteger) : 0]
                      [SEP : 0] [Trait(Bool) : 0]
                      [SEP : 0] [Trait(Bool) : 0]
                      [SEP : 0] [Trait(Bool) : 0]
                      [SEP : 0] [Trait(Bool) : 0]
                      [SEP : 0] [Trait(UnsignedInteger) : 0]
                      [SEP : 0] [Trait(Bool) : 0]
                      [SEP : 0] [Trait(UnsignedInteger) : 0]
                      [SEP : 0] [Trait(Bool) : 0]
                      [SEP : 0] [Trait(UnsignedInteger) : 0]
                      [SEP : 0] [Trait(Bool) : 0] 
                      [SEP : 0] [Trait(Bool) : 0] 
                      [SEP : 0] [Trait(Bool) : 0] 
                      [SEP : 0] [Trait(Bool) : 0] 
                      [SEP : 0] [Trait(Bool) : 0] 
                      [SEP : 0] [Trait(Bool) : 0] 
                      [SEP : 0] [Trait(Bool) : 0] 
                      [SEP : 0] [Trait(Bool) : 0] 
                      [SEP : 0] [Trait(Bool) : 0] 
                      [SEP : 0] [Trait(Bool) : 0] 
                      [SEP : 0] [Trait(List(Object)) : 0] 
                      [SEP : 0] [Trait(Object) : 0]
                      [SEP : 0] [Trait(Bool) : 0]
                      [RB : 0];
define DisplayMonsterSimple(M) App(SimpleMonsterDisplay, M);
