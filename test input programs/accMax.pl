accMax([],A,A).
accMax([H|T],A,Max) :- H > A, accMax(T,H,Max).
accMax([H|T],A,Max) :- H =< A, accMax(T, A, Max).

max(List, Max) :- List = [H|_], accMax(List, H,Max).
