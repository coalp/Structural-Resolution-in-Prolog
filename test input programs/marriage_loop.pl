
% married(PersonA,PersonB).
% PersonA is married with PersonB.
married(mia,marsellus).
married(X,Y):- married(Y,X).

% interesting queries:
% ?-clause_tree(married(A,B),_).
% S-resolution: Non-termination
% Prolog: infinite amount of successful search path.

% clause_tree(married(mia,marsellus),_).
% S-resolutioon: Infinite rewriting tree, infinite amount of successful search path.
% Prolog: behaves similar.

% clause_tree(married(tom,janny),_).
% S-resolution: infinite search tree, non-termination.
% Prolog: similar behaviour.
