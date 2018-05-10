# SetHack 1.0   language.fst    $SETH-Date$ $SETH-Branch$   $SETH-Revision$
#
# Copyright (C) 2018 by Jacob Collard
# 
# SetHack may be freely distributed. See license for details.
#
# This file contains linguistic operations for SetHack. These are used in the
# construction of sets of possible worlds with presuppositions for the language
# engine.

set minimal 0

######
#
# Worlds
#
######

# A world with both center(s) and pericenter(s), but no traces.
define W2 Level & [$ Center] & [$ Pericenter] - [$ Trace];

# A world with center(s) but no pericenters or traces.
define W1 Level & [$ Center] - [$ Pericenter] - [$ Trace];

# A world with traces.
define W0 Level & [$ Trace] - [$ Pericenter];

# A world with no traces, centers, or pericenters.
define WNull Level - [$ Trace] - [$ Center] - [$ Pericenter];

# All possible worlds.
define W WNull | W0 | W1 | W2;

# All worlds which contain at least one center.
define WCenter W & [$ Center];

######
#
# Valued Worlds
#
######

# Truth values used for worlds
define PTrue "PTrue";
define PFalse "PFalse";

# Valued worlds
define WV [PTrue | PFalse] W;

# Valued worlds with centering properties
define WV2 [PTrue | PFalse] W2;
define WV1 [PTrue | PFalse] W1;
define WV0 [PTrue | PFalse] W0;
define WVNull [PTrue | PFalse] WNull;
define WVCenter [PTrue | PFalse] WCenter;

# True-valued worlds
define Wt WV & [PTrue ?*];

# False-valued worlds
define Wf WV & [PFalse ?*];

# Gets all defined (true or false) worlds from a set of valued worlds.
define DefinedWorlds(X) W & Co(X .o. [[[PTrue | PFalse] .x. 0] ?*]);

# Gets all false worlds from a set of valued worlds.
define FalseWorlds(X) DefinedWorlds(X - Wt);

# Gets all true worlds from a set of valued worlds.
define TrueWorlds(X) DefinedWorlds(X - Wf);

# Gets all undefined (neither true nor false) worlds from a set of valued
# worlds.
define UndefinedWorlds(X) W - DefinedWorlds(X);

# Constructs a simple proposition from an unvalued set of worlds.
define Proposition(X) WV & [[PTrue X] | [PFalse [WV - X]]];

# Rebinds any indices, allowing each index to vary freely.
define ReBind [Idx -> Idx];

# Function macro for ReBind.
define DoReBind(X) Co(X .o. ReBind);

# Conditional rebinding transducer; only rebinds (peri)centers that do not
# already exist in the world.
define ConditionalReBind1 [[Idx - Center] (->) Pericenter];
define ConditionalReBindV1 [[Idx - Center] (->) Pericenter];
define ConditionalReBindN [Idx (->) [Center | Pericenter]];
define ConditionalReBindNV [Idx (->) [Center | Pericenter]];

# Function macro for conditional rebind.
define DoConditionalReBind(X) [Co([X & W1] .o. ConditionalReBind1) & W] |
                              [Co([X & WV1] .o. ConditionalReBindV1) & WV] |
                              [Co([X & WNull] .o. ConditionalReBindN) & W] |
                              [Co([X & WVNull] .o. ConditionalReBindNV) & WV];

#######
#
# INDEFINITES
#
#######

# A transducer for popping centers.
define PopT Center -> NullIndex ,,
            Pericenter -> Center ,,
            NullIndex (->) Pericenter ,,
            Trace -> Pericenter;

# Pop as a function macro.
define Pop(X) WV & Co(X .o. PopT);

# Indefinite quantifier
define Indef(X, Y) [PTrue TrueWorlds(Pop(KAnd(X, Y)))] | 
                   [PFalse FalseWorlds(Pop(KAnd(X, Y))) - DoReBind(FalseWorlds(Pop(KAnd(X, Y))))];

# A transducer that traces centers and promotes pericenters.
# define Trace0 Center -> NullIndex ,,
#               Pericenter -> Center;

# A function macro that traces centers and promotes pericenters.
# define Trace(X) App(Trace0, X) & Proposition;

# A transducer that binds traces and introduces pericenters.
# define Bind0 Trace (->) Center ,,
#              Center (->) Pericenter ,,
#              NullIndex (->) Pericenter;

# A function macro that binds traces and introduces pericenters.
# define Bind(X) App(Bind0, X) & [Proposition2 | Proposition1];

# A transducer which re-binds traces.
#define ReBind0 Index -> Index;

# A function macro that re-binds traces.
#define ReBind(X) App(Bind0, X) & W;

#######
#
# PRESUPPOSITION
#
#######

