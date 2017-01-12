
% LPN Exercise 4.6
% List1 R List2 where List2 repeat every element of List1 twice.

twice([],[]).
twice([H1|T1], [H1,H1|T2]) :-
    twice(T1,T2).
