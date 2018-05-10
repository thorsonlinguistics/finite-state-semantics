# SetHack 1.0   skill.fst   $SETH-Date$ $SETH-Branch$   $SETH-Revision$
#
# Copyright (C) 2018 by Jacob Collard
# 
# SetHack may be freely redistributed. See license for details.
# 
# This file defines the skill system used in NetHack.

#######
#
# Combat Skills
#
#######

# Weapon skills.
define DaggerSkill "DaggerSkill";
define KnifeSkill "KnifeSkill";
define AxeSkill "AxeSkill";
define PickaxeSkill "PickaxeSkill";
define ShortswordSkill "ShortswordSkill";
define BroadswordSkill "BroadswordSkill";
define LongswordSkill "LongswordSkill";
define TwohandedSwordSkill "TwohandedSwordSkill";
define ScimitarSkill "ScimitarSkill";
define SaberSkill "SaberSkill";
define ClubSkill "ClubSkill";
define MaceSkill "MaceSkill";
define MorningstarSkill "MorningstarSkill";
define FlailSkill "FlailSkill";
define HammerSkill "HammerSkill";
define QuarterstaffSkill "QuarterstaffSkill";
define PolearmSkill "PolearmSkill";
define SpearSkill "SpearSkill";
define TridentSkill "TridentSkill";
define LanceSkill "LanceSkill";
define BowSkill "BowSkill";
define SlingSkill "SlingSkill";
define CrossbowSkill "CrossbowSkill";
define DartSkill "DartSkill";
define ShurikenSkill "ShurikenSkill";
define BoomerangSkill "BoomerangSkill";
define WhipSkill "WhipSkill";
define UnicornHornSkill "UnicornHornSkill";
define WeaponSkill DaggerSkill | KnifeSkill | AxeSkill | PickaxeSkill | 
                   ShortswordSkill | BroadswordSkill | LongswordSkill |
                   TwohandedSwordSkill | ScimitarSkill | SaberSkill |
                   ClubSkill | MaceSkill | MorningstarSkill | FlailSkill |
                   HammerSkill | QuarterstaffSkill | PolearmSkill |
                   SpearSkill | TridentSkill | LanceSkill | BowSkill |
                   SlingSkill | CrossbowSkill | DartSkill | ShurikenSkill |
                   BoomerangSkill | WhipSkill | UnicornHornSkill;
define WeaponSkillDisplay WeaponSkill;
define DisplayWeaponSkill(S) S;

# Non-weapon combat skills.
define BareHandSkill "BareHandSkill";
define TwoWeaponSkill "TwoWeaponSkill";
define RidingSkill "RidingSkill";
define MartialArtsSkill "MartialArtsSkill";
define CombatSkill BareHandSkill | TwoWeaponSkill | RidingSkill |
                   MartialArtsSkill;
define CombatSkillDisplay CombatSkill;
define DisplayCombatSkill(S) S;

#######
#
# Spell Skills
#
#######

# Skills in the various schools of magic.
define AttackSkill "AttackSkill";
define HealingSkill "HealingSkill";
define DivinationSkill "DivinationSkill";
define EnchantmentSkill "EnchantmentSkill";
define ClericalSkill "ClericalSkill";
define EscapeSkill "EscapeSkill";
define MatterSkill "MatterSkill";
define SpellSkill AttackSkill | HealingSkill | DivinationSkill |
                  EnchantmentSkill | ClericalSkill | EscapeSkill | MatterSkill;

define Skill WeaponSkill | CombatSkill | SpellSkill;
define SkillDisplay Skill;
define DisplaySkill(S) S;
