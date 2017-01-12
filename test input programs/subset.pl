/*:- module(subset,[memberc/2,
                  memberf/2,
                  subsetc/2,
                  subsetf/2,
                  extend/3,
                  extend2/3,
                  powerset/2,
                  powerset2/2,
                  list2set/2]). */
:- use_module(library(lists),[append/3]).
% subset(Subset,Set).
% there is no check to ensure that Subset and Set, if they are provided, are both
% lists without redundant elements.

% member(Elem,List) List membership check.

% Adding a cut to the first clause ensures that when the predicate
% is called with both arguments instantiated, and when the left most occurrence
% of Elem in the List is found, the programs stops.
% However, this cut causes the predicate not being able to find all members of a
% set, when Set is instantiated but Subset is not. The solution is that we
% distinguish the version with cut (we call it memberc/2, where c stands for check,
% or cut) and the version without cut (we call it memberf/2, where f stands for
% "find", indicating that this version is suitable to find all members
% of a list).
memberc(H,[H|_]) :- !.
memberc(X,[_|T]) :- memberc(X,T).

memberf(H,[H|_]).
memberf(X,[_|T]) :- memberf(X,T).


% the subset/2 shall be again defined in two versions: subsetc/2 and subsetf/2.
% subsetc/2 uses memberc/2 and merely carries out a membership check, and it
% not good at generating subsets for a given set.
subsetc([], _). % The empty set is the subset of all sets.
subsetc([H|T],Set) :- memberc(H,Set), subsetc(T,Set).

% To find all subsets of a given set Set, it becomes necessary to reduce
% Set to a real set by removing any redundant elements. Then the sublist
% based on append/3 could be used to get subset.
% It is easier to let the user to make sure the input argument is a genuine set.

accList2set([],Acc,Acc).
accList2set([H|T],Acc,S) :- \+ memberc(H,Acc),!, accList2set(T,[H|Acc],S).
accList2set([_|T],Acc,S) :- accList2set(T,Acc,S).
% L must be instantiated for calling.
list2set(L,S) :- accList2set(L,[],S).

% the sublist/2 predicate based on append/3 could only return continous
% sublist.

/*
subsetf(Subset,Set) :- list2set(Set,S), subsetf2(Subset,S).
subsetf(Subsubset,S) :- subsetf2(Subset,S), subsetf2(Subsubset,Subset).
% subsetf2/2 is helper for subsetf/2.

subsetf2(Subset,S) :- bagof(T,permutation(S,[_|T]),[Subset|_]).
*/
% I consulted the definition of a library predicate which could compute
% the power set of a given set. The code remarks says that the power set
% of a set, is the power set of a set of one smaller, together with the
% set of one smaller where each subset is extended by the new element.
% (source: http://www.swi-prolog.org/pldoc/doc/swi/library/oset.pl)


% psetSrc/2 stores the power set of those sets that smaller by one,
% two, etc than the set in discourse.
% To compute the power set of a given set, we start from building the
% power sets of smaller subsets. For instance,
% to compute the power set of [a,b,c,d], we first compute the power set
% of [a], then pset of [a,b], then [a,b,c] and finally [a,b,c,d].

% Set shall not have dupilcating members.

powerset2([H|T],PSet) :- powerset2(T, PSet_T), extend(H,PSet_T,PSet_ex),
                        append(PSet_T,PSet_ex,PSet).
powerset2([],[[]]).

% Acc shall be initialised as [[]]. Acc stores the powerset of the set one smaller.
accPowerset([H|T],Acc,PSet) :-
       extend(H,Acc,ExAcc),
       append(ExAcc,Acc,NewAcc),
       accPowerset(T,NewAcc,PSet).
accPowerset([],A,A).

powerset(Set,PSet) :- accPowerset(Set,[[]],PSet).

% It seems that a left recursion could often be replaced by a right recursion
% using an accumulator


% the second arg of extend shall be a non-empty list of lists.
extend2(X,[H|T],[[X|H]|L]) :- extend2(X,T,L),!.
extend2(_,[],[]).
% extend using accumulator to reduce the bookkeeping overhead of recursion.
extend(X,L,XL) :- accExtend(X,L,[],XL).
accExtend(_,[], A,A) :- !.
accExtend(X,[H|T],Acc,L) :- accExtend(X,T,[[X|H]|Acc],L).
% Running trace to compare extend/2 and extend2/2, we could see that
% extend/2 has only one variable going down in the trace while extend2/2
% has new variable defined for each step downwards.


subsetf(Subset,Set) :- powerset(Set,PSet),memberf(Subset,PSet).
