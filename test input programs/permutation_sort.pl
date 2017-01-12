% delete(X,A,B) := delete element X from list A we get list B.
% delete 2 from [1,2,3,2] we get [1,3].
% Think of predicates as relation (the original meaning of a predicate), and then
% rule shall show an inductive way to generate all triples of this relation.
% If moving X from A we get B, then prefix A with H, and remove X from [H|A],
% what we get?
% Answer: it depends: if H is identical to X, then we still get B; otherwise we get
% [H|B]. For instance, taking the above example,  let X be 2, A be [1,2,3,2] and B
% be [1,3]. If H is 2, then B remains the same. If H is 5, B shall be [5,1,3].

% whether X is instantiated is immarterial.
delete(_,[],[]).
delete(X,[H|A],B) :- H == X, delete(X,A,B).
delete(X,[H|A],[H|B]) :- H \== X, delete(X,A,B).

% my definition for delete/2 is better than that defined in TAP cpt 3 since mine can
% delete arbitrary element including variables from a list of arbitrary list, not
% requiring that the X and A be both ground terms.This is required in TAP since
% other necessary knowledge to make my defintion was not yet introduced.

% delete1/3 removes the first occurance of X from A and the result is returned as B.
delete1(X,[H|A],[H|B]) :- X \== H, delete1(X,A,B).
delete1(X,[H|A],A) :- X == H.
delete1(_,[],[]).

% select/3 selects the first occurrence of an element from list A, removing
% this element from A, resulting in list B.

select(X, [X|T],T).
select(X, [H|T], [H|T2]) :- select(X, T, T2).

% consult the standard order of prolog terms
% http://www.swi-prolog.org/pldoc/man?section=compare
ordered([]).
ordered([_]).
ordered([X,Y|T]) :- X @=< Y, ordered([Y|T]).


permutation(A,[X|C]) :- select(X, A, B), permutation(B, C).
permutation([],[]).

% permutation sort
p_sort(A,C) :- permutation(A,C),ordered(C).