# Strong Kleene And
define KAnd(X, Y) WV & [[Wt & X & Y] | [Wf & X] | [Wf & Y]];

# Strong Kleene Or
define KOr(X, Y) WV & [[Wf & X & Y] | [Wt & X] | [Wt & Y]];

# Strong Kleene Not
define KNot(X) WV & Co(X .o. [[[PTrue .x. PFalse] | [PFalse .x. PTrue]] ?*]);

# Unary presupposition operator (Beaver and Krahmer's (2001) partial operator)
define Presupposition(X) WV & [X - Wf];

# Transplication (binary presupposition)
define Transplicate(X, Y) KOr(KAnd(Presupposition(Y), X), KNot(Presupposition(Y)));

#######
#
# DEFINITES
#
#######

# The given property is unique.
define Unique(X) Proposition(DoReBind(TrueWorlds(X) - DoReBind(TrueWorlds(X) &
                 [?* "I1" ?* "I1" ?*]))) - UndefinedWorlds(X); 

# A transducer that adds centers to a world. This transducer guarantees that at
# least one center is added.
define AddCenterT [[[? .x. ?]* [Trace .x. Center] [? .x. ?]*] | 
                   [[? .x. ?]* [Pericenter .x. Center] [? .x. ?]*] |
                   [[? .x. ?]* [NullIndex .x. Center] [? .x. ?]*]] & 
                  [Idx (->) Center];

# Base relation used for calculating Max; relates each world to worlds with one
# more center (if one exists), where the resulting world is still in X.
define MaxR(X) [[X & W] .o. AddCenterT];

# The given property is maximal.
define Max(X) Proposition(TrueWorlds(X) - Do(MaxR(TrueWorlds(X)))) - UndefinedWorlds(X);

# The singular definite article.
define SgDef(X, Y) Transplicate(Indef(X, Y), Unique(X));

# The plural definite article.
define PlDef(X, Y) Transplicate(DoConditionalReBind(Indef(X, Y)), Max(X));

#######
#
# PLURALS
#
#######

# The base for plurality is simply that there are multiple centers.
define PluralBase Proposition([?* "I1" ?* "I1" ?*]);

# The standard plural simply indicates that there must be more than one center
# in each true world.
define Plural(X) KAnd(PluralBase, X);

#######
#
# FACTIVE KNOWLEDGE
#
#######

# A transducer which allows letters to vary freely in case they have not been
# observed by the agent. The knowledge relation.
define R [MakeIndividual("K-", ?*, Center) ->
             MakeIndividual("K-", ?*, Center)] |
         [MakeIndividual("K-", ?*, Pericenter) ->
             MakeIndividual("K-", ?*, Pericenter)] |
         [MakeIndividual("K-", ?*, Trace) ->
             MakeIndividual("K-", ?*, Trace)] |
         [MakeIndividual("K-", ?*, NullIndex) ->
             MakeIndividual("K-", ?*, NullIndex)] |
         [?* -> ?* || "K-" LB _ RB];

# True component of knowledge
define KBase(X) PTrue [W - Do(R .o. FalseWorlds(X))];

# Valued component of knowledge
define KV(X) WV & [KBase(X) | [PFalse (W - DefinedWorlds(KBase(X)))]];

# Knowledge with factive presupposition
define KP(X) Transplicate(KV(X), X);

#######
#
# Predicates
#
#######

# The center is a particular kind of individual.
define Description(X) Proposition(WCenter & [Center => Kno X _]);
#define Description(X) [PTrue [WCenter & [Center => Kno X _]]] |
#                      [PFalse [WCenter & [Center => Kno ~X _]]]; 

# All pericenters are above all centers.
define Above0 SquareContains(IndividualWithIndex(Pericenter)) =>
                    _ [?* NEWLINE ?* SquareContains(IndividualWithIndex(Center))];
define Above1 SquareContains(IndividualWithIndex(Center)) =>
                [SquareContains(IndividualWithIndex(Pericenter)) ?* NEWLINE ?*] _;
define Above Proposition(W2 & Above0 & Above1);

# A predicate indicating that centers are in the position (X, Y). 
define PosRestriction(X, Y) 
            SquareContains(IndividualWithIndex(Center)) => .#. _iterate(Row, SubtractOne(Y))
                                               _iterate(Square, SubtractOne(X))
                                               _ [Square | NEWLINE]* .#.;
                                               #"Square" LB ?* _ ?* RB [Square | NEWLINE]* .#.; 
define Pos(X, Y) Proposition(WCenter & LevelWithBoard(PosRestriction(X, Y))); 

#######
#
# EXAMPLES
#
#######

# A feline is in position (1, 1).
define FelineCorner Indef(Description(MonsterWithSymbol("f")), Pos(1, 1)); 
