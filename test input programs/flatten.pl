
% flatten(List,Flat)

% trial 2 & trial 5
flatten(List, Flat) :- flattenAcc(List,[],FlatR), rev(FlatR,Flat).

flattenAcc([], L,L).
flattenAcc([H|T], A, R) :-
    H \= [],
    H \= [_|_],
    flattenAcc(T, [H|A],R).

flattenAcc([H|T],A,R) :-
    H = [],
    flattenAcc(T,A, R).

flattenAcc([H|T], A, R2) :-
    H = [_|_],
    flattenAcc(H, A, R),
    flattenAcc(T, R, R2). % note the result of first procedure is passed to second procedure as accumulator.

accRev([],A,A).
accRev([H|T],A,R) :- accRev(T,[H|A],R).

rev(L,R) :- accRev(L,[],R).

/*

% trial 1

flatten([],[]).
flatten([H|T], [H|T]) :- H \=[_|_], flatten(T,T).
    ,flatten(L,F).


% trial 2 & trial 5
flattenAcc([], L,L).
flattenAcc([H|T], A, R) :-
    H \= [],
    H \= [_|_],
    flattenAcc(T, [H|A],R).

flattenAcc([H|T],A,R) :-
    H = [],
    flattenAcc(T,A, R).

flattenAcc([H|T], A, R2) :-
    H = [_|_],
    flattenAcc(H, A, R),
    flattenAcc(T, R, R2).



%-- trial 3
% singliton members of a list,
% if a memeber of list A is not a list B, then it is singliton member
% of list A.
% If a member of list A is a list B, all B's singliton members are also
% A's singliton member

memberS([H|_], H) :- H \= [], H \= [_|_].
memberS([_|T], X) :- memberS(T,X).
memberS([H|_], X) :- H = [_|_], memberS(H,X).
memberS([H|T], X) :- H = [_|_], memberS(T,X).

% -- trial 4
member(X,[X|_]).
member(X,[_|T]) :-  member(X,T).


memberS(List,X) :- member(X, List), X \= [], X \= [_|_].
memberS(List,X) :- member(Y, List), Y = [_|_], memberS(Y,X).


*/
