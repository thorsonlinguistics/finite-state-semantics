# This file defines an extension to Rooth's (2017) finite state semantics that
# allows for the expression of presuppositional content - factive
# presuppositions and definite descriptions.

#######
#
# EXTRA PRIMITIVES
#
#######

# Domain of a relation
define Do(X) X.u;

# Co-domain of a relation.
define Co(X) X.l;

#######
#
# BASIC STRUCTURES
#
#######

# Indices (trace, center, pericenter, null)
define Idx "I0" | "I1" | "I2" | "INull";

# Agents (facing left or right)
define Agent "<" | ">";

# Regular symbols (letters)
define Letter "a" | "b" | "c" | "d";

# Identifiers (may be letters or an agent)
define Id Letter | Agent;

# Knowledge bit
define Kno "K+" | "K-";

# Complete individual - with knowledge bit, identifier, and index
define Individual Kno Id Idx;

# Symbol for True.
define True "True";

# Symbol for False.
define False "False";

# Unvalued base world with exactly one agent.
define WBase Individual^4 & [$. Agent] & [Agent => "K+" _];

# Worlds with center(s) and pericenter(s), but no traces.
define W2 WBase & [$ "I1"] & [$ "I2"] - [$ "I0"];

# Worlds with center(s) but no pericenters or traces.
define W1 WBase & [$ "I1"] - [$ "I2"] - [$ "I0"];

# Worlds with trace(s) but no pericenters (may have centers)
define W0 WBase & [$ "I0"] - [$ "I2"];

# Worlds with no distinguished individuals
define WNull WBase - [$ "I0"] - [$ "I1"] - [$ "I2"];

# All worlds
define W WNull | W0 | W1 | W2;

# All worlds with centers
define WCenter W & [$ "I1"];

# Valued worlds
define WV [True | False] W;

# True-valued worlds
define Wt WV & [True ?*];

# False-valued worlds
define Wf WV & [False ?*];

# Gets all defined (true or false) worlds from a set of valued worlds.
define DefinedWorlds(X) W & Co(X .o. [[[True | False] .x. 0] ?*]);

# Gets all false worlds from a set of valued worlds.
define FalseWorlds(X) DefinedWorlds(X - Wt);

# Gets all true worlds from a set of valued worlds.
define TrueWorlds(X) DefinedWorlds(X - Wf);

# Gets all undefined (neither true nor false) from a set of valued worlds.
define UndefinedWorlds(X) W - DefinedWorlds(X);

# Constructs a simple proposition from an unvalued set of worlds.
define Proposition(X) WV & [[True X] | [False ~X]];

# Rebinds any indices, allowing each index to vary freely.
define ReBind [W .x. W] & [Idx -> Idx];

# Function macro for ReBind.
define DoReBind(X) Co(X .o. ReBind);


#######
#
# INDEFINITES
#
#######

# A transducer for popping centers.
define PopT "I1" -> "INull"   ,,
            "I2" -> "I1"      ,,
            "INull" (->) "I2" ,,
            "I0" (->) "I2";

# Pop as a function macro.
define Pop(X) WV & Co(X .o. PopT);

# Indefinite quantifier.
define Indef(X, Y) [True TrueWorlds(Pop(KAnd(X, Y)))] | 
                   [False FalseWorlds(Pop(KAnd(X, Y))) - DoReBind(FalseWorlds(Pop(KAnd(X, Y))))];

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
define KNot(X) WV & Co(X .o. [[[True .x. False] | [False .x. True]] ?*]);

# Unary presupposition operator (Beaver and Krahmer's (2001) partial operator)
define Presupposition(X) WV & [X - Wf];

# Transplication (binary presupposition)
define Transplicate(X, Y) KOr(KAnd(Presupposition(Y), X), KNot(Presupposition(Y)));

#######
#
# PREDICATES
#
#######

# The center has the identifier X.
define HasId(X) Proposition(WCenter & ["I1" => Kno X _]);

# The center is adjacent to the pericenter.
define Adj Proposition(W2 & [["I1" => "I2" Kno Id _,  _ Kno Id "I2"] &
                             ["I2" => "I1" Kno Id _,  _ Kno Id "I1"]]);

#######
#
# DEFINITES
#
#######

# The given property is unique.
define Unique(X) Proposition(DoReBind(TrueWorlds(X) - DoReBind(TrueWorlds(X) &
                 [?* "I1" ?* "I1" ?*]))) - UndefinedWorlds(X); 

# The definite article "quantifier".
define Def(X, Y) Transplicate(Indef(X, Y), Unique(X));

#######
#
# FACTIVE KNOWLEDGE
#
#######

# A transducer which allows letters to vary freely in case they have not been
# observed by the agent.
define R0 Id -> Id || "K-" _;

# The knowledge relation.
define R [W .x. W] & R0;

# True component of knowledge
define KBase(X) True [W - Do(R .o. FalseWorlds(X))];

# Valued component of knowledge
define KV(X) WV & [KBase(X) | [False (W - DefinedWorlds(KBase(X)))]];

# Knowledge with factive presupposition
define KP(X) Transplicate(KV(X), X);

#######
#
# EXAMPLES
#
#######

# A "c" is next to a "d".
define Example11 Indef(HasId("c"), Indef(HasId("d"), Adj));

# The agent knows that a "c" is next to a "d".
define Example15 KP(Example11);

# The "c" is next to a "d".
define Example22 Def(HasId("c"), Def(HasId("d"), Adj));
