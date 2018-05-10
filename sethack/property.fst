# SetHack 1.0   property.fst    $SETH-Date$ $SETH-Branch$   $SETH-Revision$
#
# Copyright (C) 2018 by Jacob Collard
# 
# SetHack may be freely redistributed. See license for details.
#
# This file defines all of the intrinsic and extrinsic properties that may be
# held or granted by characters, monsters, or items. 

define FireResistance "FireResistance";
define ColdResistance "ColdResistance";
define SleepResistance "SleepResistance";
define DisintegrationResistance "DisintegrationResistance";
define ShockResistance "ShockResistance";
define PoisonResistance "PoisonResistance";
define AcidResistance "AcidResistance";
define StoneResistance "StoneResistance";
define DrainResistance "DrainResistance";
define SickResistance "SickResistance";
define Invulnerable "Invulnerable";
define Antimagic "Antimagic";
define Stunned "Stunned";
define Confusion "Confusion";
define Blinded "Blinded";
define Deaf "Deaf";
define Sick "Sick";
define Stoned "Stoned";
define Strangled "Strangled";
define Vomiting "Vomiting";
define Glib "Glib";
define Slimed "Slimed";
define Hallucinating "Hallucinating";
define HallucinationResistance "HallucinationResistance";
define Fumbling "Fumbling";
define WoundedLegs "WoundedLegs";
define Sleepy "Sleepy";
define Hunger "Hunger";
define SeeInvisible "SeeInvisible";
define Telepathy "Telepathy";
define Warning "Warning";
define Warned "Warned";
define WarnUndead "WarnUndead";
define Searching "Searching";
define Clairvoyant "Clairvoyant";
define Infravision "Infravision";
define DetectMonsters "DetectMonsters";
define Adorned "Adorned";
define Invisible "Invisible";
define Displaced "Displaced";
define Stealth "Stealth";
define AggravateMonster "AggravateMonster";
define Conflict "Conflict";
define Jumping "Jumping";
define Teleport "Teleport";
define TeleportControl "TeleportControl";
define Levitation "Levitation";
define Flying "Flying";
define WaterWalking "WaterWalking";
define Swimming "Swimming";
define MagicalBreathing "MagicalBreathing";
define PassWall "PassWall";
define SlowDigestion "SlowDigestion";
define HalfSpellDamage "HalfSpellDamage";
define Regeneration "Regeneration";
define EnergyRegeneration "EnergyRegeneration";
define Protection "Protection";
define ProtectionFromShapeChangers "ProtectionFromShapeChangers";
define Polymorph "Polymorph";
define PolymorphControl "PolymorphControl";
define Unchanging "Unchanging";
define Fast "Fast";
define Reflection "Reflection";
define FreeAction "FreeAction";
define SustainAbility "SustainAbility";
define LifeSaved "LifeSaved";
define Property FireResistance | ColdResistance | SleepResistance |
                DisintegrationResistance | ShockResistance | PoisonResistance |
                AcidResistance | StoneResistance | DrainResistance |
                SickResistance | Invulnerable | Antimagic | Stunned |
                Confusion | Blinded | Deaf | Sick | Stoned | Strangled | 
                Vomiting | Glib | Slimed | Hallucinating | 
                HallucinationResistance | Fumbling | WoundedLegs | Sleepy | 
                Hunger | SeeInvisible | Telepathy | Warning | Warned | 
                WarnUndead | Searching | Clairvoyant | Infravision |
                DetectMonsters | Adorned | Invisible | Displaced | Stealth |
                AggravateMonster | Conflict | Jumping | Teleport |
                TeleportControl | Levitation | Flying | WaterWalking | 
                Swimming | MagicalBreathing | PassWall | SlowDigestion |
                HalfSpellDamage | Regeneration | EnergyRegeneration |
                Protection | ProtectionFromShapeChangers | Polymorph | 
                PolymorphControl | Unchanging | Fast | Reflecting | 
                FreeAction | SustainAbility | LifeSaved;
define PropertyDisplay Property;
define DisplayProperty(P) P;

