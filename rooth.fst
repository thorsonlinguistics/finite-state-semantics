# This file defines a simple version of Rooth's (2017) finite state semantics.
# The basic principles of Rooth's semantics are maintained, with minor
# simplifications to the world model itself.

#######
#
# EXTRA PRIMITIVES
#
#######

# Domain of a relation
define Do(X) X.u;

# Co-domain of a relation
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

# The world consists of four individuals, including exactly one agent, at most
# one center, at most one pericenter, and pericenters imply the existence of a
# center; the agent always knows its own location.
define W Individual^4 & [$. Agent] & [$? "I1"] & [$? "I2"] & [$? "I0"] & 
                        ["I2" => ?* "I1" ?* _ ?*, ?* _ ?* "I1" ?*] & 
                        [Agent => "K+" _];

#######
#
# INDEFINITES
#
#######

# A transducer for popping centers.
define PopT "I1" -> "INull"  ,,
            "I2" -> "I1"     ,,
            "Null" (->) "I2" ,,
            "I0" (->) "I2";

# Pop as a function macro.
define Pop(X) W & Co(X .o. PopT);

# Indefinite quantifier.
define Indef(X, Y) Pop(X & Y);

#######
#
# EPISTEMIC MODALS
#
#######

# A transducer which allows letters to vary freely in case they have not been
# observed by the agent. 
define R0 Id -> Id || "K-" _;

# The knowledge relation.
define R [W .x. W] & R0;

# A function macro which creates a predicate indicating whether the agent knows
# a proposition X.
define K(X) W - Do(R .o. [W - X]);

#######
#
# PREDICATES
#
#######

# The center has the identifier X.
define HasId(X) W & [$ [Kno X "I1"]];

# The center is adjacent to the pericenter.
define Adj W & [$ [Kno Id ["I1" | "I2"] Kno Id ["I1" | "I2"]]];

#######
#
# EXAMPLES
#
#######

# A "c" is adjacent to a "d"
define Example11 Indef(HasId("c"), Indef(HasId("d"), Adj));

# The agent knows that a "c" is adjacent to a "d".
define Example15 K(Example11);