#######
#
# Intrinsics
#
#######

# Intrinsic properties are internal to the player rather than granted by a
# physical object.
define Intrinsic "Intrinsic" LB
                 Property    # The property granted by the intrinsic.
                 SEP Integer # The timeout for this intrinsic.
                 SEP Bool    # Whether the intrinsic is gained from class.
                 SEP Bool    # Whether the intrinsic is gained from race.
                 SEP Bool    # Whether the intrinsic was gained from a throne.
                 SEP Bool    # Whether the intrinsic was gained from polymorph.
                 SEP Bool    # Whether the intrinsic is controllable.
                 RB;
define IntrinsicDisplay "Intrinsic"
                        [LB : "("]
                        PropertyDisplay
                        [SEP : ", Timeout: "]
                        IntegerDisplay
                        [SEP : ", FromClass: "]
                        BoolDisplay
                        [SEP : ", FromRace: "]
                        BoolDisplay
                        [SEP : ", FromThrone: "]
                        BoolDisplay
                        [SEP : ", FromPolymorph: "]
                        BoolDisplay
                        [SEP : ", Controllable: "]
                        BoolDisplay
                        [RB : ")"];
define DisplayIntrinsic(I) App(IntrinsicDisplay, I);

#######
#
# Property locations
#
#######

# Properties that are granted by armor.
define PropBodyArmor "PropBodyArmor";
define PropCloak "PropCloak";
define PropHelmet "PropHelmet";
define PropShield "PropShield";
define PropGloves "PropGloves";
define PropFootwear "PropFootwear";
define PropArmor PropBodyArmor | PropCloak | PropHelmet | PropShield |
                 PropGloves | PropFootwear;

# Properties that are granted by weapons.
define PropMainWeapon "PropMainWeapon";
define PropQuiver "PropQuiver";
define PropSwapWeapon "PropSwapWeapon";
define PropWeapon PropMainWeapon | PropQuiver | PropSwapWeapon;

# Properties that are granted by rings
define PropRingLeft "PropRingLeft";
define PropRingRight "PropRingRight";
define PropRing PropRingLeft | PropRingRight

# Properties that are granted by accessories.
define PropAmulet "PropAmulet";
define PropEyewear "PropEyewear"
define PropAccessory PropAmulet | PropRing | PropEyewear;

# Other property location
define PropSaddle "PropSaddle";
define PropBall "PropBall";
define PropChain "PropChain";
define PropertyLocation PropArmor | PropWeapon | PropAccessory | PropSaddle |
                        PropBall | PropChain;
define PropertyLocationDisplay PropertyLocation;
define DisplayPropertyLocation(P) P;

#######
#
# Extrinsics
#
#######

# Extrinsic properties are determined by some object that a creature is
# carrying.
define Extrinsic "Extrinsic" LB 
                 Property             # The property granted by this extrinsic.
                 SEP PropertyLocation # The location of the object granting
                                      # this property.
                 RB;
define ExtrinsicDisplay "Extrinsic"
                        [LB : "("]
                        PropertyDisplay
                        [SEP : ","]
                        PropertyLocationDisplay
                        [RB : ")"];
define DisplayExtrinsic(E) App(ExtrinsicDisplay, E);

#######
#
# Blockers
#
#######

# Blockers temporarily block the use of properties and are granted by an
# object.
define Blocker "Blocker" LB
               Property             # The property to be blocked.
               SEP PropertyLocation # The location of the blocking object.
               RB;
define BlockerDisplay "Blocker"
                      [LB : "("]
                      PropertyDisplay
                      [SEP : ","]
                      PropertyLocationDisplay
                      [RB : ")"];
define DisplayBlocker(B) App(BlockerDisplay, B);

#######
#
# Property instances
#
#######

# In cases where any kind of property is possible, the three kinds of
# properties are disjoined.
define PropertyInstance Intrinsic | Extrinsic | Blocker;
define PropertyInstanceDisplay IntrinsicDisplay | ExtrinsicDisplay | BlockerDisplay;
define DisplayPropertyInstance(I) App(PropertyInstanceDisplay, I);
